describe "Ipsums API" do

  load "#{Rails.root}/db/seeds.rb"

  it "returns all the ipsums" do
    get "/ipsums", {}, { "Accept" => "application/json" }
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body["ipsums"].length).to eql(6)
  end

  it "returns an ipsum" do
    get "/ipsums/startup-ipsum", {}, { "Accept" => "application/json" }
    expect(response.status).to eq 200
    body = JSON.parse(response.body)

    expect(body["ipsum"]["title"]).to eql('Startup Ipsum')
  end

  it "returns an ipsum" do
    get "/ipsums/startup-ipsum", {}, { "Accept" => "application/json" }
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body["ipsum"]["title"]).to eql('Startup Ipsum')
    expect(body["generated"]["text"]).to be_a (String)
  end

  # it "can create an ipsum" do
  #   get "/ipsums/startup-ipsum", {}, { "Accept" => "application/json" }
  #   expect(response.status).to eq 200
  #   body = JSON.parse(response.body)
  #   expect(body["ipsum"]["title"]).to eql('Startup Ipsum')
  #   expect(body["generated"]["text"]).to be_a (String)
  # end



end
