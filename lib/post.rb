class Post
  extend Enumerable

  attr_accessor :title, :body

  def self.posts_path=(path)
    @@posts_path = path
  end

  def self.posts_path
    @@posts_path ||= "posts"
  end

  def self.files
    Dir["#{posts_path}/*.markdown"].sort_by { |file| File.stat(file).ctime }.reverse
  end

  def self.each
    files.each do |entry|
      File.open(entry) { |file| yield Post.new(file.read) }
    end
  end

  def self.find_by_slug(slug)
    find { |post| post.slug == slug }
  end

  def initialize(content)
    @content = content
    @title   = @content.lines.first.sub(/\A\#?\s/, "").strip
    @body    = @content.split(/\n/, 2).last.strip
  end

  def slug
    title.to_slug.normalize
  end
end
