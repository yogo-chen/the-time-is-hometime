class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests, id: { type: :integer, unsigned: true } do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.string :phone_number

      t.timestamps

      t.index :email, unique: true
    end
  end
end
