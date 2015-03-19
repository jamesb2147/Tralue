class Rate < ActiveRecord::Base
  has_and_belongs_to_many :creditcards
  has_and_belongs_to_many :trips
end
