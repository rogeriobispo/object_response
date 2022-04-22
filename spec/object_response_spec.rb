
RSpec.describe ObjectResponse do
  let(:response) { ObjectResponse.get('https://weatherapi-com.p.rapidapi.com/ip.json') }
  let(:expected_message) { 'Invalid API key. Go to https://docs.rapidapi.com/docs/keys for more info.' }
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
    stub_request(:get, 'https://weatherapi-com.p.rapidapi.com/ip.json')
      .to_return(status: response_code, body: response_body.to_json, headers: {})
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
  end
end
