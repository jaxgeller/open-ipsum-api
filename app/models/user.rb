class User < ActiveRecord::Base
  has_secure_password
  before_create :generate_token

  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :token, uniqueness: true

  private

    def generate_token
      self.token = SecureRandom.urlsafe_base64
    end
end
