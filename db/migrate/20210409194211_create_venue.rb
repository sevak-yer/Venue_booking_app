class CreateVenue < ActiveRecord::Migration[6.1]
  def change
    create_table :venues do |t|
      t.string :name
      t.time :opening_hour
      t.time :closing_hour
      t.timestamps
    end
  end
end
