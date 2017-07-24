class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :merchant, foreign_key: true
      t.references :contractor, foreign_key: true
      t.string :destination
      t.timestamp :claim_time
      t.timestamp :pick_up_time
      t.timestamp :delivery_time

      t.timestamps
    end
  end
end
