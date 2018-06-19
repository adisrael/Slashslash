class CreatePolls < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.string :question
      t.references :publication, foreign_key: true

      t.timestamps
    end
  end
end
