class Setting < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  
  validates :country_id, presence: true
  validates_numericality_of :maximum_cards_comfortable_applying_for_at_once, presence: true, only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10
  #validates_numericality_of :user_id, presence: true, only_integer: true, greater_than_or_equal_to: 0
  validates :show_business_cards, inclusion: { in: [true, false]}, exclusion: { in: [nil]}
  validates :show_personal_cards, inclusion: { in: [true, false]}, exclusion: { in: [nil]}
  validates :show_credit_cards, inclusion: { in: [true, false]}, exclusion: { in: [nil]}
  validates :show_charge_cards, inclusion: { in: [true, false]}, exclusion: { in: [nil]}
  validates :include_bonuses_in_calculations, inclusion: { in: [true, false]}, exclusion: { in: [nil]}
  validates :include_current_point_balances_in_calculations, inclusion: { in: [true, false]}, exclusion: { in: [nil]}
  validates :include_authorized_user_bonus, inclusion: { in: [true, false]}, exclusion: { in: [nil]}
  validates :fly_on_star_alliance, inclusion: { in: [true, false]}, exclusion: { in: [nil]}
  validates :fly_on_skyteam, inclusion: { in: [true, false]}, exclusion: { in: [nil]}
  validates :fly_on_oneworld, inclusion: { in: [true, false]}, exclusion: { in: [nil]}
end
