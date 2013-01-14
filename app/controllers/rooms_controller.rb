class RoomsController < ApplicationController
  before_filter :require_authentication, :only => [:new, :edit, :create, :update, :destroy]

  def index
    @search_query = params[:q]

    rooms = Room.search(@search_query)
    @rooms = Room.most_recent.map do |room|
      #nao exibiremos o formulario na listagem
      RoomPresenter.new(room, self, false)
    end
  end

  def show
    room_model = Room.find(params[:id])

    @room = RoomPresenter.new(room_model, self)
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
    @room = current_user.rooms.find(params[:id])
  end

  def create
    @room = current_user.rooms.build(params[:room])

    if @room.save
      redirect_to @room, :notice => t('flash.notice.room_created')
    else
      render action: "new"
    end
  end

  def update
    @room = current_user.rooms.find(params[:id])

    if @room.update_attributes(params[:room])
      redirect_to @room, :notice => t('flash.notice.room_update')
    else
      render :action => "edit"
    end
  end

  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy

    redirect_to rooms_url
  end
  
  
end
