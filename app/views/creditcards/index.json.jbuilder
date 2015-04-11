json.array!(@creditcards) do |creditcard|
  json.extract! creditcard, :id, :name, :issuer, :annual_fee, :fee_waived_first_year, :points_program, :spend_bonus, :spend_requirement, :time_to_reach_spend_in_months, :first_purchase_bonus, :second_year_spend_bonus, :second_year_spend_requirement, :second_year_time_to_reach_spend_in_months, :points_per_dollar_spent_general_spend, :foreign_transaction_fee, :chip, :notes, :business, :personal, :image_index, :url, :country
  json.url creditcard_url(creditcard, format: :json)
end
