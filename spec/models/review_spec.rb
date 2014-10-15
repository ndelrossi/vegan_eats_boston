require 'rails_helper'

describe Review do
  it { is_expected.to belong_to(:user) } 
  it { is_expected.to belong_to(:place) } 
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:place_id) }
end
