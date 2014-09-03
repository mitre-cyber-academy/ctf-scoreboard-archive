namespace :scoreboard do
  
  
  namespace :user do
    
    desc 'Add a user to the Game'
    task :add, [:player_login, :player, :password] => [:environment] do |t, args|
      p = Game.instance.players.find_by_email("#{args[:player_login]}")
      if p.nil?
        p = Player.new(email: "#{args[:player_login]}", password: "#{args[:password]}", game_id: Game.instance.id)
        p.display_name = "#{args[:player]}"
        p.save!
      else
        puts "User Exists"
      end
      
      
    end
  end
  
  namespace :db do
    
    desc 'Perform a dump of the production database and copy to Amazon S3'
    task :backup => :environment do
      
      # load rails env
      config = ActiveRecord::Base.configurations[Rails.env]
      user = config['user'] || config['username']
      database = config['database']
      ENV['PGPASSWORD'] = (config['password'] || '')
      
      # perform dump
      date = Time.now.strftime('%Y-%m-%d-%H-%M')
      path = "/tmp/#{date}.pgdump"
      %x[rm -f "#{path}"]
      %x[/usr/bin/pg_dump "#{database}" > "#{path}"]
      
      # send to s3
      AWS::S3::Base.establish_connection!(
        :access_key_id     => Rails.configuration.s3_access_key_id,
        :secret_access_key => Rails.configuration.s3_secret_access_key
      )
      bucket = Rails.configuration.s3_bucket_name
      AWS::S3::Bucket.create(bucket)
      AWS::S3::S3Object.store(File.basename(path), open(path), Rails.configuration.s3_bucket_name)
      
      # delete
      %x[rm -f "#{path}"]
      
    end
    
    desc 'Perform a restore of the production database given the date stamp as seen on S3'
    task :restore => [:environment, "db:drop", "db:create"] do
      
      # load rails env
      config = ActiveRecord::Base.configurations[Rails.env]
      user = config['user'] || config['username']
      database = config['database']
      ENV['PGPASSWORD'] = (config['password'] || '')
      
      # get from s3
      AWS::S3::Base.establish_connection!(
        :access_key_id     => Rails.configuration.s3_access_key_id,
        :secret_access_key => Rails.configuration.s3_secret_access_key
      )
      date = ENV['date']
      path = "/tmp/#{date}.pgdump"
      %x[rm -f "#{path}"]
      open(path, 'w') do |file|
          AWS::S3::S3Object.stream(File.basename(path), Rails.configuration.s3_bucket_name) do |chunk|
            file.write chunk
          end
        end
      
      # import into postgres
      %x[/usr/lib/postgresql/8.4/bin/psql "#{database}" < "#{path}"]
      
      # delete
      %x[rm -f "#{path}"]
      
    end
    
  end
  
  namespace :keys do
    desc 'Move keys from the scoreboard onto the appropriate Jumpboxes'
    task :copy => [:environment] do
      
      require 'net/ssh'
      Net::SSH.start(Rails.configuration.jumpbox[:ip], Rails.configuration.jumpbox[:user]) do |ssh|
        Game.instance.players.each do |player|
          
          # gather folders
          ssh_dir = File.join('/', 'home', "#{player.email}", '.ssh')
          
          # make sure we have an ssh dir for this user
          unless ssh.exec!("stat #{ssh_dir}").match(/No such file/i)
            puts "Adding #{player.email}'s keys to Jump Box"
            authorized_keys_path = File.join(ssh_dir, "authorized_keys")
            
            # make me the owner and stomp
            ssh.exec!(%[sudo chown #{Rails.configuration.jumpbox[:user]} "#{authorized_keys_path}"])
            ssh.exec!(%[truncate --size 0 "#{authorized_keys_path}"])
            
            # place keys and newlines
            player.keys.each do |key|
              ssh.exec!(%[echo "#{key.key}" >> "#{authorized_keys_path}"])
              ssh.exec!(%[echo "" >> "#{authorized_keys_path}"])
              ssh.exec!(%[echo "" >> "#{authorized_keys_path}"])
            end
            
            # adjust permissions and owner
            ssh.exec!(%[chmod 644 "#{authorized_keys_path}"])
            ssh.exec!(%[sudo chown #{player.email} "#{authorized_keys_path}"])
            
          else
            puts "Unable to add #{player.email}'s keys to #{ssh_dir}"
          end
          
        end
      end
      
    end
  end

  namespace :certificates do
    desc 'Sync user certificates between scoreboard and VPN box'
    task :copy => [:environment] do
      
      system "/usr/bin/unison -auto -batch -ignorearchives /opt/keys ssh://#{Rails.configuration.jumpbox[:ip]}//opt/openvpn_keys"
      
    end
  end
 
end
