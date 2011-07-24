require "spec_helper"

describe Post do
  let(:post) { Post.new "title: Title\ndate: 2010-10-10\n\nContent, and some more __content__.\n" }

  describe "#title" do
    subject { post.title }
    it { should == "Title" }
  end

  describe "#body" do
    subject { post.body }
    it { should == "Content, and some more __content__." }
  end

  describe "#slug" do
    subject { post.slug }
    it { should == "title" }

    context "when specified on metadata" do
      let(:post) { Post.new "title: Post\ndate: 2010-10-10\nslug: a-nice-post\n\nPost" }
      it { should == "a-nice-post" }
    end
  end

  describe "#date" do
    subject { post.date }
    it { should == Date.parse("2010-10-10") }
  end

  describe "#path" do
    subject { post.path }
    it { should == "/2010/10/10/title" }
  end
end
