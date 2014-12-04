require 'rails_helper'

feature "Admin manages posts" do
  let(:admin) { create(:admin) }
  let!(:post) { create(:post) }

  scenario "deleting a post" do
    sign_in admin
    visit_admin_posts_page

    find("#delete-post-#{post.id}").click

    expect(page).to have_content("Post deleted")
    visit_admin_posts_page
    expect(page).not_to have_content("Lorem ipsum")
  end

  scenario "editing a post" do
    sign_in admin
    visit_admin_posts_page

    find(:xpath, "//a[@href='/posts/#{post.id}/edit']").click
    fill_in "Title", with: "New Title"
    click_button "Update post"

    expect(page).to have_content("Post updated")
    visit_admin_posts_page
    expect(page).to have_content("New Title")
  end

  scenario "approving a post" do
    sign_in admin
    visit_admin_posts_page

    find(:xpath, "//a[@href='/admin/posts/approve/#{post.id}']").click

    expect(page).to have_content("Post approved")
    click_link "Posts"
    expect(page).to have_content("unapprove / edit / delete")
    visit root_path
    expect(page).to have_content("Lorem ipsum")
  end

  scenario "unapproving a post" do
    post.update_attribute(:approved, true)
    sign_in admin
    visit_admin_posts_page

    find(:xpath, "//a[@href='/admin/posts/unapprove/#{post.id}']").click

    expect(page).to have_content("Post unapproved")
    click_link "Posts"
    expect(page).to have_content("approve / edit / delete")
    visit root_path
    expect(page).not_to have_content("Lorem ipsum")
  end

  def visit_admin_posts_page
    visit admin_dashboard_path
    click_link "Posts"
  end
end
