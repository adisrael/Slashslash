class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.integer :numero
      t.integer :votos
      t.string :title
      t.text :content
      t.references :user, foreign_key: true
      t.references :forum, foreign_key: true

      t.timestamps
    end
  end
end
