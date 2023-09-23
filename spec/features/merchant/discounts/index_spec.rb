require "rails_helper"

RSpec.describe " Merchant Bulk Discounts Index" do
  before(:each) do
    load_test_data
  end

# user story 2.1
  it "I see all of my bulk discounts including their percentage discount and quantity thresholds" do
    visit merchant_discounts_path(@merchant_1)

    
    expect(page).to have_content(@discount_1_m1.percentage_discount)
    expect(page).to have_content(@discount_1_m1.quantity_threshold)
    expect(page).to have_content(@discount_1_m1.id)

    expect(page).to have_content(@discount_2_m1.percentage_discount)
    expect(page).to have_content(@discount_2_m1.quantity_threshold)
    expect(page).to have_content(@discount_2_m1.id)

    click_link "#{@discount_1_m1.id}"
    expect(current_path).to eq(merchant_discount_path(@merchant_1, @discount_1_m1))

    
  end

  # user story 2.2
  it "Then I see a link to create a new discount" do

    visit merchant_discounts_path(@merchant_1)

    click_link "Create New Discount"
    expect(current_path).to eq(new_merchant_discount_path(@merchant_1))

    fill_in 'Percentage discount', with: 60
    fill_in 'Quantity threshold', with: 50
    save_and_open_page
    click_button 'Submit'

    expect(current_path).to eq(merchant_discounts_path(@merchant_1))
    expect(page).to have_content('Discount was successfully created.')
    save_and_open_page
      expect(page).to have_content('60')
      expect(page).to have_content('50')
    
  end

end