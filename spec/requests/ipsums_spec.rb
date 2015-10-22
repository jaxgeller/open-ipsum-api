describe 'Ipsums API' do
  load "#{Rails.root}/db/seeds.rb"

  it 'returns all the ipsums' do
    get '/ipsums', {}, 'Accept' => 'application/json'
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body['ipsums'].length).to eql(6)
  end

  it 'returns an ipsum' do
    get '/ipsums/startup-ipsum', {}, 'Accept' => 'application/json'
    expect(response.status).to eq 200
    body = JSON.parse(response.body)

    expect(body['ipsum']['title']).to eql('Startup Ipsum')
    expect(body['generated']['text']).to be_a (String)
  end

  it 'can create a markov ipsum' do
    user = User.first
    token = Base64.encode64("#{user.token}:")

    title = Faker::Company.buzzword
    text = Faker::Lorem.paragraphs.join ' '

    post '/ipsums', { ipsum: { title: title, text: text } }, 'Accept' => 'application/json', 'Authorization' => "Basic #{token}"
    body = JSON.parse(response.body)
    expect(response.status).to eq 201
    expect(body['ipsum']['title']).to eql(title)
    expect(body['ipsum']['user']['username']).to eql(user.username)
  end

  it 'can create a lorem ipsum' do
    user = User.last
    token = Base64.encode64("#{user.token}:")

    title = Faker::Company.buzzword
    text = Faker::Lorem.paragraphs.join ' '

    post '/ipsums', { ipsum: { title: title, text: text, g_markov: 'false' } }, 'Accept' => 'application/json', 'Authorization' => "Basic #{token}"
    body = JSON.parse(response.body)
    expect(response.status).to eq 201
    expect(body['ipsum']['title']).to eql(title)
    expect(body['ipsum']['user']['username']).to eql(user.username)

    expect(Ipsum.last.g_markov).to eql(false)
  end
end
