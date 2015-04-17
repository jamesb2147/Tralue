class TripsController < ApplicationController
  before_action :require_user
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  # GET /trips
  # GET /trips.json
  def index
    @trips = current_user.trips
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
  end

  # GET /trips/new
  def new
    @trip = current_user.trips.new
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = current_user.trips.new(trip_params)

    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trip }
      else
        format.html { render action: 'new' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      #user is presumably guaranteed to be logged in, so we're just stealing that login data here
      trip_params[:user_id] = session[:user_id]
      
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = current_user.trips.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:name,
                                   :user_id,
                                   :costinusd,
                                   :aacostpts, :aacostusd,
                                   :bacostpts, :bacostusd,
                                   :uacostpts, :uacostusd,
                                   :dlcostpts, :dlcostusd,
                                   :ascostpts, :ascostusd,
                                   :nkcostpts, :nkcostusd,
                                   :sqcostpts, :sqcostusd,
                                   :lacostpts, :lacostusd,
                                   :accostpts, :accostusd,
                                   :cxcostpts, :cxcostusd,
                                   :brcostpts, :brcostusd,
                                   :eycostpts, :eycostusd,
                                   :afcostpts, :afcostusd,
                                   :gacostpts, :gacostusd,
                                   :mhcostpts, :mhcostusd,
                                   :qfcostpts, :qfcostusd,
                                   :qrcostpts, :qrcostusd,
                                   :tgcostpts, :tgcostusd,
                                   :vscostpts, :vscostusd,
                                   :azcostpts, :azcostusd,
                                   :nhcostpts, :nhcostusd,
                                   :amcostpts, :amcostusd,
                                   :lycostpts, :lycostusd,
                                   :hacostpts, :hacostusd,
                                   :ibcostpts, :ibcostusd,
                                   :vxcostpts, :vxcostusd,
                                   :abcostpts, :abcostusd,
                                   :cacostpts, :cacostusd,
                                   :nzcostpts, :nzcostusd,
                                   :ozcostpts, :ozcostusd,
                                   :mucostpts, :mucostusd,
                                   :czcostpts, :czcostusd,
                                   :ekcostpts, :ekcostusd,
                                   :g3costpts, :g3costusd,
                                   :hucostpts, :hucostusd,
                                   :jlcostpts, :jlcostusd,
                                   :lhcostpts, :lhcostusd,
                                   :svcostpts, :svcostusd,
                                   :vacostpts, :vacostusd)
    end
end
