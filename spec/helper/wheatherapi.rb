class WeatherApi
  include HTTParty
  base_uri 'https://address.com.br/'

  def address
    self.class.get('/address/06814210')
  end
end
