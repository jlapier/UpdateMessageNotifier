class UpdateMessagesController < ApplicationController
  before_filter :require_admin, :except => [ :index, :show ]

  def index
    @update_messages = UpdateMessage.published.limit(10)
    if user_is_admin?
      @unpublished_messages = UpdateMessage.unpublished
    end
  end

  def show
    @update_message = UpdateMessage.find(params[:id])
    if @update_message.published_on or user_is_admin?
      if current_user
        current_user.update_last_read_message(@update_message)
      end
    else
      redirect_to update_messages_url
    end
  end

  def new
    @update_message = UpdateMessage.new
  end

  def edit
    @update_message = UpdateMessage.find(params[:id])
  end

  def create
    @update_message = UpdateMessage.new(params[:update_message])
    @update_message.user = current_user 
    if @update_message.save
      flash[:notice] = "Message created!"
      redirect_to @update_message
    else
      flash.now.alert = "Oops, something went wrong: #{@update_message.errors.full_messages.join('; ')}"
      render 'new'
    end
  end

  def update
    @update_message = UpdateMessage.find(params[:id])
    if @update_message.update_attributes(params[:update_message])
      flash[:notice] = "Message updated!"
      redirect_to @update_message
    else
      render 'edit'
    end
  end

  def destroy
    if UpdateMessage.destroy(params[:id])
      flash[:notice] = "Update message deleted."
    else
      flash[:warning] = "Could not find update message."
    end
    redirect_to update_messages_url
  end
end
