class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
