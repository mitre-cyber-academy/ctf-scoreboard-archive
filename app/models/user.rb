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
  
  
  private
  
  def touch_file
    `touch /opt/keys/#{self.email}` 
  end
  
end
