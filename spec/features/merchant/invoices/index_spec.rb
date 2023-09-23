require "rails_helper"

RSpec.describe "Merchant Dashboard show page", type: :feature do
  before :each do
    load_test_data
  end

  # User Story 14
  it "displays all invoice ids that include a merchant item" do
    # visit "/merchants/#{@merchant_5.id}/invoices"
    visit merchant_invoices_path(@merchant_5)

    expect(page).to_not have_content(@invoice_2_c1.id)
    expect(page).to have_content(@invoice_3_c1.id)
    expect(page).to have_content(@invoice_5_c1.id)
    expect(page).to have_content(@invoice_5_c2.id)
    expect(page).to have_content(@invoice_1_c6.id)
  end

  # User Story 14
  it "links each invoice id to the merchant invoice show page" do
    # visit "/merchants/#{@merchant_5.id}/invoices"
    visit merchant_invoices_path(@merchant_5)

    expect(page).to have_link("Invoice ID: #{@invoice_3_c1.id}")
    click_link("Invoice ID: #{@invoice_3_c1.id}")
    # expect(current_path).to eq("/merchants/#{@merchant_5.id}/invoices/#{@invoice_3_c1.id}")
    expect(current_path).to eq(merchant_invoice_path(@merchant_5, @invoice_3_c1))
  end

  # User Story 15
  it "displays invoice details and the Customer's first and last name" do
    # visit "/merchants/#{@merchant_5.id}/invoices"
    visit merchant_invoices_path(@merchant_5)

    expect(page).to have_content(@invoice_3_c1.id)
    expect(page).to have_content(@invoice_3_c1.status)
    expect(page).to have_content(@invoice_3_c1.date_created)
    expect(page).to have_content(@invoice_3_c1.customer_name)
  end
end