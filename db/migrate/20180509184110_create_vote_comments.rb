class CreateVoteComments < ActiveRecord::Migration[5.1]
  def change
    create_table :vote_comments do |t|
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true
      t.boolean :positive

      t.timestamps
    end
  end
end
