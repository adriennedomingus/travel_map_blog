require 'rails_helper'

RSpec.feature "user uploads a photo" do
  scenario "user uploads a photo" do
    user = create_user
    _, b1 = create_trip_and_blog(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_photo_path
    fill_in :photo_title, with: "Photo title"
    fill_in :photo_description, with: "Photo description"
    select b1.title, from: "photo[blog_id]"
    attach_file "Image", "spec/asset_spec/photos/cat.jpg"
    click_on "Create Photo"
    
    expect(current_path).to eq(photo_path(Photo.last))
    expect(page).to have_css("img[src='#{Photo.last.image}']")
  end
end
