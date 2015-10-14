class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  validates :username, presence: true
end
