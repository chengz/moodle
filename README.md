# Moodle
[![Build Status](https://travis-ci.org/robertboloc/moodle.png)](https://travis-ci.org/robertboloc/moodle)
[![Code Climate](https://codeclimate.com/github/robertboloc/moodle.png)](https://codeclimate.com/github/robertboloc/moodle)
[![Gem Version](https://badge.fury.io/rb/moodle.png)](http://badge.fury.io/rb/moodle)
Ruby gem to interact with the Moodle via web services.

## Table of contents
- [Installation](#installation)
- [Usage](#usage)
- [Protocols](#protocols)
- [Functions](#functions)

## Installation
```shell
gem install moodle
```

## Usage
To use this gem you must first have configured the moodle web services. To do that use the official documentation.

### Without a token
If you don't have a token, you can create an instance of the client using your username and password.
The client will then obtain a token for you.
```ruby
client = Moodle::Client.new(
  :username => 'myusername',
  :password => 'secret',
  :protocol => 'rest',
  :domain => 'http://mydomain/moodle',
  :service => 'myservice',
  :format => 'json'
)
```

### Using a token
If you already have a token the client can be created without a username and password:
```ruby
client = Moodle::Client.new(
  :token => 'b31dde13bade28f25d548a31fa994816',
  :protocol => 'rest',
  :domain => 'http://mydomain/moodle',
  :service => 'myservice',
  :format => 'json'
)
```

### Short syntax
When creating the client you can use a shorter and simpler syntax:
```ruby
client = Moodle.new(
  :token => 'b31dde13bade28f25d548a31fa994816',
  :protocol => 'rest',
  :domain => 'http://mydomain/moodle',
  :service => 'myservice',
  :format => 'json'
)
```

### Global configuration
Configuration can be set globally.
```ruby
# Using a hash
Moodle.configure(
  :token => 'b31dde13bade28f25d548a31fa994816',
  :protocol => 'rest',
  :domain => 'http://mydomain/moodle',
  :service => 'myservice',
  :format => 'json'
)

# Using a file
Moodle.configure_with(/path/to/yaml/file)

client = Moodle.new
```

Once you have an instance of the client it's only a matter of calling the moodle web services functions.

## Protocols
Moodle implements 4 protocols: AMF, REST, SOAP, XML-RPC. Currently this gem only supports REST.

## Functions
These are the currently implemented web services functions:

### core_user_get_users_by_field
Retrieve users information for a specified unique field
```ruby
user = client.core_user_get_users_by_field('id', [2])

user.id                   # => 2,
user.firstname            # => Test
user.lastname             # => User
user.fullname             # => Test User
user.email                # => webservicetester@gmail.com
user.firstaccess          # => 139240932,
user.lastaccess           # => 1392471263
user.profileimageurlsmall # => http://mydomain/moodle/pluginfile.php/5/user/icon/f2
user.profileimageurl      # => http://mydomain/moodle/pluginfile.php/5/user/icon/f1
```