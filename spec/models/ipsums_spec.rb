require 'rails_helper'

RSpec.describe Ipsum, type: :model do
  p = 'password'
  e = 'jackson@gmail.com'
  u = 'jackson'
  User.create(username: u, email: e, password: p, password_confirmation: p)

  before(:each) do
    t = Faker::Company.buzzword
    u = User.all.sample
    @ipsum = Ipsum.new(title: t, user: u, text: Faker::Lorem.paragraph(10))
  end

  it 'should not be valid without title' do
    @ipsum.title = nil
    expect(@ipsum).not_to be_valid
  end

  it 'should not be valid without a user' do
    @ipsum.user = nil
    expect(@ipsum).not_to be_valid
  end

  # Text Validations

  it 'should not be valid without text' do
    @ipsum.text = nil
    expect(@ipsum).not_to be_valid
  end

  # G_Markov = false

  it 'should not be valid with 5 non-comma separated values' do
    @ipsum.text = Faker::Lorem.paragraph
    @ipsum.g_markov = false
    expect(@ipsum).not_to be_valid
  end

  it 'should not be valid with 5 comma separated values' do
    @ipsum.text = Faker::Lorem.words(5).join(', ')
    @ipsum.g_markov = false
    expect(@ipsum).not_to be_valid
  end

  it 'should be valid with 20 comma separated values' do
    @ipsum.text = Faker::Lorem.words(20).join(', ')
    @ipsum.g_markov = false
    expect(@ipsum).to be_valid
  end

  # G_Markov = true

  it 'should not be valid with 5 sentences of text with missing delimeters' do
    @ipsum.text = Faker::Lorem.sentences(5).join('').gsub(/\.|\?|\!/, '')
    expect(@ipsum).not_to be_valid
  end

  it 'should not be valid with 5 sentences of text' do
    @ipsum.text = Faker::Lorem.sentences(5).join('')
    expect(@ipsum).not_to be_valid
  end

  it 'should be valid with 10 sentences' do
    @ipsum.text = Faker::Lorem.sentences(10).join('.')
    expect(@ipsum).to be_valid
  end

  it 'should be able to create an ipsum' do
    expect(@ipsum).to be_valid
  end

  it 'should be able to generate text' do
    @ipsum.text = Faker::Lorem.paragraphs(20).join(' ')
    expect(@ipsum.generate(1)).to be_a String
  end
end
