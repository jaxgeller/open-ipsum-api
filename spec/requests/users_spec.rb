require 'base64'

describe 'Users API' do
  it 'returns a specific user' do
    get '/users/robert', {}, 'Accept' => 'application/json'
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body['user']['username']).to eql('robert')
  end

  it 'should be able to create a user' do
    params = { username: 'jaxdoge', email: 'j@j.com', password: 'password', password_confirmation: 'password' }
    post '/users', { user: params }, 'Accept' => 'application/json'
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body['status']).to eql('success')
    expect(body['token']).to be_a(String)
  end

  it 'should be able to delete a user' do
    user = User.last
    username = user.username
    token = Base64.encode64("#{user.token}:")
    delete "/users/#{username}", {}, 'Accept' => 'application/json', 'Authorization' => "Basic #{token}"
    expect(response.status).to eq 200
    expect(User.find_by_username(username)).to eql(nil)
  end

  it 'should be able to update password' do
    password = '123456password'
    user = User.last
    username = user.username
    token = Base64.encode64("#{user.token}:")
    put "/users/#{username}", { user: { password: password, password_confirmation: password } }, 'Accept' => 'application/json', 'Authorization' => "Basic #{token}"
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body['status']).to eql('updated')
  end
end
