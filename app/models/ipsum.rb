require 'libmarkov'

class Ipsum < ActiveRecord::Base
  extend FriendlyId
  include PgSearch

  before_save :sanitize, :generate_sample
  belongs_to :user

  pg_search_scope :search_by_text, against: [:title, :text], using: { tsearch: { prefix: true } }

  friendly_id :title, use: :slugged

  def generate(count)
    count = 30 if count == 0
    if g_markov
      g = Libmarkov::Generator.new(text)
    else
      g = Simplelorem::Generator.new(text)
    end
    g.generate(count)
  end

  def sanitize
    if !self.g_markov
      self.text = text.gsub(/\t/, ' ')
      self.text = text.gsub(/\n/, ',')
    else
      self.text = text.gsub(/\n|\t/, ' ')
    end

  end

  def generate_sample
    self.generated_sample = generate(5)
  end

  validates_associated :user
  validates :title, :slug, uniqueness: true
  validates :title, :text, :user, presence: true

  validates :text, length: { minimum: 125, maximum: 7500 }, allow_blank: false
  validates :text, length: {
    minimum: 10,
    tokenizer: ->(str) { str.split(/\.|\?|\!/) },
    too_short: 'must have at least %{count} sentences'
  }, if: :markov?

  validates :text, length: {
    minimum: 20,
    tokenizer: ->(str) { str.split(',') },
    too_short: 'must have at least %{count} comma separated values'
  }, if: :reg?

  private

  def markov?
    g_markov
  end

  def reg?
    !g_markov
  end
end
