class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status

  enum :status, [:pending, :packaged, :shipped]

  def item_name
    item.name
  end

  def applicable_discount
    if item.merchant.discounts
    item.merchant.discounts
        .where('quantity_threshold <= ?', quantity)
        .order(percentage_discount: :desc)
        .first
    else
      false
    end
  end

  def apply_discount
    if applicable_discount
      new_price = unit_price * ((100 - applicable_discount.percentage_discount) / 100.0)
      new_price.to_i
    else
      unit_price
    end
  end

  def revenue
    quantity * apply_discount
  end

end