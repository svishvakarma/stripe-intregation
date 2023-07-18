class Product < ApplicationRecord
  has_many :invoices
  validates :name, presence: true
  enum payment_status: { pending: 'pending', success: 'success', failed: 'failed' }
end
