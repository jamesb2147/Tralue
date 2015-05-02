class Country < ActiveRecord::Base
  has_many :settings
  has_many :creditcards
end
