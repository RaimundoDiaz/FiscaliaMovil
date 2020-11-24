class Admin::UsersController < ApplicationController
  before_action :set_admin_user, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /admin/users
  # GET /admin/users.json
  def index
    if current_user.local_prosecution.present?
      fiscalia = current_user.local_prosecution
      @users = User.not_deleted.joins(:prosecutor).where(prosecutors: { local_prosecution: fiscalia })
    elsif current_user.police_unit.present?
      @users = User.not_deleted.where(police_unit: current_user.police_unit)
    else
      @users = User.not_deleted
    end

  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @user = User.new(admin_user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'El administrador ha sido creado con éxito.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    if params[:user][:password] == ""
      params[:user].delete(:password)
    end
    respond_to do |format|
      if @user.update(admin_user_params)
        format.html { redirect_to admin_users_path, notice: 'El administrador ha sido actualizado con éxito.' }
      else
        format.html { redirect_to edit_admin_user_path(@user, role: params[:role]), alert: 'Usuario no actualizado' }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    #@user.destroy
    @user.soft_delete
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'Administrador ha sido eliminado con éxito..' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_user_params
      params.fetch(:user, {}).permit(:email, :password, :admin, :police_unit_id, :prosecutor_id)
    end
end
