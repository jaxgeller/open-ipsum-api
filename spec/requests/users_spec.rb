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
    expect(body['status']).to eql 'success'
    expect(body['token']).to be_a String
  end

  it 'should be able to delete a user' do
    delete "/users/#{user.username}", {}, auth_headers(User.last)

    expect(response.status).to eq 200
    expect(User.find_by_username(user.username)).to eql nil
  end

  it 'should be able to update password' do
    password = '123456password'
    user = { password: password, password_confirmation: password }
    put "/users/#{user.username}", { user: params }, auth_headers(User.last)

    body = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(body['status']).to eql 'updated'
  end
end
