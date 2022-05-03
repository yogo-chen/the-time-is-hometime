class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations, id: { type: :bigint, unsigned: true } do |t|
      t.integer :guest_id, unsigned: true

      t.string :code, null: false
      t.string :status
      t.integer :nights, limit: 2, unsigned: true # small uint

      t.integer :adults, limit: 1, unsigned: true # tiny uint
      t.integer :children, limit: 1, unsigned: true # tiny uint
      t.integer :infants, limit: 1, unsigned: true # tiny uint
      t.integer :total_guests, limit: 1, unsigned: true # tiny uint

      t.string :currency
      t.decimal :payout_price, precision: 10, scale: 2
      t.decimal :security_price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2

      t.date :start_date
      t.date :end_date

      t.timestamps

      t.index :guest_id
      t.index :code, unique: true
    end
  end
end
