json.array!(@balances) do |balance|
  json.extract! balance, :id, :aacostpts, :bacostpts, :uacostpts, :dlcostpts, :ascostpts, :nkcostpts, :sqcostpts, :lacostpts, :accostpts, :cxcostpts, :brcostpts, :eycostpts, :afcostpts, :gacostpts, :mhcostpts, :qfcostpts, :qrcostpts, :tgcostpts, :vscostpts, :azcostpts, :nhcostpts, :amcostpts, :lycostpts, :hacostpts, :ibcostpts, :vxcostpts, :abcostpts, :cacostpts, :nzcostpts, :ozcostpts, :mucostpts, :czcostpts, :ekcostpts, :g3costpts, :hucostpts, :jlcostpts, :lhcostpts, :svcostpts, :vacostpts
  json.url balance_url(balance, format: :json)
end
