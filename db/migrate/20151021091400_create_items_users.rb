class CreateItemsUsers < ActiveRecord::Migration
  def change
    create_table :items_users, id: false do |t|
      t.references :item, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
    end
  end
end
