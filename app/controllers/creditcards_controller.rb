class CreditcardsController < ApplicationController
  before_action :set_creditcard, only: [:show, :edit, :update, :destroy]

  # GET /creditcards
  # GET /creditcards.json
  def index
    @creditcards = Creditcard.all
  end

  # GET /creditcards/1
  # GET /creditcards/1.json
  def show
    #was binding.pry
  end

  # GET /creditcards/new
  def new
    @creditcard = Creditcard.new
  end

  # GET /creditcards/1/edit
  def edit
  end

  # POST /creditcards
  # POST /creditcards.json
  def create
    #binding.pry
    @creditcard = Creditcard.new(creditcard_params)
    #binding.pry
    respond_to do |format|
      if @creditcard.save
        #puts "saved"
        format.html { redirect_to @creditcard, notice: 'Creditcard was successfully created.' }
        format.json { render action: 'show', status: :created, location: @creditcard }
      else
        #puts "not saved"
        format.html { render action: 'new' }
        format.json { render json: @creditcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /creditcards/1
  # PATCH/PUT /creditcards/1.json
  def update
    respond_to do |format|
      if @creditcard.update(creditcard_params)
        format.html { redirect_to @creditcard, notice: 'Creditcard was successfully updated.' }
        format.json { head :no_content }
      else
        puts "Credit card was not successfully updated. Something went wrong."
        format.html { render action: 'edit' }
        format.json { render json: @creditcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /creditcards/1
  # DELETE /creditcards/1.json
  def destroy
    @creditcard.destroy
    respond_to do |format|
      format.html { redirect_to creditcards_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_creditcard
      @creditcard = Creditcard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def creditcard_params
      params.require(:creditcard).permit(:name,
                                         :issuer,
                                         :annual_fee,
                                         :fee_waived_first_year,
                                         :points_program,
                                         :spend_bonus,
                                         :spend_requirement,
                                         :time_to_reach_spend_in_months,
                                         :first_purchase_bonus,
                                         :second_year_spend_bonus,
                                         :second_year_spend_requirement,
                                         :second_year_time_to_reach_spend_in_months,
                                         :points_per_dollar_spent_general_spend,
                                         :foreign_transaction_fee,
                                         :chip,
                                         :notes,
                                         :business,
                                         :personal,
                                         :image_index,
                                         :url,
                                         :country_id,
                                         :charge,
                                         :credit,
                                         :bonus_elite_miles,
                                         :elite_miles_spending_threshold,
                                         :max_times_elite_miles_can_be_earned,
                                         :active)
    end
end
