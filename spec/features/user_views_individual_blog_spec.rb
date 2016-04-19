require 'rails_helper'

RSpec.feature "user views specific blog" do
  scenario "user views specific blog" do
    user = create_user
    _, b1 = create_trip_and_blog(user)

    visit blog_path(b1.slug)

    expect(page).to have_content(b1.title)
    expect(page).to have_content(b1.posted_on)
    expect(page).to have_content(b1.formatted_date)
  end
end
