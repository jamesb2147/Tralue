json.array!(@countries) do |country|
  json.extract! country, :id, :country, :country_long_form
  json.url country_url(country, format: :json)
end
