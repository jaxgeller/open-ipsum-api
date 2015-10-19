require 'rails_helper'

RSpec.describe User, type: :model do

  it 'should not be valid with an invalid email ' do
    user = User.new(email: '')
    expect(user).not_to be_valid
  end

  it 'should not be valid without an email and username' do
    user = User.new(email: 'jackson@gmail.com', username: '')
    expect(user).not_to be_valid
  end

  it 'should be able to create a user' do
    User.create(email: 'jackson@gmail.com', username: 'jackson', password: 'password')
    expect(User.find_by_username('jackson')).not_to be nil
  end

  it 'should have a secure token' do
    User.create(email: 'jackson1@gmail.com', username: 'jackson1', password: 'password')
    expect(User.find_by_username('jackson1').token).not_to be nil
  end

  it 'should be able to make secure tokens' do
    User.create(email: 'jackson2@gmail.com', username: 'jackson2', password: 'password')
    user = User.find_by_username 'jackson2'
    user.token = nil
    user.generate_token
    expect(user.token).not_to be nil
  end

end
