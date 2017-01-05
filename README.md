# QuickBlox

Quickblox ruby interface.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quick_blox'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quick_blox

## Usage

#### Configuration

```ruby
QuickBlox.configure do |config|
  config.host = ENV['QUICKBLOX_HOST']
  config.application_id = ENV['QUICKBLOX_APPLICATION_ID']
  config.auth_key = ENV['QUICKBLOX_AUTH_KEY']
  config.auth_secret = ENV['QUICKBLOX_AUTH_SECRET']
end
```

#### Session

```ruby
  session = QuickBlox::Session.new 
  
  #<QuickBlox::Session:0x007f3078130b28 @_id="586df8dda0eb474700000018", @application_id=51120, @created_at="2017-01-05T07:42:21Z", @device_id=0, @nonce=1483176794, @token="bcc14b44d428cdab14a0614a1b3d9603b700c7b0", @ts=1483602140, @updated_at="2017-01-05T07:42:21Z", @user_id=0, @id=22488> 

  
  session.info 
  session.destroy
```

#### Users

```ruby

   user = QuickBlox::User.create session, login: 'test_user', password: 'secretpassword'
   #<QuickBlox::User:0x00000006c02d48 @id=22433881, @owner_id=64395, @full_name=nil, @email=nil, @login="test_user", @phone=nil, @website=nil, @created_at="2017-01-05T07:46:22Z", @updated_at="2017-01-05T07:46:22Z", @last_request_at=nil, @external_user_id=nil, @facebook_id=nil, @twitter_id=nil, @blob_id=nil, @custom_data=nil, @twitter_digits_id=nil, @user_tags=nil> 

   user = QuickBlox::User.show session, user.id
  
  session.info 
  session.destroy
```

#### User Session

```ruby

   user_session = QuickBlox::UserSession.new session, login: 'test_user', password: 'secretpassword' # upgrade to user session
   user_session.destroy # downgrade to application session
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/quick_blox. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

