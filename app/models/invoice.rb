class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates_presence_of :status

  enum :status, [:in_progress, :completed, :cancelled]

  def self.items_not_yet_shipped
        joins(:items)
        .where("invoice_items.status != '2'")
        .group(:id)
        .order("invoices.created_at ASC")
  end

  def date_created
    created_at.strftime("%A, %B %e, %Y")
  end

  def customer_name
    customer.full_name
  end

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end

  def total_discounted_revenue
    invoice_items.sum(&:revenue)
  end

  def format_created_at
    self.created_at.strftime("%A, %B %d, %Y")
  end
end