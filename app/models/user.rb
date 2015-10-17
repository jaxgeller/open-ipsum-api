class User < ActiveRecord::Base
  has_many :ipsums

  has_secure_password
  before_create :generate_token

  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :token, uniqueness: true

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
