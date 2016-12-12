class PinsController < ApplicationController
    
    before_action :require_login, except: [:show, :show_by_name]
  
  def index
    @pins = Pin.all
  end
  
  def show
    @pin = Pin.find(params[:id])
    # populate @users with all users who have pinned this pin
    @users = @pin.users
    #@users = User.joins(:pinnings).where("users.id = ? or pinnings.pin_id = ?", @pin.user_id, @pin.id).distinct
    @pins = current_user.pins
    @board = Board.find(params[:id])
  end
    
    def show_by_name
        @pin = Pin.find_by_slug(params[:slug])
        @users = @pin.users
        #@users = User.joins(:pinnings).where("users.id = ? or pinnings.pin_id = ?", @pin.user_id, @pin.id).distinct
        @user = current_user
        render :show
    end
    
    def new
        @pin = Pin.new
        @pin.pinnings.build
        #render :new
    end
    
    def edit
        @pin = Pin.find(params[:id])
        render :edit
    end
    
    def create
        @pin = Pin.create(pin_params)
        #@pin = current_user.pins.new(pin_params)
     if @pin.valid?
        @pin.save
        if params[:pin][:pinning][:board_id]
            board = Board.find(params[:pin][:pinning][:board_id])
            @pin.pinnings.create!(user: current_user, board: board)
        end
            redirect_to pin_path(@pin)
     else
        @errors = @pin.errors
        render :new
    end
  end

    
    def update
        @pin = Pin.find(params[:id])
        
        if @pin.update_attributes(pin_params)  
            redirect_to pin_path(@pin), notice: "Pin has been successfully updated."
      else
            @errors = @pin.errors
            render :edit

      end
    end

    def repin
        @pin = Pin.find(params[:id])
        board = Board.find(params[:pin][:pinning][:board_id])
        @pin.pinnings.create(user: current_user, board: board)
        redirect_to user_path(current_user)
    end

    private
    def pin_params
        params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image, :user_id, pinnings_attributes: [:user_id, :id, :board_id])
    end
    
end
