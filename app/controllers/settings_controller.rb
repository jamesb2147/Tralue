class SettingsController < ApplicationController
  before_action :require_user
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  # GET /settings
  # GET /settings.json
  def index
    #binding.pry
    
    @settings = Setting.all
    
    if current_user.id == 1
      @settings = Setting.all
    elsif current_user.setting != nil
      redirect_to setting_path(current_user.setting.id)
    elsif current_user.setting == nil
      redirect_to new_setting_path
    end
  end

  # GET /settings/1
  # GET /settings/1.json
  def show
    #puts "Showing..."
    #binding.pry
    #ap session[:user_id]
    #ap Setting.find(params[:id]).user_id
    
    if current_user.setting.id == params[:id].to_i
      @setting = Setting.find(params[:id])
    else
      redirect_to settings_path, notice: "You are only permitted to view your settings."
    end
  end

  # GET /settings/new
  def new
    #binding.pry
    #@setting = current_user.setting.new -- didn't work because "current_user.setting" was nil (so no new method) and "current_user.settings" was undefined
    @setting = Setting.new
    
    #puts "New setting user_id:"
    #ap session[:user_id]
    @setting.user_id = session[:user_id]
  end

  # GET /settings/1/edit
  def edit
  end

  # POST /settings
  # POST /settings.json
  def create
    setting_params[:user_id] = session[:user_id]
    #binding.pry
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render action: 'show', status: :created, location: @setting }
      else
        format.html { render action: 'new' }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:user_id,
                                      :country_id,
                                      :show_business_cards,
                                      :show_personal_cards,
                                      :show_credit_cards,
                                      :show_charge_cards,
                                      :include_bonuses_in_calculations,
                                      :include_current_point_balances_in_calculations,
                                      :include_authorized_user_bonus,
                                      :fly_on_star_alliance,
                                      :fly_on_skyteam,
                                      :fly_on_oneworld,
                                      :maximum_cards_comfortable_applying_for_at_once).merge(user_id: current_user.id)
    end
end
