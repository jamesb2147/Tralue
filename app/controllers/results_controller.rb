class ResultsController < ApplicationController
  before_action :require_user
  before_action :set_result, only: [:show, :edit, :update, :destroy]

  # GET /results
  # GET /results.json
  def index
    @results = []
    
    costs = Trip.all
    
    costs.each do |cost|
      @results.insert(0, cost)
    end
  end

  # GET /results/1
  # GET /results/1.json
  def show
    load_variables
    initialize_variables
    
    check_user
    
    match_cards_and_programs
    
    sort_results
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: 'Result was successfully created.' }
        format.json { render action: 'show', status: :created, location: @result }
      else
        format.html { render action: 'new' }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url }
      format.json { head :no_content }
    end
  end

  private
    def check_user
      if session[:user_id] == nil
        redirect_to login_path
      else
        if session[:user_id] != @costs[:user_id]
          redirect_to login_path, notice: "You are not permitted to view this trip."
        end
      end
      
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params[:result]
    end
    
    def load_variables
      load_cards
      load_balances
      load_rates
    end
    
    def initialize_variables
      initialize_array_of_cards
      initialize_result_costs
    end
    
    def load_cards
      @cards = Creditcard.all
    end
    
    def load_balances
      @balances = current_user.balance
    end
    
    def load_rates
      @rates = Rate.all
    end
    
    def initialize_array_of_cards
      @result.arrayofcards = []
    end
    
    def sort_results
      #puts "Sort results; arrayofcards:"
      #ap @result.arrayofcards
      @result.arrayofcards.sort_by!{ |e| e["total_percentage"].nil? ? 0 : e["total_percentage"] }.reverse!
      magic_weight
    end
    
    #sort needs to find the 100% mark with the fewest number of cards recommended possible
    #if nothing is >100% of mark, try calculating with one more card...
    #if that result is >100% of mark, suggest user adjust maximum number of recommended cards up by one with a single click
    
    def magic_weight
      binding.pry
      
      @result.arrayofcards.each do |bundle|
        
      end
    end
    
    def initialize_result_costs
      @costs = Trip.find(params[:id])
      @result = Result.new
      @result.name = @costs.name
      @result.costinusd = @costs.costinusd
    end
    
    def is_active(card)
      return card.active
    end
    
    def calculate_bundle_totals(holding_pen)
      #ap holding_pen
      
      holding_pen.each do |array|
        temp_total_percentage = 0
        temp_total_annual_fees = 0
        
        #puts "array:"
        #ap array
        
        array.each do |element|
          #puts "element:"
          #ap element
          
          element.each do |e|
            #puts "e:"
            #ap e
          end
          
          #puts element["percentage"]
          #temp_total_percentage += element['percentage']
          #temp_total_annual_fees += element["card"].annual_fee
        end
        
        #replace current element of arrayofcards with hash including total_percentage and total_annual_fees
        temp_array = array
        array = Hash["array" => temp_array, "total_percentage" => temp_total_percentage, "total_annual_fees" => temp_total_annual_fees]
        #puts "calculated bundle:"
        #ap array
        
        #binding.pry
      end
    end
    
    def calculate_recommendation_totals
      corral = @result.arrayofcards
      holding_pen = Array.new
      
      corral.each do |recommendation_array|
        temp_total_percentage = 0
        temp_total_annual_fees = 0
        
        #puts "recommendation array before calculations:"
        #ap recommendation_array
        recommendation_array.each do |card_bundle|
          #puts "card_bundle:"
          #ap card_bundle
          
          temp_total_percentage += card_bundle["percentage"]
          unless card_bundle["card"].fee_waived_first_year
            temp_total_annual_fees += card_bundle["card"].annual_fee
          end
        end
        
        temp_array = recommendation_array
        new_recommendation = Hash["array" => temp_array,
                         "total_percentage" => temp_total_percentage,
                         "total_annual_fees" => temp_total_annual_fees]
        
        #puts "New calculated recommendation:"
        #ap new_recommendation
        holding_pen.push(new_recommendation)
        
        #puts "recommendation after calculations:"
        #ap recommendation_array
      end
      
      #puts "Corral after calculations:"
      #ap corral
      #puts "Holding pen after calculations:"
      #ap holding_pen
      
      @result.arrayofcards = holding_pen
      
      #binding.pry
    end
    
    def match_cards_and_programs
      #require 'awesome_print'
      #puts "GDI"
      
      initialize_array_of_cards
      
      if @result.arrayofcards == nil
        @result.arrayofcards = []
      end #@result.arrayofcards == nil
      
      if current_user.balance.nil?
        #do NOT create balance creditcards
      else
        create_balance_creditcards
      end
      
      @rates.each do |rate|
        @cards.each do |card|
          if is_active(card)
            if card.points_program == rate.transferringprogram
              #puts card.points_program + " matches " + rate.transferringprogram
              
              
              
              
              case rate.transferringprogram
              when "spg"
                #puts "SPG handler..."
                temparray = bonus_handler(rate, card, true) { |total_standard_bonus| ((total_standard_bonus / 20000) * 5000 + total_standard_bonus) }
                unless temparray.nil?
                  #puts "temparray from bonus_handler:"
                  #ap temparray
                  @result.arrayofcards.push(temparray) 
                end #temparray.nil?
                
              #GREAT example of how to implement temporary transfer bonuses here
              #when "ty"
              #  if rate.transfereeprogram == "etihad"
              #    bonus_handler(rate, card, true) { |total_standard_bonus| (total_standard_bonus * 1.25)}
              #  end
                
              else
                #puts "Non bonus handler..."
                #puts "Card: " + card.name
                temparray = bonus_handler(rate, card, nil) { |total_standard_bonus| 0 + total_standard_bonus }
                unless temparray.nil?
                  #puts "temparray from bonus_handler:"
                  #ap temparray
                  @result.arrayofcards.push(temparray)
                end #temparray.nil?
                
                
              end #else not case "spg"
            end #if card.points_program == rate.transferringprogram
          end #if is_active(card)
        end #cards.each do |card|
        
      end
      
      @cards.each do |card|
        #puts "Cards.each:"
        #ap card
        
        if is_active(card)
        
          #puts "Creating a rate with: " + card.name + " and points program: " + card.points_program
        
          rate = Rate.new(transferringprogram: card.points_program,
                          transfereeprogram: card.points_program,
                          transferratio: 1.0)
          
        
          temparray = bonus_handler(rate, card, nil) { |total_standard_bonus| 0 + total_standard_bonus }
          #puts "temparray:"
          #ap temparray
          
          unless temparray.nil?
            @result.arrayofcards.push(temparray)
          end
        end
      end
      
      #LINEARLY BUILDING CREDITCARD RECOMMENDATION BUNDLES
      linear_build_creditcard_recommendation_bundles
      
      calculate_recommendation_totals
    end
    
    def build_recommendation_bundles
      holding_pen = Array.new
      
      #puts "arrayofcards before building recommendation bundles:"
      #ap @result.arrayofcards
      
      @result.arrayofcards.each do |element|
        #puts "element:"
        #puts element
      end
      
      @result.arrayofcards.each_with_index do |card_bundle_outer, index_outer|
        @result.arrayofcards.each_with_index do |card_bundle_inner, index_inner|
          if (index_outer < index_inner)
            #puts "outer_index < inner_index"
            #puts "card_bundle_outer"
            #ap card_bundle_outer
            #puts "card_bundle_inner"
            #ap card_bundle_inner
            
            #ap card_bundle_outer[0]
            
            if (card_bundle_outer["card"].issuer != card_bundle_inner["card"].issuer) || (card_bundle_outer["card"].business != card_bundle_inner["card"].business)
              if card_bundle_outer[index_outer]["rate"].transfereeprogram == card_bundle_inner[index_inner]["rate"].transfereeprogram
                piglet = Array.new
                piglet.push(card_bundle_outer[index_outer])
                piglet.push(card_bundle_inner[index_inner])
                #temparray.push(0 + card_bundle_outer[1] + card_bundle_inner[1])
                
                #puts "piglet:"
                #ap piglet
                
                holding_pen.push(piglet)
              end
            end
          end
        end
      end
      
      #calculate_bundle_totals(holding_pen)
      calculate_recommendation_totals
      
      holding_pen.each do |pig|
        @result.arrayofcards.push(pig)
      end
      
      #puts "arrayofcards:"
      #ap @result.arrayofcards
    end
    
    def linear_build_creditcard_recommendation_bundles
      arrayofcards_temp = @result.arrayofcards.dup
      
      #binding.pry
      
      @result.arrayofcards.each_with_index do |array, index|
        #binding.pry
        arrayofcards_temp.each_with_index do |array_inner, index_inner| #iterate through each *individual/single* card bundle
          #binding.pry
          
          the_card_is_compatible_with_the_entire_array = true
          array.each_with_index do |another_array, index_idk| #iterate through each card bundle in the outer 'array' making sure it matches requirements with potential new card
            #binding.pry
            array_inner.each_with_index do |array_inner_card_bundle, index_inner_inner|
              #binding.pry
              if index_idk < 10 #less than Setting value for maximum_number_of_cards_to_recommend
                if array_inner_card_bundle["card"].issuer != another_array["card"].issuer
                  
                  if array_inner_card_bundle["rate"].transfereeprogram == another_array["rate"].transfereeprogram
                    puts "Found a valid match..."
                  else
                    the_card_is_compatible_with_the_entire_array = false
                  end #transfereeprogram == transfereeprogram, making bundle a potential for this recommendation
                else
                  the_card_is_compatible_with_the_entire_array = false
                end #issuer OR personal did not match, making bundle a potential for this recommendation
              else
                the_card_is_compatible_with_the_entire_array = false
              end #index_idk < 10
              
            end #array_inner each with index
            
            
            
          end
          if the_card_is_compatible_with_the_entire_array
            array_inner.each_with_index do |card_bundle, blah_index|
              temp_array = array.dup
              #binding.pry
              temp_array.push(card_bundle)
              #binding.pry
              @result.arrayofcards.push(temp_array)
              #binding.pry
            end
          end
        end
      end
    end
    
    def create_balance_creditcards
      creditcard = Creditcard.new
      creditcard.attributes = {personal: true,
                              business: true,
                              credit: true,
                              charge: true,
                              active: true,
                              spend_bonus: 0,
                              spend_requirement: 0,
                              annual_fee: 0}
      
      creditcard.attributes = {name: "Starwood Preferred Guest balance",
                              points_program: "spg",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Membership Rewards balance",
                              points_program: "mr",
                              first_purchase_bonus: @balances.mrbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Ultimate Rewards balance",
                              points_program: "ur",
                              first_purchase_bonus: @balances.urbalance}
      @cards.push(creditcard)
      
      
      
      creditcard.attributes = {name: "Thank You balance",
                              points_program: "ty",
                              first_purchase_bonus: @balances.tybalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "American balance",
                              points_program: "american",
                              first_purchase_bonus: @balances.aabalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "British Airways balance",
                              points_program: "ba",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "United balance",
                              points_program: "united",
                              first_purchase_bonus: @balances.uabalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Delta balance",
                              points_program: "delta",
                              first_purchase_bonus: @balances.dlbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Alaska balance",
                              points_program: "alaska",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Spirit balance",
                              points_program: "spirit",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Singapore balance",
                              points_program: "singapore",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "LAN balance",
                              points_program: "lan",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Aeroplan balance",
                              points_program: "aeroplan",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Cathay Pacific balance",
                              points_program: "cathay_pacific",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "EVA balance",
                              points_program: "eva",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Etihad balance",
                              points_program: "etihad",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Flying Blue balance",
                              points_program: "flying_blue",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Garuda Indonesia balance",
                              points_program: "garuda_indonesia",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Malaysia balance",
                              points_program: "malaysia",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Qantas balance",
                              points_program: "qantas",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Qatar balance",
                              points_program: "qatar",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Thai Airways balance",
                              points_program: "thai",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Virgin Atlantic balance",
                              points_program: "virgin_atlantic",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Alitalia balance",
                              points_program: "alitalia",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "ANA balance",
                              points_program: "ana",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "AeroMexico balance",
                              points_program: "aeromexico",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "El Al balance",
                              points_program: "el_al",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Hawaiian balance",
                              points_program: "hawaiian",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Iberia balance",
                              points_program: "iberia",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Virgin America balance",
                              points_program: "virgin_america",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Air Berlin balance",
                              points_program: "air_berlin",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Air China balance",
                              points_program: "air_china",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Air New Zealand balance",
                              points_program: "air_new_zealand",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Asiana balance",
                              points_program: "asiana",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "China Eastern balance",
                              points_program: "china_eastern",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "China Southern balance",
                              points_program: "china_southern",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Emirates balance",
                              points_program: "emirates",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Gol balance",
                              points_program: "gol",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Hainan balance",
                              points_program: "hainan",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "JAL balance",
                              points_program: "jal",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Lufthansa balance",
                              points_program: "miles_and_more",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Saudia/Saudi Arabian balance",
                              points_program: "saudia_arabian",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
      
      creditcard.attributes = {name: "Virgin Australia balance",
                              points_program: "virgin_australia",
                              first_purchase_bonus: @balances.spgbalance}
      @cards.push(creditcard)
    end
    
    def bonus_handler(rate_arg, card_arg, transfer_bonus_arg, &bonus_calculator)
      #percentage_calculator = { percentage = ((card.first_purchase_bonus + card.spend_bonus + card.spend_requirement) * rate.transferratio) / @result.aacostpts * 100 }
      rate = rate_arg
      card = card_arg
      includes_transfer_bonus = transfer_bonus_arg
      
      card_rate_etc = {"card" => card,
                    "rate" => rate,
                    "points_program" => nil,
                    "percentage" => nil,
                    "miles_required" => nil,
                    "copay" => nil,
                    "total_bonus" => nil,
                    "points_in_program" => nil,
                    "bonus_notes" => nil,
                    "includes_transfer_bonus" => includes_transfer_bonus
                    }
      
      points_program = nil
      percentage = nil
      miles_required = nil
      copay = nil
      total_bonus = nil
      bonus_notes = nil
      
      total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
      
      case rate.transfereeprogram
      when "american"
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.aacostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.aacostpts * 100
          miles_required = @costs.aacostpts
          copay = @costs.aacostusd
          points_program = "American"
        end
      when "ba"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.bacostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.bacostpts * 100
          miles_required = @costs.bacostpts
          copay = @costs.bacostusd
          points_program = "British Airways"
        end
      when "united"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.uacostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.uacostpts * 100
          miles_required = @costs.uacostpts
          copay = @costs.uacostusd
          points_program = "United"
        end
      when "delta"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.dlcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.dlcostpts * 100
          miles_required = @costs.dlcostpts
          copay = @costs.dlcostusd
          points_program = "Delta"
        end
      when "alaska"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.ascostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.ascostpts * 100
          miles_required = @costs.ascostpts
          copay = @costs.ascostusd
          points_program = "Alaska"
        end
      when "spirit"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.nkcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.nkcostpts * 100
          miles_required = @costs.nkcostpts
          copay = @costs.nkcostusd
          points_program = "Spirit"
        end
      when "singapore"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.sqcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.sqcostpts * 100
          miles_required = @costs.sqcostpts
          copay = @costs.sqcostusd
          points_program = "Singapore"
        end
      when "lan"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.lacostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.lacostpts * 100
          miles_required = @costs.lacostpts
          copay = @costs.lacostusd
          points_program = "LAN"
        end
      when "aeroplan"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.accostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.accostpts * 100
          miles_required = @costs.accostpts
          copay = @costs.accostusd
          points_program = "Air Canada"
        end
      when "cathay_pacific"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.cxcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.cxcostpts * 100
          miles_required = @costs.cxcostpts
          copay = @costs.cxcostusd
          points_program = "Cathay Pacific"
        end
      when "eva"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.brcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.brcostpts * 100
          miles_required = @costs.brcostpts
          copay = @costs.brcostusd
          points_program = "EVA"
        end
      when "etihad"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.eycostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.eycostpts * 100
          miles_required = @costs.eycostpts
          copay = @costs.eycostusd
          points_program = "Etihad"
        end
      when "flying_blue"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.afcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.afcostpts * 100
          miles_required = @costs.afcostpts
          copay = @costs.afcostusd
          points_program = "Flying Blue"
        end
      when "garuda_indonesia"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.gacostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.gacostpts * 100
          miles_required = @costs.gacostpts
          copay = @costs.gacostusd
          points_program = "Garuda Indonesia"
        end
      when "malaysia"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.mhcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.mhcostpts * 100
          miles_required = @costs.mhcostpts
          copay = @costs.mhcostusd
          points_program = "Malaysia Air"
        end
      when "qantas"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.qfcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.qfcostpts * 100
          miles_required = @costs.qfcostpts
          copay = @costs.qfcostusd
          points_program = "Qantas"
        end
      when "qatar"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.qrcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.qrcostpts * 100
          miles_required = @costs.qrcostpts
          copay = @costs.qrcostusd
          points_program = "Qatar"
        end
      when "thai"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.tgcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.tgcostpts * 100
          miles_required = @costs.tgcostpts
          copay = @costs.tgcostusd
          points_program = "Thai Airways"
        end
      when "virgin_atlantic"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.vscostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.vscostpts * 100
          miles_required = @costs.vscostpts
          copay = @costs.vscostusd
          points_program = "Virgin Atlantic"
        end
      when "alitalia"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.azcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.azcostpts * 100
          miles_required = @costs.azcostpts
          copay = @costs.azcostusd
          points_program = "Alitalia"
        end
      when "ana"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.nhcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.nhcostpts * 100
          miles_required = @costs.nhcostpts
          copay = @costs.nhcostusd
          points_program = "ANA"
        end
      when "aeromexico"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.amcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.amcostpts * 100
          miles_required = @costs.amcostpts
          copay = @costs.amcostusd
          points_program = "AeroMexico"
        end
      when "el_al"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.lycostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.lycostpts * 100
          miles_required = @costs.lycostpts
          copay = @costs.lycostusd
          points_program = "El Al"
        end
      when "hawaiian"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.hacostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.hacostpts * 100
          miles_required = @costs.hacostpts
          copay = @costs.hacostusd
          points_program = "Hawaiian"
        end
      when "iberia"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.ibcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.ibcostpts * 100
          miles_required = @costs.ibcostpts
          copay = @costs.ibcostusd
          points_program = "Iberia"
        end
      when "virgin_america"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.vxcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.vxcostpts * 100
          miles_required = @costs.vxcostpts
          copay = @costs.vxcostusd
          points_program = "Virgin America"
        end
      when "air_berlin"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.abcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.abcostpts * 100
          miles_required = @costs.abcostpts
          copay = @costs.abcostusd
          points_program = "Air Berlin"
        end
      when "air_china"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.cacostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.cacostpts * 100
          miles_required = @costs.cacostpts
          copay = @costs.cacostusd
          points_program = "Air China"
        end
      when "air_new_zealand"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.nzcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.nzcostpts * 100
          miles_required = @costs.nzcostpts
          copay = @costs.nzcostusd
          points_program = "Air New Zealand"
        end
      when "asiana"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.ozcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.ozcostpts * 100
          miles_required = @costs.ozcostpts
          copay = @costs.ozcostusd
          points_program = "Asiana"
        end
      when "china_eastern"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.mucostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.mucostpts * 100
          miles_required = @costs.mucostpts
          copay = @costs.mucostusd
          points_program = "China Eastern"
        end
      when "china_southern"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.czcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.czcostpts * 100
          miles_required = @costs.czcostpts
          copay = @costs.czcostusd
          points_program = "China Southern"
        end
      when "emirates"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.ekcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.ekcostpts * 100
          miles_required = @costs.ekcostpts
          copay = @costs.ekcostusd
          points_program = "Emirates"
        end
      when "gol"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.g3costpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.g3costpts * 100
          miles_required = @costs.g3costpts
          copay = @costs.g3costusd
          points_program = "Gol"
        end
      when "hainan"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.hucostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.hucostpts * 100
          miles_required = @costs.hucostpts
          copay = @costs.hucostusd
          points_program = "Hainan"
        end
      when "jal"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.jlcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.jlcostpts * 100
          miles_required = @costs.jlcostpts
          copay = @costs.jlcostusd
          points_program = "JAL"
        end
      when "miles_and_more"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.lhcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.lhcostpts * 100
          miles_required = @costs.lhcostpts
          copay = @costs.lhcostusd
          points_program = "Lufthansa"
        end
      when "saudi_arabian"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.svcostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.svcostpts * 100
          miles_required = @costs.svcostpts
          copay = @costs.svcostusd
          points_program = "Saudia/Saudi Arabian"
        end
      when "virgin_australia"
        #total_standard_bonus = (0 + card.first_purchase_bonus + card.spend_bonus + card.spend_requirement)
        total_bonus = bonus_calculator.call(total_standard_bonus)
        
        if @costs.vacostpts.nil?
          percentage = 0
        else
          percentage = total_bonus * rate.transferratio / @costs.vacostpts * 100
          miles_required = @costs.vacostpts
          copay = @costs.vacostusd
          points_program = "Virgin Australia"
        end
      else
        #@debug_string << " Else reached."
        #puts "Else reached in results controller."
      end
      
      card_rate_etc = {"card" => card,
                    "rate" => rate,
                    "points_program" => "United",
                    "percentage" => percentage,
                    "miles_required" => miles_required,
                    "copay" => copay,
                    "total_bonus" => nil,
                    "points_in_program" => nil,
                    "bonus_notes" => nil,
                    "includes_transfer_bonus" => includes_transfer_bonus
                    }
      
      card_rate_etc["points_program"] = points_program
      card_rate_etc["percentage"] = percentage
      card_rate_etc["miles_required"] = miles_required
      card_rate_etc["copay"] = copay
      card_rate_etc["total_bonus"] = total_bonus
      card_rate_etc["additional_points_in_program"] = (if total_bonus then total_bonus else 0 end) * rate.transferratio
      card_rate_etc["bonus_notes"] = bonus_notes
      
      if percentage
        if percentage > 0
          temparray = Array.new
          temparray.push(card_rate_etc)
          
          #I'm calling this an array of card_rate_etc on diagrams
          return temparray
        end
      end
    end
end
