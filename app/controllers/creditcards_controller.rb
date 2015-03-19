class CreditcardsController < ApplicationController
  def index 
    @creditcards = Creditcard.all
  end
  
  def show 
    @creditcard = Creditcard.find(params[:id])
  end
  
  def new
    @creditcard = Creditcard.new
    #code
  end
  
  def edit
    @creditcard = Creditcard.find(params[:id])
    
  end
  
  def create
    @creditcard = Creditcard.new(check_creditcard_params)
    
    if @creditcard.save
      redirect_to @creditcard
    else
      render 'new'
    end
  end
  
  def update
    @creditcard = Creditcard.find(params[:id])
    
    if @creditcard.update(check_creditcard_params)
      redirect_to @creditcard
    else
      render 'edit'
    end
    
  end
  
  def destroy
    @creditcard = Creditcard.find(params[:id])
    @creditcard.destroy
    
    redirect_to creditcards_path
  end
  
  private
    def check_creditcard_params
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
                                         :points_per_dollar_spend_general_spend,
                                         :foreign_transaction_fee,
                                         :chip,
                                         :notes,
                                         :business,
                                         :personal,
                                         :image_index,
                                         :url)
      #code
    end
end
