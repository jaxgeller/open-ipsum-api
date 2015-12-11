class User < ActiveRecord::Base

  has_many :ipsums, dependent: :destroy, autosave: true
  has_secure_password

  before_create :generate_token

  validates :email, :username, uniqueness: true, presence: true
  validates :email, email: true

  validates :password, length: { minimum: 8 }, allow_blank: true

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

  def send_password_reset
    self.password_reset_token = SecureRandom.urlsafe_base64(30)
    self.password_reset_sent_at = Time.zone.now
    save!

    UserMailer.password_reset(self).deliver_now
  end

  def reset_password_reset
    self.password_reset_token = nil
    self.password_reset_sent_at = nil
    save!
  end
end
