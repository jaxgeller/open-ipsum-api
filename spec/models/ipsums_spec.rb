require 'rails_helper'

RSpec.describe Ipsum, type: :model do
  Ipsum.destroy_all
  User.destroy_all

  User.create(username: 'jackson', email: 'jackson@gmail.com', password: 'password')

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

  it 'should be able to create an ipsum' do
    title = Faker::Company.buzzword
    Ipsum.create(title: title, text: Faker::Lorem.paragraphs, user: User.last)
    expect(Ipsum.find_by_title(title).title).to eql title
  end
end
