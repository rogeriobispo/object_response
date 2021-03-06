# ObjectResponse

    Provide response to http party as object

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'object_response'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install object_response

## Usage

# Use the class methods to get down to business quickly
```ruby
response = ObjectResponse.get('http://api.stackexchange.com/2.2/questions?site=stackoverflow')

puts response.body, response.code, response.message, response.headers.inspect


object_response = response.body_object #new method response as object

# old version
puts JSON.parse(response.body)['items'].first['owner']['display_name']
# as object
puts object_response.items.first.owner.display_name
```

```ruby
# Or wrap things up in your own class
class StackExchange
  include HTTParty
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

stack_exchange = StackExchange.new("stackoverflow", 1).questions
# older version
puts JSON.parse(stack_exchange.body)['items'].first['owner']['display_name']
# new version
puts stack_exchange.body_object.items.first.owner.display_name
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[rogeriobispo]/object_response. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/rogeriobispo/object_response/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ObjectResponse project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rogeriobispo/object_response/blob/master/CODE_OF_CONDUCT.md).

Contributing
Fork the project.
Run bundle
Run bundle exec rake
Make your feature addition or bug fix.
Add tests for it. This is important so I don't break it in a future version unintentionally.
Run bundle exec rake (No, REALLY :))
Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself in another branch so I can ignore when I pull)
Send me a pull request. Bonus points for topic branches.