class AddUrlToCreditcards < ActiveRecord::Migration
  def change
    add_column :creditcards, :url, :string
  end
end
