require "object_response/version"
require 'httparty'

module ObjectResponse 
  include HTTParty

  class Error < StandardError; end
end

module HTTParty
  class Response < Object
    def body_object
      @body_object ||= JSON.parse(@body, object_class: OpenStruct)
    end
  end
end
