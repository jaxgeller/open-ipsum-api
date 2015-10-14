class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
end
