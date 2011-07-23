require "rubygems"
require "bundler"

Bundler.require(:default, :test)

require "capybara/rspec"

require File.join(File.dirname(__FILE__), "../lib/miniature")

Capybara.app = Miniature

Post.posts_path = "spec/fixtures/posts"
