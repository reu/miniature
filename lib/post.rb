require "date"
require "babosa"

class Post
  extend Enumerable

  attr_accessor :metadata, :title, :body, :date

  def self.posts_path=(path)
    @@posts_path = path
  end

  def self.posts_path
    @@posts_path ||= "posts"
  end

  def self.files
    Dir["#{posts_path}/*.markdown"]
  end

  def self.each
    files.each do |entry|
      File.open(entry) { |file| yield Post.new(file.read) }
    end
  end

  def self.all
    find_all.sort_by(&:date).reverse
  end

  def self.find_by_slug(slug)
    find { |post| post.slug == slug }
  end

  def initialize(data)
    yaml, @content = data.split(/\n\n/, 2)

    @metadata = YAML.load(yaml)

    @title = @metadata["title"]
    @body = @content.strip
    @date = @metadata["date"]
  end

  def slug
    @slug ||= @metadata["slug"] || title.to_slug.normalize
  end

  def path
    @path ||= date.strftime("/%Y/%m/%d/#{slug}")
  end
end
