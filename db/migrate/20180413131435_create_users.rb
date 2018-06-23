class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :userName
      t.string :firstName
      t.string :lastName
      t.integer :role
      t.integer :reputation
      t.string :image
      t.integer :facebook_registered  # 0 for not fb, 1 for fb
      t.timestamps
    end
  end
end
