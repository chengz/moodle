# Moodle
[![Build Status](https://travis-ci.org/chengz/moodle.svg)](https://travis-ci.org/chengz/moodle)
[![Code Climate](https://codeclimate.com/github/chengz/moodle/badges/gpa.svg)](https://codeclimate.com/github/chengz/moodle)
[![Coverage Status](https://coveralls.io/repos/chengz/moodle/badge.png)](https://coveralls.io/r/chengz/moodle)
[![Gem Version](https://badge.fury.io/rb/moodle.png)](http://badge.fury.io/rb/moodle)

Ruby gem to interact with Moodle via web services.

## Table of contents
- [Installation](#installation)
- [Usage](#usage)
- [Protocols](#protocols)
- [Services](#services)

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

## Services
These are the currently implemented web services functions:

### Cohorts

#### core_cohort_get_cohorts
Returns cohort details
```ruby
cohorts = client.core_cohort_get_cohorts([1])

cohorts.each do |cohort|
  cohort.id                # => 1
  cohort.name              # => Test
  cohort.idnumber          # => 1
  cohort.description       # => Test Cohort
  cohort.descriptionformat # => 1
end
```

### Courses

#### core_course_get_courses
Retrieve courses details by ids
```ruby
courses = client.core_course_get_courses([2, 3])

courses.each do |course|
  course.id                # => 2
  course.shortname         # => T
  course.categoryid        # => 1
  course.categorysortorder # => 10002
  course.fullname          # => Test
  course.idnumber          # => TX
  course.summary           # => test
  course.summaryformat     # => 1
  course.format            # => weeks
  course.showgrades        # => 1
  course.newsitems         # => 5
  course.startdate         # => 1393718400
  course.numsections       # => 10
  course.maxbytes          # => 0
  course.showreports       # => 0
  course.visible           # => 1
  course.hiddensections    # => 0
  course.groupmode         # => 0
  course.groupmodeforce    # => 0
  course.defaultgroupingid # => 0
  course.timecreated       # => 1393693092
  course.timemodified      # => 1393693092
  course.enablecompletion  # => 0
  course.completionnotify  # => 0
  course.lang              # => en
  course.forcetheme        # => test
  course.courseformatoptions.each do |format|
    format.name            # => numsections
    value                  # => 10
  end
end
```

### Enrolment

#### enrol_manual_enrol_user
Enroll user to a specific course
```ruby
enrolments = client.enrol_manual_enrol_user(:user_id => 2, :role_id =>
2, :course_id => 3)

enrolments.each do |enrolment|
  enrolment.id              # => 3
  enrolment.user_id         # => 2
  enrolment.role_id         # => 2
  enrolment.course_id       # => 3
end
```

### Users

#### core_user_get_users_by_field
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

#### core_user_get_users
Search for users matching the criteria
```ruby
users = client.core_user_get_users({:email => 'suchemail@test.com'})

users.each do |user|
  user.id                   # => 2,
  user.firstname            # => Test
  user.lastname             # => User
  user.fullname             # => Test User
  user.email                # => suchemail@test.com
  user.firstaccess          # => 139240932,
  user.lastaccess           # => 1392471263
  user.profileimageurlsmall # => http://mydomain/moodle/pluginfile.php/5/user/icon/f2
  user.profileimageurl      # => http://mydomain/moodle/pluginfile.php/5/user/icon/f1
end
```

#### core_user_create_user
Create user
```ruby
users = client.core_user_create_user({:email => 'suchemail@test.com',
:firstname => 'Test', :lastname => 'User'})

users.each do |user|
  user.id                   # => 2
  user.firstname            # => Test
  user.lastname             # => User
  user.fullname             # => Test User
  user.email                # => suchemail@test.com
  user.firstaccess          # => 139240932
  user.lastaccess           # => 1392471263
end
```

#### core_user_update_user
Update user
```ruby
users = client.core_user_update_user({:id => 2, :firstname => 'OtherName'})

users.each do |user|
  user.id                   # => 2
  user.firstname            # => Test
  user.lastname             # => User
  user.fullname             # => Test User
  user.email                # => suchemail@test.com
  user.firstaccess          # => 139240932
  user.lastaccess           # => 1392471263
end
```

### Webservices

#### core_webservice_get_site_info
Return some site info / user info / list web service functions
```ruby
info = client.core_webservice_get_site_info

info.sitename       # => Webservice test
info.username       # => test
info.firstname      # => Test
info.lastname       # => Webservice
info.fullname       # => Test Webservice
info.lang           # => en
info.userid         # => 3
info.siteurl        # => http://mydomain/moodle
info.userpictureurl # => http://mydomain/moodle/pluginfile.php/15/user/icon/f1
info.functions.each do |f|
  f.name            # => core_user_get_users_by_field
  f.version         # => 2013111800.09
end
info.downloadfiles  # => 0
info.uploadfiles    # => 0
info.release        # => 2.6+ (Build: 20140110)
info.version        # => 2013111800.09
info.mobilecssurl   # => ""
```
