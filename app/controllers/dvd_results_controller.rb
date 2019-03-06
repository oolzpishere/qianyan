class DvdResultsController < ApplicationController
  if Rails.env.match(/production/)
    before_action :invoke_wx_auth , if: Proc.new { |c| c.request.format != 'application/json' && !c.request.local? }
    before_action :get_wechat_sns , if: Proc.new { |c| c.request.format != 'application/json' && !c.request.local? }
  end

  # before_action :set_dvd_result, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_pass, only: [:create]
  before_action :set_dvd_result, only: [:show, :edit, :update, :destroy]
  before_action :subject_class, only: [:index, :show, :create]
  protect_from_forgery except: :create, if: Proc.new { |c| c.request.format == 'application/json' }
  # GET /dvd_results
  # GET /dvd_results.json
  def index
    @openid_results = []
    if subject_class
      @dvd_results = subject_class.order(id: :desc).all
      s_order = Rails.env.match(/production/) ? @dvd_results.select {|result| result.openid == session[:openid]} : @dvd_results
      @openid_results  << s_order
    else
      # show all, if not given subject_class
      if params[:period] == 2018
        subject_names = %w(MathDvd EnglishDvd ChineseDvd)
      else
        subject_names = %w(MathADvd EnglishADvd ChineseADvd)
      end

      subject_names.each do |name|
        orders = name.camelize.constantize.order(id: :desc).all
        s_order = Rails.env.match(/production/) ? orders.select {|o| o.openid == session[:openid]} : orders
        @openid_results << s_order if !s_order.empty?
      end
    end

  end

  # GET /dvd_results/1
  # GET /dvd_results/1.json
  def show
  end

  # GET /dvd_results/new
  def new
    @dvd_result = DvdResult.new
  end

  # GET /dvd_results/1/edit
  def edit
  end

  # POST /dvd_results
  # POST /dvd_results.json
  def create
    # @dvd_result = DvdResult.new(dvd_result_params)

    hash = {
      "id" => dvd_result_params.dig(:entry, :serial_number) ||  dvd_result_params[:id],
      "openid" => dvd_result_params.dig(:entry, :x_field_weixin_openid) || dvd_result_params[:openid],
      "created_at" => dvd_result_params.dig(:entry, :created_at) || dvd_result_params[:created_at],
      "updated_at" => dvd_result_params.dig(:entry, :updated_at) || dvd_result_params[:updated_at]
    }
    dvd_result_params_merged = dvd_result_params.merge hash

    if subject_class.exists?(hash["id"])
      result = subject_class.find(hash["id"])
      respond_to do |format|
        if result.update(dvd_result_params_merged)
          format.html { redirect_to result, notice: 'Result was successfully updated.' }
          format.json { render json: result, status: :created }
        else
          format.html { render :edit }
          format.json { render json: result.errors, status: :unprocessable_entity }
        end
      end
    else
      result = subject_class.new(dvd_result_params_merged)
      respond_to do |format|
        if result.save
          format.html { redirect_to @dvd_result, notice: 'Dvd request was successfully created.' }
          format.json { render json: result, status: :created }
        else
          format.html { render :new }
          format.json { render json: @dvd_result.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /dvd_results/1
  # PATCH/PUT /dvd_results/1.json
  def update
    respond_to do |format|
      if @dvd_result.update(dvd_result_params)
        format.html { redirect_to @dvd_result, notice: 'Dvd result was successfully updated.' }
        format.json { render :show, status: :ok, location: @dvd_result }
      else
        format.html { render :edit }
        format.json { render json: @dvd_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dvd_results/1
  # DELETE /dvd_results/1.json
  def destroy
    @dvd_result.destroy
    respond_to do |format|
      format.html { redirect_to dvd_results_url, notice: 'Dvd result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dvd_result
      @dvd_result = subject_class.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dvd_result_params
      params.fetch(:dvd_result, {}).permit(:id, :form, :form_name, :openid, :created_at, :updated_at, :data_type, :entry => {})
    end

    def authenticate_pass
      # like: http://localhost:3000/results?pass=ENV["QIANYAN_FORM_PASS"]
      unless params[:pass] == ENV["QIANYAN_PASS"]
        return render json: {'fail':'pass not correct'}.to_json, status: :bad_request
      end
    end

    def subject_class
      subject = params[:subject] && params[:subject].camelize
      if subject_class_exist?(subject)
        subject.constantize
      end
    end

    def subject_class_exist?(subject)
      subject_names.include?(subject)
    end

    def subject_names
      Rails.application.eager_load!
      ActiveRecord::Base.descendants.map(&:name)
    end
end
