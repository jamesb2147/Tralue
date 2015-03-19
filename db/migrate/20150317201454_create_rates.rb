class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.string :transferringprogram
      t.string :transfereeprogram
      t.decimal :transferratio
      t.text :transfernotes

      t.timestamps
    end
  end
end
