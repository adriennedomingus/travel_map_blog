require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :blogs }
  it { should have_many :trips }
end
