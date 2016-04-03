describe DealsController do

  describe 'GET /' do

    it 'should return a list of deals' do
      new_deal Deal.new(price: "14.99", url: "www.google.com")
      
      get deal_url({}, format: :json)

      expect(response.status).to eq 200
      expect(response.data).to eq Deal.all
    end
  end

end