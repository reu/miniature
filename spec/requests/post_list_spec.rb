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
    visit "/first-post"

    page.should have_content "First post"
    page.should have_content "Congratulations, you have a blog!"

    page.should_not have_content "Second post"
  end
end
