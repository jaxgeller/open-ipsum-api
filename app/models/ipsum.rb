require 'libmarkov'

class Ipsum < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_text, :against => [:title, :text]

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user

  validates_associated :user
  validates :title, :slug, uniqueness: true
  validates :title, :text, :user, presence: true

  # validates :text, length: {
  #   minimum: 2,
  #   tokenizer: lambda { |str| str.split(/\.|\?|\!/)},
  #   too_short: "must have at least %{count} sentences",
  # }, if: :is_markov?

  # validates :text, length: {
  #   minimum: 10,
  #   tokenizer: lambda { |str| str.split(/\s+/)},
  #   too_short: "must have at least %{count} words",
  # }, if: :is_markov?

  def is_markov?
    self.g_markov
  end

  def generate(count)
    count = 10 if count == 0
    if self.g_markov
      g = Libmarkov::Generator.new(self.text)
    else
      g = Simplelorem::Generator.new(self.text)
    end
    g.generate(count)
  end
end
