require "rubygems"
require "bundler"

Bundler.require(:default, ENV["RACK_ENV"])

require "./blog"
run Blog
