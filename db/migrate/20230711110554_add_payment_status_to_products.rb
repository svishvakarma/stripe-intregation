class AddPaymentStatusToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :payment_status, :string
  end
end
