class Key < ActiveRecord::Base
  
  attr_accessible :key, :name, :user_id
  belongs_to :player, foreign_key: :user_id
  validates :user_id, :key, :name, presence: true
  validate :validate_key_using_ssh_keygen
  
  def validate_key_using_ssh_keygen
    temp_key = Tempfile.new("ssh_key_#{self.player.email}_#{Time.now.to_i}")
    temp_key.write(self.key)
    temp_key.close
    system("ssh-keygen -l -f #{temp_key.path}")
    temp_key.delete
    unless $?.success?
      errors.add(:key, "This is not a valid SSH key")
    end
  end
  
end
