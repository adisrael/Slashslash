class CreatePollVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :poll_votes do |t|
      t.references :poll, foreign_key: true
      t.references :user, foreign_key: true
      t.references :poll_option, foreign_key: true

      t.timestamps
    end
  end
end
