class MessagesController < ApplicationController
  load_and_authorize_resource
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.where(:procedure_id => params[:procedure_id]).order(created_at: :asc)
    @procedure = Procedure.find(params[:procedure_id])
    @new_message = Message.new
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
        #Delete old notification of the same topic
        Notification.where(reference_id: params[:procedure_id], notification_type: 4).destroy_all

        #Create notification
        if current_user.prosecutor.present?
          police_unit_id =  @message.procedure.police_unit_in_charge.id
          police_unit_users = User.where(police_unit_id: police_unit_id)

          #Send notifiaction to the associated users
          police_unit_users.each { |user|
            Notification.create(user_id: user.id, notification_type: 4, reference_id: params[:procedure_id], seen: false)
          }
        elsif current_user.police_unit.present?
          local_prosecution_id =  @message.procedure.local_prosecution_in_charge.id
          prosecutors = Prosecutor.not_deleted.where(local_prosecution_id: local_prosecution_id)

          #Send notification to the associated users
          prosecutors.each { |pros|
            if pros.user != nil
              Notification.create(user_id: pros.user.id, notification_type: 4, reference_id: params[:procedure_id], seen: false)
            end
          }
        end
        #Reload page
        format.js {render inline: "location.reload();" }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:user_id, :procedure_id, :content)
    end
end
