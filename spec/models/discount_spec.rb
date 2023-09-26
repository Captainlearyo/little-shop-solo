require "rails_helper"

RSpec.describe Discount, type: :model do
  before :each do
    load_test_data
  end

  describe "relationships" do
    it { should belong_to(:merchant)}
    it { should have_many(:items).through(:merchant) }
  
  end

  describe "validations" do
    it {should validate_presence_of(:percentage_discount)}
    it {should validate_presence_of(:quantity_threshold)}
  end

end