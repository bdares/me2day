# The Me2day Ruby Gem

A Ruby interface to the M2day API.  Based on the twitter gem.


Authorization
=====

 * Get an application key from http://me2day.net/me2/app/get_appkey
 * Configure Me2day with the application key:
```ruby
    Me2day.configure do |config|
      config.application_key = 'my_application_key'
    end
```

 * Redirect the user to the authorization URL:

```ruby
    redirect_to Me2day.auth_url
```

or

```ruby
    <%= link_to 'Log in', Me2day.auth_url %>
```
      
Basic Usage
=====

 * Configure Me2day with your credentials:

```ruby
    Me2day.configure do |config|
      config.application_key = 'my_application_key'
      config.user_id = 'user_id'
      config.user_key = 'user_key'
    end
```    

 * Instantiate a client:

```ruby
    client = Me2day::Client.new
```
    
 * Call the API:

```ruby
    client.noop
    client.get_posts("codian", :from => '20120101').each do |post|
      puts "#{post.author.name}: #{post.pubDate} : #{post.content}"
    end
```