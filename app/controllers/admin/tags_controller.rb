class Admin::TagsController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :set_admin_tag, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /admin/tags
  # GET /admin/tags.json
  def index
    @admin_tags = Tag.all
  end

  # GET /admin/tags/new
  def new
    @admin_tag = Tag.new
  end

  # GET /admin/tags/1/edit
  def edit
  end

  # POST /admin/tags
  # POST /admin/tags.json
  def create
    @admin_tag = Tag.new(admin_tag_params)

    respond_to do |format|
      if @admin_tag.save
        format.html { redirect_to admin_tags_path, notice: 'Tag was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/tags/1
  # PATCH/PUT /admin/tags/1.json
  def update
    respond_to do |format|
      if @admin_tag.update(admin_tag_params)
        format.html { redirect_to admin_tags_path, notice: 'Tag was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/tags/1
  # DELETE /admin/tags/1.json
  def destroy
    @admin_tag.destroy
    respond_to do |format|
      format.html { redirect_to admin_tags_path, notice: 'Tag was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_tag
      @admin_tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_tag_params
      params.fetch(:tag, {}).permit(:name)
    end
end
