require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'coveralls'
Coveralls.wear!
require "minitest/matchers"
require 'minitest/autorun'
require 'mocha/setup'
