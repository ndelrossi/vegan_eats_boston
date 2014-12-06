require 'rails_helper'

feature "User creates post" do

  let(:user) { create(:user) }
  before do
    sign_in user
  end

  scenario "user creates a post with title, content and image" do
    create_post_with("New Post Title", "Lorem ipsum", true)    

    expect(page).to have_content("Post created!") 
    expect(page).to have_content("New Post Title") 
    expect(page).to have_content("Lorem ipsum")
    expect(page).to have_xpath("//img[contains(@src, \"placeholder.jpg\")]")
  end

  scenario "user creates post without image" do
    create_post_with("New Post Title", "Lorem ipsum")    

    expect(page).to have_content("Post created!") 
    expect(page).to have_content("New Post Title") 
    expect(page).to have_content("Lorem ipsum")
  end

  scenario "user tries to create post without a title" do
    create_post_with("", "Lorem ipsum", true)

    expect(page).to have_content("Title can't be blank")
  end

  scenario "user tries to create post without content" do
    create_post_with("New Post Title")

    expect(page).to have_content("Content can't be blank")
  end

  def create_post_with(title="",content="",image=false)
    visit root_path
    first(:link, "Create Post").click
    fill_in "Title",   with: title
    fill_in "Content", with: content
    if image
      attach_file "post_image", "spec/support/uploads/placeholder.jpg"
    end
    click_button "Create post"
  end
end 
