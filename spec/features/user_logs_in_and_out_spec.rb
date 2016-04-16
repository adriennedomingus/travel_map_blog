require 'rails_helper'

RSpec.feature "user logs in and out" do
  scenario "user logs in" do
    VCR.use_cassette("sessions.login") do
      stub_omniauth
      visit "/"
      click_link "Sign in with Twitter"
      expect(current_path).to eq("/")
      expect(page).to have_content("a_domingus")
      expect(page).to have_content("Logout")
      expect(page).to_not have_content("Sign in with Twitter")
    end
  end

  scenario "user logs out" do
    VCR.use_cassette("sessions.logout") do
      stub_omniauth
      visit "/"
      click_link "Sign in with Twitter"
      click_link "Logout"
      expect(current_path).to eq("/")
      expect(page).to_not have_content("a_domingus")
      expect(page).to_not have_content("Logout")
      expect(page).to have_content("Sign in with Twitter")
    end
  end
end
