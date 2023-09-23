require "rails_helper"

RSpec.describe " Merchant Bulk Discounts Index" do
  before(:each) do
    load_test_data
  end

# user story 2.1
  it "I see all of my bulk discounts including their percentage discount and quantity thresholds" do
    visit merchant_discount_path(@merchant_1, @discount_1_m1)
    
    expect(page).to have_content(@discount_1_m1.percentage_discount)
    expect(page).to have_content(@discount_1_m1.quantity_threshold)
    expect(page).to have_content(@discount_1_m1.id)
  end

end