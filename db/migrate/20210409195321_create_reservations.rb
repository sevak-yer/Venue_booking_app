class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :date
      t.time :checkin
      t.time :checkout
      t.integer :venue_id
      t.integer :user_id
      t.timestamps
    end
  end
end
