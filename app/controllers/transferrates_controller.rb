class TransferratesController < ApplicationController
  def index
    @transferrates = TransferRate.all
  end
  
  def show
    @transferrate = TransferRate.find(params[:id])
  end
  
  def new
    @transferrate = TransferRate.new
  end
  
  def edit
    @transferrate = TransferRate.find(params[:id])
  end
  
  def create
    @transferrate = TransferRate.create(transfer_rate_check) #bleh
    
    if @transferrate.save
      redirect_to @transferrate
    else
      render 'new'
    end
    
  end
  
  def update 
    @transferrate = TransferRate.find(params[:id])
    
    if @transferrate.update(transfer_rate_check)
      redirect_to @transferrate
    else
      render 'edit'
    end
    
  end
  
  def destroy
    @transferrate = TransferRate.find(params[:id])
    @transferrate.destroy
    
    redirect_to transfer_rates_path
  end
  
  private
    #require all new entries to have these four fields, at a minimum, INCLUDING notes
    def transfer_rate_check
      params.require(:transferrate).permit(:transferringprogram,
                                           :transfereeprogram,
                                           :transferratio,
                                           :transfernotes)
    end
end