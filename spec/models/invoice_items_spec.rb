require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  before :each do
    load_test_data
  end

  describe "relationships" do
    it {should belong_to(:invoice)}
    it {should belong_to(:item)}
  end

  describe "validations" do
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:status)}
  end
  
  describe "instance methods" do
    describe "#item_name" do
      it "can return the item name" do
        expect(@invoice_item_1_i1_c1.item_name).to eq("Sour Dough")
      end
    end

    describe "#applicable_discount" do
      it "can return the highest applicable discount" do
        expect(@invoice_item_1_i1_c1.applicable_discount.percentage_discount).to eq(15)
      end
    end

    describe "#apply_discount" do
      it "can return the discounted price" do
        expect(@invoice_item_1_i1_c1.apply_discount).to eq(5)
      end
    end

    describe "#revenue" do
      it "can return the discounted revenue" do
        expect(@invoice_item_1_i1_c1.revenue).to eq(10)
      end
    end
  end

end