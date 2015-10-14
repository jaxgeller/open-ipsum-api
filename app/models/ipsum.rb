require 'libmarkov'

class Ipsum < ActiveRecord::Base
  attr_accessor :generated

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :text, presence: true
  validates :title, uniqueness: true

  def generate(count=10)
    g = Libmarkov::Generator.new(self.text)
    self.generated = g.generate(count)
  end
end
