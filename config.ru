require "rubygems"
require "bundler"

Bundler.require

set :static, true

require "./miniature"
require "./post"

run Miniature
