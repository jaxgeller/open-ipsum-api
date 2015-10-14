require "rails_helper"

RSpec.describe IpsumsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ipsums").to route_to("ipsums#index")
    end

    it "routes to #show" do
      expect(:get => "/ipsums/1").to route_to("ipsums#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ipsums").to route_to("ipsums#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ipsums/1").to route_to("ipsums#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ipsums/1").to route_to("ipsums#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ipsums/1").to route_to("ipsums#destroy", :id => "1")
    end

  end
end
