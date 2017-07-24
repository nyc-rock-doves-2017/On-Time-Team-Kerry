class CreateContractors < ActiveRecord::Migration[5.1]
  def change
    create_table :contractors do |t|

      t.string :name, :email, null: false, uniqueness: true
      t.string :password, null: false
      t.boolean :status

      t.timestamps
    end
  end
end
