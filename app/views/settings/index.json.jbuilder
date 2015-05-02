json.array!(@settings) do |setting|
  json.extract! setting, :id, :user_id, :country, :show_business_cards, :show_personal_cards, :show_credit_cards, :show_charge_cards, :include_bonuses_in_calculations, :include_current_point_balances_in_calculations, :include_authorized_user_bonus, :fly_on_star_alliance, :fly_on_skyteam, :fly_on_oneworld
  json.url setting_url(setting, format: :json)
end
