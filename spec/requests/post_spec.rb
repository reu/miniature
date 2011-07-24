require "spec_helper"

feature "View posts" do
  scenario "list all posts" do
    visit "/"

    page.should have_content "First post"
    page.should have_content "Congratulations, you have a blog!"

    page.should have_content "Second post"
    page.should have_content "Hey, I am a second post =]"
  end

  scenario "show a single post" do
    visit "/"

    click_link "First post"

    page.should have_content "First post"
    page.should have_content "Congratulations, you have a blog!"

    page.should_not have_content "Second post"
  end

  scenario "handle 404 error" do
    visit "/unavailable-content"

    page.status_code.should == 404
    page.should have_content "Post not found"
  end
end
