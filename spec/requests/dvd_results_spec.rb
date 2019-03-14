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
    it "order_dvd render right template" do
      oauth = instance_double("WechatAuth::Oauth", :redirect_uri => "redirect_uri")
      get "/dvd_results"
      expect(response).to redirect_to("http://test.com")
    end

  end
end
