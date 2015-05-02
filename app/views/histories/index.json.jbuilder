json.array!(@histories) do |history|
  json.extract! history, :id, :application_date_and_time, :card_id, :approved, :notes, :closed
  json.url history_url(history, format: :json)
end
