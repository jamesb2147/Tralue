class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end
  
  def show
    @trip = Trip.find(params[:id])
  end
  
  def new
    @trip = Trip.new
  end
  
  def edit
    @trip = Trip.find(params[:id])
  end
  
  def create
    @trip = Trip.create(trip_check) #bleh
    
    if @trip.save
      redirect_to @trip
    else
      render 'new'
    end
    
  end
  
  def update 
    @trip = Trip.find(params[:id])
    
    if @trip.update(trip_check)
      redirect_to @trip
    else
      render 'edit'
    end
    
  end
  
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    
    redirect_to trips_path
  end
  
  private
    #require all new entries to have these four fields, at a minimum, INCLUDING notes
    def trip_check
      params.require(:trip).permit(:name,
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