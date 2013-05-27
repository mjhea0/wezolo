require 'spec_helper'

describe "When I visit the homepage" do

  let!(:user) { create(:user) }

  it "can be seen" do
    # visit root_path # doesn't work?
    visit '/'
  end

  context "login" do

    it "has a login button" do
      visit '/'
      page.should have_content("Log in")
    end

    it "brings up login modal" do
      visit '/'
      click_link("Log in")
      find("#loginModal")['aria-hidden'].should eq "false"
    end

    it "will redirect to add new involvement" do
      create(:sam)
      visit '/'
      click_link("Log in")
      fill_in 'email', :with => 'sam@gmail.com'
      fill_in 'password', :with => 'password'
      find(".loginmein").click
      sleep 1
      current_path.should eq "/involvements/new"
    end

  end

  context "signup" do

    it "has a signup button" do
      visit '/'
      page.should have_content("Sign up")
    end

    it "brings up signup modal" do
      visit '/'
      click_link("Sign up")
      find("#signupModal")['aria-hidden'].should eq "false"
    end

    it "shows errors when passwords don't match" do
      visit '/'
      click_link("Sign up")
      find('.signup-error').text.should eq ""
      sleep(1)
      fill_in 'name', :with => 'Jimmy'
      fill_in 'email', :with => 'jimmy@email.com'
      fill_in 'password', :with => 'password'
      fill_in 'password_confirmation', :with => 'password1'
      find(".createaccount").click
      find('.signup-error').text.should eq "Password doesn't match confirmation"
    end

    it "shows errors when user email already exists" do
      create(:fab)
      visit '/'
      click_link("Sign up")
      find('.signup-error').text.should eq ""
      sleep(1)
      fill_in 'name', :with => 'Fab Mackojc'
      fill_in 'email', :with => 'fab@gmail.com'
      fill_in 'password', :with => '123'
      fill_in 'password_confirmation', :with => '123'
      find(".createaccount").click
      find('.signup-error').text.should eq "Email has already been taken"
    end

  end
  
  context "User Not Logged in" do
    it "should not be able to see newsfeed if not logged in" do
      visit '/home'
      current_path.should eq '/'
      find('.error-notice').text.should eq "You are not authorized to access this page."
    end
  end
end