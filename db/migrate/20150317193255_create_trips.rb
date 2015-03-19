class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.decimal :costinusd
      t.integer :aacostpts
      t.decimal :aacostusd
      t.integer :bacostpts
      t.decimal :bacostusd
      t.integer :uacostpts
      t.decimal :uacostusd
      t.integer :dlcostpts
      t.decimal :dlcostusd
      t.integer :ascostpts
      t.decimal :ascostusd
      t.integer :nkcostpts
      t.decimal :nkcostusd
      t.integer :sqcostpts
      t.decimal :sqcostusd
      t.integer :lacostpts
      t.decimal :lacostusd
      t.integer :accostpts
      t.decimal :accostusd

      t.timestamps
    end
  end
end
