class Creditcard < ActiveRecord::Base
  has_and_belongs_to_many :rates
  
  validates :name, presence: true
  validates :issuer, presence: true
end
