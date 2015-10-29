require 'base64'

def auth_headers(user)
  token = Base64.encode64("#{user.token}:")
  { Accept: 'application/json', Authorization: "Basic #{token}" }
end

def user_params
  { username: 'jaxdoge', email: 'j@j.com', password: 'password', password_confirmation: 'password' }
end

describe 'Users API' do
  it 'returns a specific user' do
    get '/users/robert', {}, Accept: 'application/json'
    body = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(body['user']['username']).to eql 'robert'
  end

  it 'should be able to create a user' do
    post '/users', { user: user_params }, Accept: 'application/json'
    body = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(body['token']).to be_a String
    expect(body['username']).to be_a String
  end

  it 'should be able to delete a user' do
    user = User.last
    delete "/users/#{user.username}", {}, auth_headers(user)

    expect(response.status).to eq 200
    expect(User.find_by_username(user.username)).to eql nil
  end

  it 'should be able to update password' do
    user = User.last
    password = '123456password'
    params = { password: password, password_confirmation: password }
    put "/users/#{user.username}", { user: params }, auth_headers(user)

    body = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(body['status']).to eql 'updated'
  end
end
