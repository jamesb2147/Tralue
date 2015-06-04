class Setting < ActiveRecord::Base
  belongs_to :user
  #has_one :country
end
