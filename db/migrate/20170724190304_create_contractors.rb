class CreateContractors < ActiveRecord::Migration[5.1]
  def change
    create_table :contractors do |t|

      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.boolean :status, true

      t.timestamps
    end
  end
end
