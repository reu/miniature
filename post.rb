class Post
  extend Enumerable

  def self.files
    Dir["posts/*.markdown"].sort_by { |file| File.stat(file).ctime }.reverse
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
  end

  def title
    @content.lines.first
  end

  def slug
    title.to_slug.normalize
  end

  def to_html
    Redcarpet.new(@content, :smart, :gh_blockcode).to_html
  end

  alias :to_s :to_html
end
