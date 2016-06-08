class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :recoverable, :rememberable,
  devise :database_authenticatable, :trackable, :lockable, :validatable

  # validators
  validates :email, :type, presence: true
  validates :type, inclusion: %w( Admin Player )

  # is admin
  def admin?
    is_a?(Admin)
  end

  def set_password
    nil
  end

  def set_password=(value)
    return nil if value.blank?
    self.password = value
    self.password_confirmation = value
  end
end
