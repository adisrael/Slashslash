class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :forum, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
