class CreateCreditcards < ActiveRecord::Migration
  def change
    create_table :creditcards do |t|
      t.string :name
      t.string :issuer
      t.integer :annual_fee
      t.boolean :fee_waived_first_year
      t.string :points_program
      t.integer :spend_bonus
      t.integer :spend_requirement
      t.integer :time_to_reach_spend_in_months
      t.integer :first_purchase_bonus
      t.integer :second_year_spend_bonus
      t.integer :second_year_spend_requirement
      t.integer :second_year_time_to_reach_spend_in_months
      t.decimal :points_per_dollar_spent_general_spend
      t.decimal :foreign_transaction_fee
      t.string :chip
      t.text :notes
      t.boolean :business
      t.boolean :personal
      t.integer :image_index

      t.timestamps
    end
  end
end
