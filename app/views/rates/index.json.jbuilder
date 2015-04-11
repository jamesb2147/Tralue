json.array!(@rates) do |rate|
  json.extract! rate, :id, :transferringprogram, :transfereeprogram, :transferratio, :transfernotes
  json.url rate_url(rate, format: :json)
end
