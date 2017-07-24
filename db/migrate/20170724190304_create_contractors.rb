class CreateContractors < ActiveRecord::Migration[5.1]
  def change
    create_table :contractors do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.boolean :status

      t.timestamps
    end
  end
  
  def up
    change_column_default :contractors, :status, true
  end
end
