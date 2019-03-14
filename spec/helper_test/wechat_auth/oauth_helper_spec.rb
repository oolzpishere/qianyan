require 'rails_helper'

RSpec.describe WechatAuth::Oauth, type: :helper do
  let(:params) {
    {
      appid: ENV["QIANYAN_APPID"],
      secret: ENV["QIANYAN_APPSE"],
      redirect_uri: 'redirect_uri',
      scope: 'snsapi_base',
      state: 'wechat_auth'
    }
  }

  let(:code) {"code"}

  let(:code_uri) {"https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{params[:appid]}&redirect_uri=redirect_uri&response_type=code&scope=snsapi_base&state=wechat_auth#wechat_redirect"}

  let(:openid_uri) {"https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{params[:appid]}&secret=#{params[:secret]}&code=#{code}&grant_type=authorization_code"}

  context 'Oauth' do
    it 'get correct code_uri' do
      oauth = WechatAuth::Oauth.new(redirect_uri: 'redirect_uri')
      expect(oauth.get_code_uri).to eq(code_uri)
    end

    it "get correct openid_uri" do
      oauth = WechatAuth::Oauth.new(code: 'code')
      expect(oauth.get_openid_uri).to eq(openid_uri)
    end
  end

end
