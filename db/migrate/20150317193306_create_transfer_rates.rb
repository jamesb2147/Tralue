class CreateTransferRates < ActiveRecord::Migration
  def change
    create_table :transfer_rates do |t|
      t.string :transferringprogram
      t.string :transfereeprogram
      t.decimal :transferratio
      t.text :transfernotes

      t.timestamps
    end
  end
end
