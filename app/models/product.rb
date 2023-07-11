class Product < ApplicationRecord
  validates :name, presence: true
  has_many :invoices
  enum payment_status: { pending: 'pending', success: 'success', failed: 'failed' }
end
