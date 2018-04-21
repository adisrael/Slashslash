class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :userName
      t.string :firstName
      t.string :lastName
      t.integer :role

      t.timestamps
    end
  end
end
