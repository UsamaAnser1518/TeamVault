class CreatePaymentDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :payment_details do |t|
      t.integer :amount_due, null: false
      t.integer :amount_paid, null: false
      t.date :submission_date, null: false
      t.string :submission_month, null: false
      t.integer :status, null: false, default: 0
      t.references :user

      t.timestamps
    end
  end
end
