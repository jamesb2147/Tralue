class BalancesController < ApplicationController
  before_action :require_user
  #before_action :set_balance, only: [:my_balance, :show, :edit, :update, :destroy]

  # GET /balances
  # GET /balances.json
  def index
    @balances = Balance.all
    
    if current_user.id == 1
      @balances = Balance.all
    elsif current_user.balance != nil
      redirect_to balance_path(current_user.balance.id)
    elsif current_user.balance == nil
      redirect_to new_balance_path
    end
  end
  
  def my_balance
    
  end

  # GET /balances/1
  # GET /balances/1.json
  def show
    #binding.pry
    if current_user.balance.nil?
      redirect_to new_balance_path
    elsif current_user.balance.id == params[:id].to_i
      @balance = Balance.find(params[:id])
    else
      redirect_to balance_path, notice: "You are only permitted to view your settings."
    end
  end

  # GET /balances/new
  def new
    @balance = Balance.new
  end

  # GET /balances/1/edit
  def edit
    @balance = Balance.find(params[:id])
  end

  # POST /balances
  # POST /balances.json
  def create
    @balance = current_user.build_balance(balance_params)

    respond_to do |format|
      if @balance.save
        format.html { redirect_to @balance, notice: 'Balance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @balance }
      else
        format.html { render action: 'new' }
        format.json { render json: @balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /balances/1
  # PATCH/PUT /balances/1.json
  def update
    respond_to do |format|
      if @balance.update(balance_params)
        format.html { redirect_to @balance, notice: 'Balance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /balances/1
  # DELETE /balances/1.json
  def destroy
    #binding.pry
    @balance = Balance.find(params[:id])
    @balance.destroy
    respond_to do |format|
      format.html { redirect_to balances_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_balance
    #  #@balance = Balance.find(params[:id])
    #  if current_user.balance.nil?
    #    redirect_to new_balance_path and return
    #  else
    #    @balance = current_user.balance
    #    puts "User ID: "
    #    puts @balance.user_id
    #  end
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    def balance_params
      params.require(:balance).permit(:user,
                                      :user_id,
                                      :mrbalance,
                                      :urbalance,
                                      :spgbalance,
                                      :tybalance,
                                      :aabalance,
                                      :babalance,
                                      :uabalance,
                                      :dlbalance,
                                      :asbalance,
                                      :nkbalance,
                                      :sqbalance,
                                      :labalance,
                                      :acbalance,
                                      :cxbalance,
                                      :brbalance,
                                      :eybalance,
                                      :afbalance,
                                      :gabalance,
                                      :mhbalance,
                                      :qfbalance,
                                      :qrbalance,
                                      :tgbalance,
                                      :vsbalance,
                                      :azbalance,
                                      :nhbalance,
                                      :ambalance,
                                      :lybalance,
                                      :habalance,
                                      :ibbalance,
                                      :vxbalance,
                                      :abbalance,
                                      :cabalance,
                                      :nzbalance,
                                      :ozbalance,
                                      :mubalance,
                                      :czbalance,
                                      :ekbalance,
                                      :g3balance,
                                      :hubalance,
                                      :jlbalance,
                                      :lhbalance,
                                      :svbalance,
                                      :vabalance).merge(user_id: current_user.id)
    end
end
