require 'rails_helper'

RSpec.describe "As a visitor when I visit 'admin/invoices/:id'" do
  before :each do
    load_test_data
  end

  #user story 33
  it "I see a information related to  the invoice" do
    visit "admin/invoices/#{@invoice_1_c1.id}"

    expect(page).to have_content(@invoice_1_c1.id)

    within("#invoice-information") do
      expect(page).to have_content("Date Created: #{@invoice_1_c1.date_created}")
      expect(page).to have_content("Customer Name: #{@customer_1.full_name}")
      expect(page).to have_content("Status: #{@invoice_1_c1.status}")
    end
  end

  # user story 34
  it "I see all items on the invoice with details" do
    visit "admin/invoices/#{@invoice_1_c1.id}"

    within("#invoice_items-information") do
      within("#invoice_item-#{@invoice_item_1_i1_c1.id}") do
        expect(page).to have_content(@invoice_item_1_i1_c1.item_name)
        expect(page).to have_content("Quantity: #{@invoice_item_1_i1_c1.quantity}")
        expect(page).to have_content("Unit Purchase Price: #{@invoice_item_1_i1_c1.unit_price}")
        expect(page).to have_content("Status: #{@invoice_item_1_i1_c1.status}")
      end
    end
  end

  # user story 35
  it "I see the total revenue that will be generated by this invoice" do
    visit "admin/invoices/#{@invoice_1_c1.id}"

    within("#total_revenue") do
      expect(page).to have_content("Total Revenue: #{@invoice_1_c1.total_revenue}")
    end
  end

  # user story 36
  it "I see the invoice status in a select field that allows me to update the status" do
    visit "admin/invoices/#{@invoice_1_c1.id}"
    
    expect(@invoice_1_c1.status).to eq("in_progress")

    within("#invoice-information") do
      select "completed", from: "status"
      click_button "Update Invoice Status"
    end

    @invoice_1_c1.reload

    expect(@invoice_1_c1.status).to eq("completed")

    # refactor: make this test more robust! I know with visual check that the selected status is displaying correctly but I don't currently know how to test that with capybara/rspec
  end
end