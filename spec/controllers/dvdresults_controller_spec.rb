require 'rails_helper'

RSpec.describe DvdResultsController do
  describe "GET index request" do

    it "invoke_wx_auth redirect_to right place" do
      allow_any_instance_of(WechatAuth::Oauth).to receive(:get_code_uri) { "http://test.com" }
      get :index
      expect(response).to redirect_to("http://test.com")
    end

    it "get_wechat_sns set session[:openid] correctly" do
      json_response = '{
        "access_token":"ACCESS_TOKEN",
        "expires_in":7200,
        "refresh_token":"REFRESH_TOKEN",
        "openid":"OPENID",
        "scope":"SCOPE"
     }'
     response = JSON.parse(json_response)

     allow_any_instance_of(WechatAuth::Client).to receive(:json_hash) { response }
     allow_any_instance_of(WechatAuth::Oauth).to receive(:state) { "state" }

     get :index, :params => { state: 'state'}

     expect(session[:openid]).to eq(response["openid"])


    end

  end
end
