describe DealsController do

  describe 'GET /' do

    it 'should return a list of deals' do
      # Deal.create(price: "14.99", url: "www.google.com")
      FactoryGirl.create :deal
      get "/api/v1/deals.json"

      p response.status
      binding.pry
      # p response.data
      expect(response.status).to eq 200
      expect(response.body).to eq Deal.all.to_json
    end
  end

end