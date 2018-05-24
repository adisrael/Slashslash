class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :publication, foreign_key: true
      t.boolean :positive
      t.timestamps
    end
  end
end
