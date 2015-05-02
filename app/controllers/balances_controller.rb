class BalancesController < ApplicationController
  before_action :set_balance, only: [:show, :edit, :update, :destroy]

  # GET /balances
  # GET /balances.json
  def index
    @balances = Balance.all
  end

  # GET /balances/1
  # GET /balances/1.json
  def show
  end

  # GET /balances/new
  def new
    @balance = Balance.new
  end

  # GET /balances/1/edit
  def edit
  end

  # POST /balances
  # POST /balances.json
  def create
    @balance = Balance.new(balance_params)

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
    @balance.destroy
    respond_to do |format|
      format.html { redirect_to balances_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_balance
      @balance = Balance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def balance_params
      params.require(:balance).permit(:aacostpts, :bacostpts, :uacostpts, :dlcostpts, :ascostpts, :nkcostpts, :sqcostpts, :lacostpts, :accostpts, :cxcostpts, :brcostpts, :eycostpts, :afcostpts, :gacostpts, :mhcostpts, :qfcostpts, :qrcostpts, :tgcostpts, :vscostpts, :azcostpts, :nhcostpts, :amcostpts, :lycostpts, :hacostpts, :ibcostpts, :vxcostpts, :abcostpts, :cacostpts, :nzcostpts, :ozcostpts, :mucostpts, :czcostpts, :ekcostpts, :g3costpts, :hucostpts, :jlcostpts, :lhcostpts, :svcostpts, :vacostpts)
    end
end
