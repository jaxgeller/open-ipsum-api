require 'rails_helper'

RSpec.describe "Ipsums", type: :request do
  describe "GET /ipsums" do
    it "works! (now write some real specs)" do
      get ipsums_path
      expect(response).to have_http_status(200)
    end
  end
end
