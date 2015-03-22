class RatesController < ApplicationController
  http_basic_authenticate_with name: "shunter", password: "derpderp", except: [:index]
  
  def index
    @rates = Rate.all
  end
  
  def show
    @rate = Rate.find(params[:id])
  end
  
  def new
    @rate = Rate.new
  end
  
  def edit
    @rate = Rate.find(params[:id])
  end
  
  def create
    @rate = Rate.create(transfer_rate_check) #bleh
    
    if @rate.save
      redirect_to @rate
    else
      render 'new'
    end
    
  end
  
  def update 
    @rate = Rate.find(params[:id])
    
    if @rate.update(transfer_rate_check)
      redirect_to @rate
    else
      render 'edit'
    end
    
  end
  
  def destroy
    @rate = Rate.find(params[:id])
    @rate.destroy
    
    redirect_to rates_path
  end
  
  private
    #require all new entries to have these four fields, at a minimum, INCLUDING notes
    def transfer_rate_check
      params.require(:rate).permit(:transferringprogram,
                                           :transfereeprogram,
                                           :transferratio,
                                           :transfernotes)
    end
end