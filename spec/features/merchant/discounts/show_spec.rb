require "rails_helper"

RSpec.describe " Merchant Bulk Discounts Index" do
  before(:each) do
    load_test_data
  end

# user story 2.4
  it "I see all of my bulk discounts including their percentage discount and quantity thresholds" do
    visit merchant_discount_path(@merchant_1, @discount_1_m1)
    
    expect(page).to have_content(@discount_1_m1.percentage_discount)
    expect(page).to have_content(@discount_1_m1.quantity_threshold)
    expect(page).to have_content(@discount_1_m1.id)
  end

  # user story 2.4
  it "I see a link to edit the bulk discount" do
    visit merchant_discount_path(@merchant_1, @discount_1_m1)

    click_link "Edit Discount"

    expect(current_path).to eq(edit_merchant_discount_path(@merchant_1, @discount_1_m1))
    
    fill_in 'Percentage discount', with: 95
    fill_in 'Quantity threshold', with: 75
    click_button 'Submit'

    expect(current_path).to eq(merchant_discount_path(@merchant_1, @discount_1_m1))

    save_and_open_page

    expect(page).to have_content('95')
    expect(page).to have_content('75')
    
  end

end