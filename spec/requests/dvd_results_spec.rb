require 'rails_helper'

RSpec.describe DvdResultsController, :type => :request do
  let(:params) {
    {
      appid: ENV["QIANYAN_APPID"],
      secret: ENV["QIANYAN_APPSE"],
      redirect_uri: 'redirect_uri',
      scope: 'snsapi_base',
      state: 'wechat_auth'
    }
  }



  describe "GET show" do
    xit "order_dvd render right template" do
      get "/dvd_results"
      
    end

  end
end
