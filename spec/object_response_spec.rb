require 'helper/wheatherapi'
RSpec.describe ObjectResponse do
  let(:response) { ObjectResponse.get(url + path) }
  let(:url) { 'https://address.com.br/' }
  let(:path) { 'address/06814210' }
  let(:response_code) { 200 }
  let(:response_body) do
    {
      address: {
        city: 'São Paulo',
        country: 'Brazil',
        country_code: 'BR',
        number: {
          older: 1,
          newer: 2
        }
      }
    }
  end
  
  before do
    stub_request(:get, url + path).
      to_return(status: response_code, body: response_body.to_json, headers: {})
  end

  describe '#body_object' do
    it 'returns a OpenStruct object' do
      expect(response.body_object).to be_a(OpenStruct)
    end

    it 'returns the expected object' do
      expect(response.body_object.address.city).to eq('São Paulo')
    end

    it 'returns deepest expected object' do
      expect(response.body_object.address.number.newer).to eq(2)
    end

    describe 'when is embedded in another object' do
      let(:response) { WeatherApi.new.address }
  
      before do
        stub_request(:get, "https://address.com.br/address/06814210").
          with(
            headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
          }).
          to_return(status: response_code, body: response_body.to_json, headers: {})
      end

      it 'returns a OpenStruct object' do
        expect(response.body_object).to be_a(OpenStruct)
      end
  
      it 'returns the expected object' do
        expect(response.body_object.address.city).to eq('São Paulo')
      end
  
      it 'returns deepest expected object' do
        expect(response.body_object.address.number.newer).to eq(2)
      end
    end
  end
end
