class Ipsum < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user

  validates :title, :slug, uniqueness: true
  validates :title, :text, :user, presence: true
end
