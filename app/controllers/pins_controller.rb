class PinsController < ApplicationController
    
    before_action :require_login, except: [:show, :show_by_name]
  
  def index
      @pins = current_user.pins.all
  end
  
  def show
      @pin = current_user.pins.find(params[:id])
  end
    
    def show_by_name
        @pin = current_user.pins.find_by_slug(params[:slug])
        render :show
    end
    
    def new
        @pin = current_user.pins.new
    end
    
    def edit
        @pin = current_user.pins.find(params[:id])
    end
    
    def create
        @pin = current_user.pins.create(pin_params)
        
        if @pin.valid?
            @pin.save
            redirect_to pin_path(@pin)
            else
            @errors = @pin.errors
            render :new
        end
    end
    
    def update
        @pin = current_user.pins.find(params[:id])
        
        if @pin.update_attributes(pin_params)  
            redirect_to pin_path(@pin), notice: "Pin has been successfully updated."
      else
            @errors = @pin.errors
            render action: "edit"

      end
    end
    
    private
    def pin_params
        params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image, :user_id)
    end
    
end
