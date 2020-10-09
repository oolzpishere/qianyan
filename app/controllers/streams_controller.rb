class StreamsController < ApplicationController
  protect_from_forgery except: :login_status

  # before_action :set_stream, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:show]
  before_action :subject, only: [:show, :login_status]

  # GET /streams
  # GET /streams.json
  def index
    @streams = Stream.all
  end

  # GET /streams/1
  # GET /streams/1.json
  def show
    @subject = subject
    @live_link = get_live_link(subject)
    @session_code
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
    subject_param = stream_params[:subject]

    actived_code = get_code_rec(code_param, subject_param)
    new_token = gen_token
    actived_code.token = new_token

    respond_to do |format|
      # if find actived_code in db and save success, login_user and return success action.
      if actived_code && actived_code.save
        # login
        login_user(code_param, new_token)

        format.html { redirect_to({ subject: subject_param, action: 'show' }, notice: '验证成功') }
        format.json { render :show, status: :created, location: actived_code }
      else
        format.html { render :new }
        format.json { render json: actived_code.errors, status: :unprocessable_entity }
      end
    end
  end

  def login_status
    respond_to do |format|
      if login?
        format.json { render json: {login_status: true}, status: :ok }
      else
        format.json { render json: {login_status: false}, status: :ok }
      end
    end
  end

  # PATCH/PUT /streams/1
  # PATCH/PUT /streams/1.json
  # def update
  #   respond_to do |format|
  #     if @stream.update(stream_params)
  #       format.html { redirect_to @stream, notice: 'Stream was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @stream }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @stream.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /streams/1
  # DELETE /streams/1.json
  # def destroy
  #   @stream.destroy
  #   respond_to do |format|
  #     format.html { redirect_to streams_url, notice: 'Stream was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Subject have to be a word character ([a-zA-Z0-9_]) and at least have one character.
    SUBJECT_REX = /\A\w+\Z/
    # Use callbacks to share common setup or constraints between actions.
    def check_login
      if login?
        return
      else
        # redirect to login page.
        redirect_to({ subject: subject, action: 'new' }, notice: '请输入验证码')
      end
    end

    # check whether token is the same in db.
    def login?
      if session_code && session_token
        # check code exist at db.
        code_rec = get_code_rec(session_code, subject)
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
    def get_code_rec(code, subject)
      # make sure subject don't have illegal character.
      raise "subject only allow word character." unless subject.match(SUBJECT_REX)
      ActivedCode.joins(:subject).where(code: code, subjects: { name: subject }).first
    end

    def gen_token
      SecureRandom.base64(32)
    end

    def login_user(code, new_token)
       set_session_code(code)
       set_session_token(new_token)
    end

    def session_code
      @session_code ||= session[:actived_code]
    end

    def set_session_code(code)
      session[:actived_code] = code
    end

    def session_token
      @session_token ||= session[:mtoken]
    end

    def set_session_token(token)
      session[:mtoken] = token
    end

    def subject
      params[:subject] || params['subject']
    end

    def get_live_link(subject)
      case subject.to_s
      when "math"
        "http://www.bilibili.com"
      when "chinese"
        "http://www.bilibili.com"
      when "english"
        "http://www.bilibili.com"
      end
    end


end
