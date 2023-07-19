class Product < ApplicationRecord
  has_many :invoices, dependent: :destroy
  validates :name, presence: true
  enum payment_status: { pending: 'pending', success: 'success', failed: 'failed' }
end