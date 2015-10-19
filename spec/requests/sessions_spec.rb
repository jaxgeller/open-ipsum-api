require "base64"

describe "Sessions API" do

  it 'creates a new session' do
    user = User.last
    token = Base64.encode64("#{user.token}:")

    params = {user:{email:user.email, password: 'password'}}
    post '/signin',params,{"Accept"=>"application/json", "Authorization"=>"Basic #{token}"}
    expect(response.status).to eq 200
    body = JSON.parse(response.body)

    expect(body["status"]).to eql('success')
    expect(body["token"]).to be_a (String)
    expect(body["username"]).to eql(user.username)
  end

  it 'deletes a session' do
    user = User.last
    token = Base64.encode64("#{user.token}:")

    params = {user:{email:user.email, password: 'password'}}
    delete '/signout',params,{"Accept"=>"application/json", "Authorization"=>"Basic #{token}"}
    expect(response.status).to eq 200
    body = JSON.parse(response.body)

    expect(body["status"]).to eql('success')
    expect(Base64.encode64("#{User.last.token}:")).not_to eql(token)
  end
end
