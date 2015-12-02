require 'base64'

def auth_headers(user)
  token = Base64.encode64("#{user.token}:")
  { Accept: 'application/json', Authorization: "Basic #{token}" }
end

describe 'Sessions API' do
  it 'creates a new session' do
    user = User.last
    params = { user: { email: user.email, password: 'password' } }
    post '/signin', params, auth_headers(user)
    body = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(body['token']).to be_a String
    expect(body['username']).to eql user.username
    expect(body['email']).to eql user.email
  end

  it 'deletes a session' do
    user = User.last

    params = { user: { email: user.email, password: 'password' } }
    delete '/signout', params, auth_headers(user)
    JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(Base64.encode64("#{User.last.token}:")).not_to eql user.token
  end
end
