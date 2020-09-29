class StreamsController < ApplicationController
  # before_action :set_stream, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:show]


  # GET /streams
  # GET /streams.json
  def index
    @streams = Stream.all
  end

  # GET /streams/1
  # GET /streams/1.json
  def show
    @subject = params[:subject]
  end

  def math

  end

  # GET /streams/new
  def new
    # @stream = Stream.new
  end

  # GET /streams/1/edit
  def edit
  end

  # POST /streams
  # POST /streams.json
  def create
    code_param = stream_params[:code]
    token_param = stream_params[:token]
    subject = params[:subject]

    actived_code = get_code_rec(code_param)
    if actived_code
      update_token(actived_code)
      # login
      login_user(actived_code)
    else
      # code not find in db, return false.
      return false
    end

    respond_to do |format|
      if actived_code.save
        format.html { redirect_to({ subject: subject, action: 'show' }, notice: 'Stream was successfully created.') }
        format.json { render :show, status: :created, location: actived_code }
      else
        format.html { render :new }
        format.json { render json: actived_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /streams/1
  # PATCH/PUT /streams/1.json
  def update
    respond_to do |format|
      if @stream.update(stream_params)
        format.html { redirect_to @stream, notice: 'Stream was successfully updated.' }
        format.json { render :show, status: :ok, location: @stream }
      else
        format.html { render :edit }
        format.json { render json: @stream.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /streams/1
  # DELETE /streams/1.json
  def destroy
    @stream.destroy
    respond_to do |format|
      format.html { redirect_to streams_url, notice: 'Stream was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def check_login
      if login?
        return
      else
        # redirect to login page.
        subject = params[:subject]
        redirect_to({ subject: subject, action: 'new' }, notice: '请输入验证码')
      end
    end

    # check whether token is the same in db.
    def login?
      if session_code && session_token
        code_rec = get_code_rec(session_code)
        return false unless code_rec
        # compare token
        code_rec.token == session_token
      else
        return false
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stream_params
      params.fetch(:stream, {}).permit(:code, :token, :subject)
    end

    # search at db
    def get_code_rec(code)
      ActivedCode.where(code: code).first
    end

    def update_token(actived_code)
      # compare session token to db token.
      token_same = session_token && actived_code.token && (session_token == actived_code.token)
      if token_same
        # same device
        return
      else
        # difference device
        set_new_token_to_db_and_session(actived_code)
      end
    end

    def set_new_token_to_db_and_session(actived_code)
      token = gen_token
      session_token=(token)
      actived_code.token = token
    end

    def login_user(actived_code)
       session_code=(actived_code.code)
    end

    def session_code
      @session_code ||= session[:actived_code]
    end

    def session_code=(code)
      session[:actived_code] ||= code
    end

    def session_token
      @session_token ||= session[:mtoken]
    end

    def session_token=(token)
      session[:mtoken] = token
    end


end
