class User < ActiveRecord::Base
  has_many :ipsums, dependent: :destroy, autosave: true
  has_secure_password

  before_create :generate_token

  validates :email, :username, uniqueness: true, presence: true
  validates :email, email: true
  validates :password, presence: { on: :create }, length: { minimum: 8, allow_blank: true }

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
