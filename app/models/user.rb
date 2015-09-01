class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :recoverable, :rememberable,
  devise :database_authenticatable, :trackable, :lockable, :validatable
  
  # validators
  validates :email, :type, presence: true
  validates :type, inclusion: %w( Admin Player )
  
  #touch file in /opt/keys
  after_create :touch_file
  
  # is admin
  def admin?
    self.is_a?(Admin)
  end

  def display_name
    if self.eligible
      return read_attribute(:display_name)
    else
      return read_attribute(:display_name) + " (ineligible)"
    end
  end

  # Grab the first 10 characters from the email and append the users ID.
  # Since we have 2 different scoreboards the ID is not sufficient, therefore
  # if we seed it with some additional data it should solve the issue.
  def key_file_name
    self.email.tr('^A-Za-z', '')[0..10] + self.id.to_s
  end

  def set_password; nil; end

  def set_password=(value)
    return nil if value.blank?
    self.password = value
    self.password_confirmation = value
  end
  
  
  private
  
  def touch_file
    `touch /opt/keys/#{self.key_file_name}` 
  end
  
end
