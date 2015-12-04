require 'rails_helper'

RSpec.describe Ipsum, type: :model do
  p = 'password'
  User.create(username: 'jackson', email: 'jackson@gmail.com', password: p, password_confirmation: p)

  it 'should not be valid without title' do
    ipsum = Ipsum.new(title: nil)
    expect(ipsum).not_to be_valid
  end

  it 'should not be valid without text' do
    ipsum = Ipsum.new(text: nil)
    expect(ipsum).not_to be_valid
  end

  it 'should not be valid without a user' do
    ipsum = Ipsum.new(user: nil)
    expect(ipsum).not_to be_valid
  end

  it 'should not be valid without 2 sentences of text' do
    ipsum = Ipsum.new(text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.')
    expect(ipsum).not_to be_valid
  end

  it 'should not be valid without 10 words' do
    ipsum = Ipsum.new(text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.')
    expect(ipsum).not_to be_valid
  end

  it 'should be able to create an ipsum' do
    title = Faker::Company.buzzword
    Ipsum.create(title: title, text: Faker::Lorem.paragraphs, user: User.last)
    expect(Ipsum.find_by_title(title).title).to eql title
  end

  it 'should be able to generate text' do
    ipsum = Ipsum.new(text: Faker::Lorem.paragraphs.join(' '))
    expect(ipsum.generate(1)).to be_a String
  end
end
