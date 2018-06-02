class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :votos
      t.integer :comentable_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
