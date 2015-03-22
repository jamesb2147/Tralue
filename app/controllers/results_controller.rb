class ResultsController < ApplicationController
  http_basic_authenticate_with name: "shunter", password: "derpderp", except: [:show]
  
  class Resulta
    include ActiveModel::Model
    
    attr_reader :name, :costinusd
    attr_writer :name, :costinusd
  end
  
  def index
    @results = []
    
    costs = Trip.all
    
    costs.each do |cost|
      @results.insert(0, cost)
    end
    
    #@result.name = "Bob"
  end
  
  def show
    #@trip = Trip.find(params[:id])
    
    costs = Trip.find(params[:id])
    @result = Result.new
    @result.name = costs.name
    @result.costinusd = costs.costinusd
    @result.aacostpts = costs.aacostpts
    @result.aacostusd = costs.aacostusd
    @result.bacostpts = costs.bacostpts
    @result.bacostusd = costs.bacostusd
    @result.uacostpts = costs.uacostpts
    @result.uacostusd = costs.uacostusd
    @result.dlcostpts = costs.dlcostpts
    @result.dlcostusd = costs.dlcostusd
    @result.ascostpts = costs.ascostpts
    @result.ascostusd = costs.ascostusd
    @result.nkcostpts = costs.nkcostpts
    @result.nkcostusd = costs.nkcostusd
    @result.sqcostpts = costs.sqcostpts
    @result.sqcostusd = costs.sqcostusd
    @result.lacostpts = costs.lacostpts
    @result.lacostusd = costs.lacostusd
    @result.accostpts = costs.accostpts
    @result.accostusd = costs.accostusd
    #puts costs.aacostpts
    
    cards = Creditcard.all
    #cards = Creditcard.find(params[:id])
    
    #cards.each do |cc|
    #@result.name = cc.name
    #@result.issuer = cc.issuer
    #@result.points_program = cc.points_program
    #@result.spend_bonus = cc.spend_bonus
    #end
    
    costs = Trip.find(params[:id])
    rates = Rate.all
    cards = Creditcard.all
    
    #debug_string = ""
    @debug_string = ""
    
    rates.each do |rate|
      cards.each do |card|
        @debug_string << card.name
        if card.points_program == rate.transferringprogram
          #@result.name << card.points_program + " = " + rate.transferringprogram
          if @result.arrayofcards == nil
            @result.arrayofcards = []
            #debug_string = "Empty. "
          end
          
          #debug_string = "Adding card."
          #@debug_string = card.name
          temparray = []
          
          case rate.transfereeprogram
          when "american"
            if @result.aacostpts.nil?
              percentage = 0
              #debug_string = "Percentage to 0."
              @debug_string << " nil."
            else
              percentage = ((card.first_purchase_bonus + card.spend_bonus + card.spend_requirement) * rate.transferratio) / @result.aacostpts * 100
            end
            
            miles_required = @result.aacostpts
            if @result.aacostusd.nil?
              copay = 0
            else
              copay = @result.aacostusd
            end
            
            temparray = [card, rate, "American", percentage, miles_required, copay]
            #debug_string = "american"
            @result.arrayofcards.push(temparray)
          when "ba"
            if @result.bacostpts.nil?
              percentage = 0
            else
              percentage = ((card.first_purchase_bonus + card.spend_bonus + card.spend_requirement) * rate.transferratio) / @result.bacostpts * 100
            end
            
            miles_required = @result.bacostpts
            if @result.bacostusd.nil?
              copay = 0
            else
              copay = @result.bacostusd
            end
            
            temparray = [card, rate, "BA", percentage, miles_required, copay]
            #debug_string = "ba"
            @result.arrayofcards.push(temparray)
          when "united"
            if @result.uacostpts.nil?
              percentage = 0
            else
              percentage = ((card.first_purchase_bonus + card.spend_bonus + card.spend_requirement) * rate.transferratio) / @result.uacostpts * 100
            end
            
            miles_required = @result.uacostpts
            if @result.uacostusd.nil?
              copay = 0
            else
              copay = @result.uacostusd
            end
            
            temparray = [card, rate, "United", percentage, miles_required, copay]
            #debug_string = "united"
            @result.arrayofcards.push(temparray)
          when "delta"
            if @result.dlcostpts.nil?
              percentage = 0
              @result.name << "Delta cost is nil."
            else
              percentage = ((card.first_purchase_bonus + card.spend_bonus + card.spend_requirement) * rate.transferratio) / @result.dlcostpts * 100
            end
            
            miles_required = @result.dlcostpts
            if @result.dlcostusd.nil?
              copay = 0
            else
              copay = @result.dlcostusd
            end
            
            temparray = [card, rate, "Delta", percentage, miles_required, copay]
            #debug_string = "dl"
            @result.arrayofcards.push(temparray)
          when "alaska"
            if @result.ascostpts.nil?
              percentage = 0
            else
              percentage = ((card.first_purchase_bonus + card.spend_bonus + card.spend_requirement) * rate.transferratio) / @result.ascostpts * 100
            end
            
            miles_required = @result.ascostpts
            if @result.ascostusd.nil?
              copay = 0
            else
              copay = @result.ascostusd
            end
            
            temparray = [card, rate, "Alaska", percentage, miles_required, copay]
            #debug_string = "as"
            @result.arrayofcards.push(temparray)
          when "spirit"
            if @result.nkcostpts.nil?
              percentage = 0
            else
              percentage = ((card.first_purchase_bonus + card.spend_bonus + card.spend_requirement) * rate.transferratio) / @result.nkcostpts * 100
            end
            
            miles_required = @result.nkcostpts
            if @result.nkcostusd.nil?
              copay = 0
            else
              copay = @result.nkcostusd
            end
            
            temparray = [card, rate, "Spirit", percentage, miles_required, copay]
            #debug_string = "nk"
            @result.arrayofcards.push(temparray)
          when "singapore"
            if @result.sqcostpts.nil?
              percentage = 0
              @debug_string << " Singapore nil."
            else
              percentage = ((card.first_purchase_bonus + card.spend_bonus + card.spend_requirement) * rate.transferratio) / @result.sqcostpts * 100
            end
            
            miles_required = @result.sqcostpts
            if @result.sqcostusd.nil?
              copay = 0
            else
              copay = @result.sqcostusd
            end
            
            temparray = [card, rate, "Singapore", percentage, miles_required, copay]
            #debug_string = "sq"
            @result.arrayofcards.push(temparray)
          when "lan"
            if @result.lacostpts.nil?
              percentage = 0
            else
              percentage = ((card.first_purchase_bonus + card.spend_bonus + card.spend_requirement) * rate.transferratio) / @result.lacostpts * 100
            end
            
            miles_required = @result.lacostpts
            if @result.lacostusd.nil?
              copay = 0
            else
              copay = @result.lacostusd
            end
            
            temparray = [card, rate, "LAN", percentage, miles_required, copay]
            #debug_string = "la"
            @result.arrayofcards.push(temparray)
          when "aircanada"
            if @result.accostpts.nil?
              percentage = 0
            else
              percentage = ((card.first_purchase_bonus + card.spend_bonus + card.spend_requirement) * rate.transferratio) / @result.accostpts * 100
            end
            
            miles_required = @result.accostpts
            if @result.accostusd.nil?
              copay = 0
            else
              copay = @result.accostusd
            end
            
            temparray = [card, rate, "Air Canada", percentage, miles_required, copay]
            #debug_string = "ac"
            @result.arrayofcards.push(temparray)
          else
            #@debug_string << " Else reached."
            puts "Else reached in results controller."
          end
          
          
          #add card to 'wallet' of results
          #add transfer rate info
          #add relevant pts and usd cost (good luck figuring out which is relevant in a clean way)
        end
      end
    end
    
    #@result.name=debug_string
    #@result.arrayofcards.sort! { |a,b| a.name <=> b.name }
    @result.arrayofcards.sort_by!{ |e| e[3].nil? ? 0 : e[3] }.reverse!
    
    @result.issuer = @result.arrayofcards[0][0].issuer
    #percentage = ((@result.arrayofcards[0][0].first_purchase_bonus + @result.arrayofcards[0][0].spend_bonus + @result.arrayofcards[0][0].spend_requirement) * @result.arrayofcards[0][1].transferratio) / @result.aacostpts * 100
    
    #@result.percentage = percentage
    
    #wallet.each do |c|
    #
    #end
  end
  
  def new
    #@trip = Trip.new
  end
  
  def edit
    #@trip = Trip.find(params[:id])
  end
  
  def create
    #@trip = Trip.create(trip_check) #bleh
    
    #if @trip.save
    #  redirect_to @trip
    #else
    #  render 'new'
    #end
    
  end
  
  def update 
    #@trip = Trip.find(params[:id])
    
    #if @trip.update(trip_check)
    #  redirect_to @trip
    #else
    #  render 'edit'
    #end
    
  end
  
  def destroy
    #@trip = Trip.find(params[:id])
    #@trip.destroy
    
    #redirect_to trips_path
  end
  
  private
    #require all new entries to have these four fields, at a minimum, INCLUDING notes
    def result_check
      params.require(:result).permit(:name,
                                   :costinusd,
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
                                   :accostusd)
    end
end