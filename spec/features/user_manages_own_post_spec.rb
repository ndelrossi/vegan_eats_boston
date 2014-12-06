require 'rails_helper'

feature "User manages own post" do
  let(:user) { create(:user) }
  before do
    sign_in user
  end

  scenario "user views own posts on profile page" do
    post1 = create(:post, title: "Post1", user: user)
    post2 = create(:post, title: "Post2", user: user)

    visit user_path(user)

    expect(page).to have_content("Post1")
    expect(page).to have_content("Post2")
  end

  scenario "user deletes own post" do
    post = create(:post, title: "FooPost", user: user)
    visit user_path(user)

    click_link "delete-post-#{post.id}"

    expect(page).to have_content("Post deleted")
    expect(page).not_to have_content("FooPost")
  end

  scenario "user updates own post" do
    post = create(:post, title: "FooPost", user: user)
    visit user_path(user)

    click_link "edit-post-#{post.id}"
    expect(page).to have_xpath("//input[@value='FooPost']")
    fill_in "Title",   with: "New Title"
    fill_in "Content", with: "No dolor vivendo per"
    click_button "Update post"

    expect(page).to have_content("Post updated")
    expect(page).to have_content("New Title")
    expect(page).to have_content("No dolor vivendo per")
    expect(page).not_to have_content("Foo Post")
  end

  scenario "user updates post with new image" do
    post = create(:post, title: "FooPost", user: user)
    visit user_path(user)

    click_link "edit-post-#{post.id}"
    attach_file "post_image", "spec/support/uploads/new_image.jpg"
    click_button "Update post"

    expect(page).to have_content("Post updated")
    expect(page).to have_xpath("//img[contains(@src, \"new_image.jpg\")]")
  end
end
    
    
    

