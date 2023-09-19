require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
  end

  describe "class methods" do
    before :each do
      load_test_data
    end
    it "update_status toggles item status" do
      
      expect( @item_1_m1.status).to be true
      @item_1_m1.update_status
      expect( @item_1_m1.status).to be false
      @item_1_m1.update_status
      expect( @item_1_m1.status).to be true
        
    end
  end
end