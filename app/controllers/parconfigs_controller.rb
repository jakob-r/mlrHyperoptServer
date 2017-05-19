class ParconfigsController < ApplicationController
  before_filter :check_logged_in, :only => [:edit, :update, :destroy, :new]
  before_action :set_parconfig, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session

  # GET /parconfigs
  # GET /parconfigs.json
  def index
    if (params[:key])
      @parconfigs = Parconfig.where(params[:key] => params[:value])
    else
      @parconfigs = Parconfig.all
    end
  end

  # GET /parconfigs/1
  # GET /parconfigs/1.json
  def show
  end

  # GET /parconfigs/new
  def new
    @parconfig = Parconfig.new
  end

  # GET /parconfigs/1/edit
  def edit
  end

  # POST /parconfigs
  # POST /parconfigs.json
  def create
    @parconfig = Parconfig.new(parconfig_params)

    respond_to do |format|
      if @parconfig.save
        format.html { redirect_to @parconfig, notice: 'Parconfig was successfully created.' }
        format.json { render :show, status: :created, location: @parconfig }
      else
        format.html { render :new }
        format.json { render json: @parconfig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parconfigs/1
  # PATCH/PUT /parconfigs/1.json
  def update
    respond_to do |format|
      if @parconfig.update(parconfig_params)
        format.html { redirect_to @parconfig, notice: 'Parconfig was successfully updated.' }
        format.json { render :show, status: :ok, location: @parconfig }
      else
        format.html { render :edit }
        format.json { render json: @parconfig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parconfigs/1
  # DELETE /parconfigs/1.json
  def destroy
    @parconfig.destroy
    respond_to do |format|
      format.html { redirect_to parconfigs_url, notice: 'Parconfig was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parconfig
      @parconfig = Parconfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parconfig_params
      params.require(:parconfig).permit(:user_email, :json_parconfig, :json_parvals, :learner_class, :learner_type, :learner_name, :download_count, :upload_count, :default, :note)
    end

    def check_logged_in
      authenticate_or_request_with_http_basic("parconfigs") do |username, password|
      username == "admin" && password == "mlrmlrmlr"
    end
  end
end
