require "object_response/version"
require 'httparty'

module ObjectResponse 
  include HTTParty.included
end

module HTTParty
  class Response < Object
    def body_object
      @body_object ||= JSON.parse(@body, object_class: OpenStruct)
    end
  end
end

class StackExchange
  include ObjectResponse
  base_uri 'api.stackexchange.com'

  def initialize(service, page)
    @options = { query: { site: service, page: page } }
  end

  def questions
    self.class.get("/2.2/questions", @options)
  end

  def users
    self.class.get("/2.2/users", @options)
  end
end


StackExchange.new('stackoverflow', 1).questions.body_object.items.each do |question|
  puts question.title
end