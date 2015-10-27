describe 'Ipsums API' do
  load "#{Rails.root}/db/seeds.rb"

  def auth_headers(user)
    token = Base64.encode64("#{user.token}:")
    { Accept: 'application/json', Authorization: "Basic #{token}" }
  end

  it 'returns all the ipsums' do
    get '/ipsums', {}, 'Accept' => 'application/json'
    body = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(body['ipsums'].length).not_to be nil
  end

  it 'returns an ipsum' do
    get '/ipsums/startup-ipsum', {}, 'Accept' => 'application/json'
    body = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(body['ipsum']['title']).to eql 'Startup Ipsum'
    expect(body['generated']['text']).to be_a String
    expect(body['ipsum']['generated_sample']).to be_a String
  end

  it 'can create a markov ipsum' do
    user = User.first
    title = Faker::Company.buzzword
    text = Faker::Lorem.paragraphs.join ' '
    post '/ipsums', { ipsum: { title: title, text: text } }, auth_headers(user)
    body = JSON.parse(response.body)

    expect(response.status).to eq 201
    expect(body['ipsum']['title']).to eql title
    expect(body['ipsum']['user']['username']).to eql user.username
  end

  it 'can create a lorem ipsum' do
    user = User.last
    title = Faker::Company.buzzword
    text = Faker::Lorem.paragraphs.join ' '
    post '/ipsums', { ipsum: { title: title, text: text, g_markov: 'false' } }, auth_headers(user)
    body = JSON.parse(response.body)

    expect(response.status).to eq 201
    expect(body['ipsum']['title']).to eql title
    expect(body['ipsum']['user']['username']).to eql user.username
    expect(Ipsum.last.g_markov).to eql false
  end
end
