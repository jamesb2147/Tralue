class ResultsController < ApplicationController
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
      load_rates
    end
    
    def initialize_variables
      initialize_array_of_cards
      initialize_result_costs
    end
    
    def load_cards
      @cards = Creditcard.all
    end
    
    def load_rates
      @rates = Rate.all
    end
    
    def initialize_array_of_cards
      @result.arrayofcards = []
    end
    
    def sort_results
      @result.arrayofcards.sort_by!{ |e| e["percentage"].nil? ? 0 : e["percentage"] }.reverse!
    end
    
    def initialize_result_costs
      @costs = Trip.find(params[:id])
      @result = Result.new
      @result.name = @costs.name
      @result.costinusd = @costs.costinusd
      #@result.aacostpts = @costs.aacostpts
      #@result.aacostusd = @costs.aacostusd
      #@result.bacostpts = @costs.bacostpts
      #@result.bacostusd = @costs.bacostusd
      #@result.uacostpts = @costs.uacostpts
      #@result.uacostusd = @costs.uacostusd
      #@result.dlcostpts = costs.dlcostpts
      #@result.dlcostusd = costs.dlcostusd
      #@result.ascostpts = costs.ascostpts
      #@result.ascostusd = costs.ascostusd
      #@result.nkcostpts = costs.nkcostpts
      #@result.nkcostusd = costs.nkcostusd
      #@result.sqcostpts = costs.sqcostpts
      #@result.sqcostusd = costs.sqcostusd
      #@result.lacostpts = costs.lacostpts
      #@result.lacostusd = costs.lacostusd
      #@result.accostpts = costs.accostpts
      #@result.accostusd = costs.accostusd
      #@result.cxcostpts = costs.cxcostpts
      #@result.cxcostusd = costs.cxcostusd
      #@result.brcostpts = costs.brcostpts
      #@result.brcostusd = costs.brcostusd
      #@result.eycostpts = costs.eycostpts
      #@result.eycostusd = costs.eycostusd
      #@result.afcostpts = costs.afcostpts
      #@result.afcostusd = costs.afcostusd
      #@result.gacostpts = costs.gacostpts
      #@result.gacostusd = costs.gacostusd
      #@result.mhcostpts = costs.mhcostpts
      #@result.mhcostusd = costs.mhcostusd
      #@result.qfcostpts = costs.qfcostpts
      #@result.qfcostusd = costs.qfcostusd
      #@result.qrcostpts = costs.qrcostpts
      #@result.qrcostusd = costs.qrcostusd
      #@result.tgcostpts = costs.tgcostpts
      #@result.tgcostusd = costs.tgcostusd
      #@result.vscostpts = costs.vscostpts
      #@result.vscostusd = costs.vscostusd
      #@result.azcostpts = costs.azcostpts
      #@result.azcostusd = costs.azcostusd
      #@result.nhcostpts = costs.nhcostpts
      #@result.nhcostusd = costs.nhcostusd
      #@result.amcostpts = costs.amcostpts
      #@result.amcostusd = costs.amcostusd
      #@result.lycostpts = costs.lycostpts
      #@result.lycostusd = costs.lycostusd
      #@result.hacostpts = costs.hacostpts
      #@result.hacostusd = costs.hacostusd
      #@result.ibcostpts = costs.ibcostpts
      #@result.ibcostusd = costs.ibcostusd
      #@result.vxcostpts = costs.vxcostpts
      #@result.vxcostusd = costs.vxcostusd
      #@result.abcostpts = costs.abcostpts
      #@result.abcostusd = costs.abcostusd
      #@result.cacostpts = costs.cacostpts
      #@result.cacostusd = costs.cacostusd
      #@result.nzcostpts = costs.nzcostpts
      #@result.nzcostusd = costs.nzcostusd
      #@result.ozcostpts = costs.ozcostpts
      #@result.ozcostusd = costs.ozcostusd
      #@result.mucostpts = costs.mucostpts
      #@result.mucostusd = costs.mucostusd
      #@result.czcostpts = costs.czcostpts
      #@result.czcostusd = costs.czcostusd
      #@result.ekcostpts = costs.ekcostpts
      #@result.ekcostusd = costs.ekcostusd
      #@result.g3costpts = costs.g3costpts
      #@result.g3costusd = costs.g3costusd
      #@result.hucostpts = costs.hucostpts
      #@result.hucostusd = costs.hucostusd
      #@result.jlcostpts = costs.jlcostpts
      #@result.jlcostusd = costs.jlcostusd
      #@result.lhcostpts = costs.lhcostpts
      #@result.lhcostusd = costs.lhcostusd
      #@result.svcostpts = costs.svcostpts
      #@result.svcostusd = costs.svcostusd
      #@result.vacostpts = costs.vacostpts
      #@result.vacostusd = costs.vacostusd
    end
    
    def is_active(card)
      return card.active
    end
    
    def test (blah, &block)
      puts "Test called."
      puts blah + block.call()
    end
    
    def match_cards_and_programs
      @result.arrayofcards = []
      
      @rates.each do |rate|
        @cards.each do |card|
          if is_active(card)
            if card.points_program == rate.transferringprogram
              if @result.arrayofcards == nil
                @result.arrayofcards = []
              end
              
              case rate.transferringprogram
              when "spg"
                puts "SPG handler..."
                bonus_handler(rate, card, true) { |total_standard_bonus| ((total_standard_bonus / 20000) * 5000 + total_standard_bonus) }
              else
                puts "Non bonus handler..."
                test("foo") { "bar" }
                bonus_handler(rate, card, nil) { |total_standard_bonus| 0 + total_standard_bonus }
              end
            end
          end
        end
      end
      
      @cards.each do |card|
        if is_active(card)
        
          puts "Creating a rate with: " + card.name + " and points program: " + card.points_program
        
          rate = Rate.new(transferringprogram: card.points_program,
                          transfereeprogram: card.points_program,
                          transferratio: 1.0)
        
          bonus_handler(rate, card, nil) { |total_standard_bonus| 0 + total_standard_bonus }
        end
      end
    end
    
    def bonus_handler(rate_arg, card_arg, transfer_bonus_arg, &bonus_calculator)
      #percentage_calculator = { percentage = ((card.first_purchase_bonus + card.spend_bonus + card.spend_requirement) * rate.transferratio) / @result.aacostpts * 100 }
      rate = rate_arg
      card = card_arg
      includes_transfer_bonus = transfer_bonus_arg
      
      temphash = {"card" => card,
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
      
      #temphash["points_program"] = points_program
      #temphash["percentage"] = percentage
      #temphash["miles_required"] = miles_required
      #temphash["copay"] = copay
      #temphash["total_bonus"] = total_bonus
      #temphash["additional_points_in_program"] = total_bonus * rate.transferratio
      #temphash["bonus_notes"] = bonus_notes
      
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
      when "aircanada"
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
      when "airberlin"
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
      when "airchina"
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
        puts "Else reached in results controller."
      end
      
      temphash = {"card" => card,
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
      
      temphash["points_program"] = points_program
      temphash["percentage"] = percentage
      temphash["miles_required"] = miles_required
      temphash["copay"] = copay
      temphash["total_bonus"] = total_bonus
      temphash["additional_points_in_program"] = (if total_bonus then total_bonus else 0 end) * rate.transferratio
      temphash["bonus_notes"] = bonus_notes
      
      puts "Card: " + temphash["card"].name
      puts "Points program: " + temphash["points_program"]
      puts "Percentage: " + percentage
      
      if percentage
        if percentage > 0
          @result.arrayofcards.push(temphash)
        end
      end
    end
    
    def non_bonus_handler(rate_arg, card_arg, transfer_bonus_arg, &bonus_calculator)
      #percentage_calculator = { percentage = ((card.first_purchase_bonus + card.spend_bonus + card.spend_requirement) * rate.transferratio) / @result.aacostpts * 100 }
      rate = rate_arg
      card = card_arg
      includes_transfer_bonus = transfer_bonus_arg
      
      temphash = {"card" => card,
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
      
      #temphash = {"card" => card,
      #              "rate" => rate,
      #              "points_program" => "United",
      #              "percentage" => percentage,
      #              "miles_required" => miles_required,
      #              "copay" => copay,
      #              "total_bonus" => nil,
      #              "points_in_program" => nil,
      #              "bonus_notes" => nil,
      #              "includes_transfer_bonus" => true
      #              }
      
      temphash["points_program"] = points_program
      temphash["percentage"] = percentage
      temphash["miles_required"] = miles_required
      temphash["copay"] = copay
      temphash["total_bonus"] = total_bonus
      temphash["additional_points_in_program"] = (if total_bonus then total_bonus else 0 end) * rate.transferratio
      temphash["bonus_notes"] = bonus_notes
      
      if percentage
        if percentage > 0
          @result.arrayofcards.push(temphash)
        end
      end
    end
end
