namespace :scoreboard do
  namespace :user do
    desc 'Add a user to the Game'
    task :add, [:player_login, :player, :password] => [:environment] do |_t, args|
      p = Game.instance.players.find_by_email("#{args[:player_login]}")
      if p.nil?
        p = Player.new(email: to_s(args[:player_login]), password: to_s(args[:password]), game_id: Game.instance.id)
        p.display_name = to_s(args[:player])
        p.save!
      else
        puts 'User Exists'
      end
    end
  end

  namespace :db do
    desc 'Perform a dump of the production database and copy to Amazon S3'
    task backup: :environment do
      # load rails env
      config = ActiveRecord::Base.configurations[Rails.env]
      database = config['database']
      ENV['PGPASSWORD'] = (config['password'] || '')

      # perform dump
      date = Time.zone.now.strftime('%Y-%m-%d-%H-%M')
      path = "/tmp/#{date}.pgdump"
      `rm -f "#{path}"`
      `/usr/bin/pg_dump "#{database}" > "#{path}"`

      # send to s3
      AWS::S3::Base.establish_connection!(
        :access_key_id => Rails.configuration.s3_access_key_id,
        :secret_access_key => Rails.configuration.s3_secret_access_key
      )
      bucket = Rails.configuration.s3_bucket_name
      AWS::S3::Bucket.create(bucket)
      AWS::S3::S3Object.store(File.basename(path), open(path), Rails.configuration.s3_bucket_name)

      # delete
      `rm -f "#{path}"`
    end

    desc 'Perform a restore of the production database given the date stamp as
      seen on S3'
    task restore: [:environment, 'db:drop', 'db:create'] do
      # load rails env
      config = ActiveRecord::Base.configurations[Rails.env]
      database = config['database']
      ENV['PGPASSWORD'] = (config['password'] || '')

      # get from s3
      AWS::S3::Base.establish_connection!(
        :access_key_id     => Rails.configuration.s3_access_key_id,
        :secret_access_key => Rails.configuration.s3_secret_access_key
      )
      date = ENV['date']
      path = "/tmp/#{date}.pgdump"
      `rm -f "#{path}"`
      open(path, 'w') do |file|
        AWS::S3::S3Object.stream(File.basename(path), Rails.configuration.s3_bucket_name) do |chunk|
          file.write chunk
        end
      end

      # import into postgres
      `/usr/lib/postgresql/8.4/bin/psql "#{database}" < "#{path}"`

      # delete
      `rm -f "#{path}"`
    end
  end

  namespace :certificates do
    desc 'Sync user certificates between scoreboard and VPN box'
    task copy: [:environment] do
      system "/usr/bin/unison -auto -batch -ignorearchives /opt/keys ssh://#{Rails.configuration.jumpbox[:ip]}//opt/openvpn_keys"
    end
  end
end
