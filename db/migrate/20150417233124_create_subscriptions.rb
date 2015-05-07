class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.string :customer_id
      t.timestamps
    end
  end
end
