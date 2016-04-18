require 'rails_helper'

RSpec.describe Trip, type: :model do
  it {should have_many :blogs }
  it {should belong_to :user }
end
