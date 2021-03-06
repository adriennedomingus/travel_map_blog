require 'rails_helper'

RSpec.describe Trip, type: :model do
  it { should have_many :blogs }
  it { should belong_to :user }
  it { should validate_presence_of :name }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :end_date }
end
