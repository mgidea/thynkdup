require 'spec_helper'

feature "User edits nutshell", %Q{
  As an authenticated User
  I want edit my nutshell
  So that I my thoughts and changes are reflected
} do

#   Acceptance Criteria
# * Only an authenticated user of the specific nutshell can edit it
# * If an unauthenticated user attempts to view the page they will be redirected to sign in
# * If the wrong user attempts to update they will be redirected to their page
# * If it fails to update the user will be notified

  scenario "User successfully updates nutshell" do
    user = FactoryGirl.create(:user)
    category = FactoryGirl.create(:category)
    category2 = FactoryGirl.create(:category, name: 'music')
    category3 = FactoryGirl.create(:category, name: 'politics')
    idea = FactoryGirl.create(:nutshell, user: user)
    new_idea = FactoryGirl.build(:nutshell)

    sign_in_as(user)
    visit nutshell_path(idea)
    click_link "Update Your Thynkdup"
    fill_in "Title", with: new_idea.title
    fill_in "Content", with: new_idea.content
    page.check("art")
    page.check("music")
    page.check("politics")
    click_button("Update Your Thynkdup")

    expect(page).to have_content new_idea.title
    expect(page).to have_content "Your Thynkdup has been Updated"
  end

  scenario "User Fails to Update nutshell" do
    user = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:nutshell, user: user)

    sign_in_as(user)
    visit edit_nutshell_path(idea)
    fill_in "Title", with: ""
    fill_in "Content", with: ""
    click_button("Update Your Thynkdup")

    expect(page).to have_content "can't be blank"
    expect(page).to_not have_content "Your Thynkdup has been Updated"
  end

  context "As an unauthenticated user" do
    scenario "user cannot view edit page" do
      user = FactoryGirl.create(:user)
      idea = FactoryGirl.create(:nutshell, user: user)
      visit edit_nutshell_path(idea)

      expect(page).to_not have_content "Update"
      expect(page).to have_content "You must be logged in to view this page"
    end
  end

  context "As the wrong signed in user" do
    scenario "only nuthsell owner can update their nutshell" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      idea = FactoryGirl.create(:nutshell, user: user2)

      sign_in_as(user)
      visit edit_nutshell_path(idea)

      expect(page).to_not have_content "Update"
      expect(page).to have_content "This is not your Thynkdup"
    end
  end
end
