class User < ActiveRecord::Base
  has_many :ipsums
  has_secure_password

  before_create :generate_token

  validates :email, :username, uniqueness: true, presence: true
  validates :email, email: true

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
