class Result
  include ActiveModel::Model
  
  attr_accessor :name, :costinusd, :issuer, :points_program, :spend_bonus,
                       :aacostpts,
                       :aacostusd,
                       :bacostpts,
                       :bacostusd,
                       :uacostpts,
                       :uacostusd,
                       :dlcostpts,
                       :dlcostusd,
                       :ascostpts,
                       :ascostusd,
                       :nkcostpts,
                       :nkcostusd,
                       :sqcostpts,
                       :sqcostusd,
                       :lacostpts,
                       :lacostusd,
                       :accostpts,
                       :accostusd
                       
  attr_accessor :arrayofcards, :percentage, :b
end
