class DvdRequestsController < ApplicationController
  #before_action :set_dvd_request, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_pass, only: [:create]

  # GET /dvd_requests
  # GET /dvd_requests.json
  def index
    @dvd_requests = DvdRequest.all
  end

  # GET /dvd_requests/1
  # GET /dvd_requests/1.json
  def show
  end

  # GET /dvd_requests/new
  def new
    @dvd_request = DvdRequest.new
  end

  # GET /dvd_requests/1/edit
  def edit
  end

  # POST /dvd_requests
  # POST /dvd_requests.json
  def create
    @dvd_request = DvdRequest.new(dvd_request_params)

    respond_to do |format|
      if @dvd_request.save
        format.html { redirect_to @dvd_request, notice: 'Dvd request was successfully created.' }
        format.json { render :show, status: :created, location: @dvd_request }
      else
        format.html { render :new }
        format.json { render json: @dvd_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dvd_requests/1
  # PATCH/PUT /dvd_requests/1.json
  def update
    respond_to do |format|
      if @dvd_request.update(dvd_request_params)
        format.html { redirect_to @dvd_request, notice: 'Dvd request was successfully updated.' }
        format.json { render :show, status: :ok, location: @dvd_request }
      else
        format.html { render :edit }
        format.json { render json: @dvd_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dvd_requests/1
  # DELETE /dvd_requests/1.json
  def destroy
    @dvd_request.destroy
    respond_to do |format|
      format.html { redirect_to dvd_requests_url, notice: 'Dvd request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dvd_request
      @dvd_request = DvdRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dvd_request_params
      params.fetch(:dvd_request, {})
    end

    def authenticate_pass
      # like: http://localhost:3000/results?pass=ENV["QIANYAN_FORM_PASS"]
      unless params[:pass] == ENV["QIANYAN_PASS"]
        return render json: {'fail':'need pass'}.to_json, status: :bad_request
      end
    end
end
