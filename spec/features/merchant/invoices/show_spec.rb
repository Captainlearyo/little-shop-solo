require "rails_helper"

RSpec.describe "Merchant Invoice Show Page", type: :feature do
  before :each do
    load_test_data
  end

  # User Story 16
  it "displays all items and their attributes(name, quantity, price, invoice item status) for that invoice" do
    # visit "/merchants/#{@merchant_5.id}/invoices/#{@invoice_3_c6.id}"
    visit merchant_invoice_path(@merchant_5, @invoice_3_c6)

    expect(page).to_not have_content(@item_1_m3.name)
    expect(page).to have_content(@item_6_m5.name)
    expect(page).to have_content( @invoice_item_1_i3_c6.quantity)
    expect(page).to have_content(@item_6_m5.unit_price)
    expect(page).to have_content(@invoice_item_1_i3_c6.status)
    
  end 

  # User Story 17
  it "displays total revenue generated from all items on the invoice" do
    # visit "/merchants/#{@merchant_5.id}/invoices/#{@invoice_3_c6.id}"
    visit merchant_invoice_path(@merchant_5, @invoice_3_c6)
    expect(page).to have_content("Total Revenue for Invoice with Discounts: #{@invoice_3_c6.total_discounted_revenue}")
  end

  # User Story 18
  it "displays invoice status in a select field that allows users to update the status" do
    # visit "/merchants/#{@merchant_5.id}/invoices/#{@invoice_2_c6.id}"
    visit merchant_invoice_path(@merchant_5, @invoice_2_c6)

    expect(@invoice_item_1_i2_c6.status).to eq("pending")

    select "shipped", from: "status"
    click_button "Update Item Status"

    @invoice_item_1_i2_c6.reload

    expect(@invoice_item_1_i2_c6.status).to eq("shipped")
  end

   # User Story 2.6
   it "I see the total revenue for my merchant from this invoice" do
    visit merchant_invoice_path(@merchant_2, @invoice_2_c1)
    expect(page).to have_content("Total Revenue for Invoice with Discounts: #{@invoice_2_c1.total_discounted_revenue}")
    visit merchant_invoice_path(@merchant_4, @invoice_4_c2)
    expect(page).to have_content("Total Revenue for Invoice with Discounts: #{@invoice_4_c2.total_discounted_revenue}")
  end

   # User Story 2.7
   it "Next to each invoice item I see a link to the show page for the bulk discount that was applied" do
    visit merchant_invoice_path(@merchant_2, @invoice_2_c1)
    save_and_open_page
    visit merchant_invoice_path(@merchant_6, @invoice_4_c1)
    save_and_open_page
  end
end