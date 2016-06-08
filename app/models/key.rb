class Key < ActiveRecord::Base
  belongs_to :player, foreign_key: :user_id
  validates :user_id, :key, :name, presence: true
  validate :validate_key_using_ssh_keygen

  def validate_key_using_ssh_keygen
    temp_key = Tempfile.new("ssh_key_#{player.email}_#{Time.now.to_i}")
    temp_key.write(key)
    temp_key.close
    system("ssh-keygen -l -f #{temp_key.path}")
    temp_key.delete
    errors.add(:key, 'This is not a valid SSH key') unless $CHILD_STATUS.success?
  end
end
