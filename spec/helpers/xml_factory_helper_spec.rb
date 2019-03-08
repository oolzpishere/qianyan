require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the XmlFactoryHelper. For example:
#
# describe XmlFactoryHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe XmlFactory, type: :helper do

  let(:xml_to_hash) {XmlFactory.new(form: 'test')}

  context 'XmlFactory form structure correct' do
    it 'label' do
      expect(xml_to_hash.form_structure["serial_number"]["label"]).to eq("序号")
    end
    it 'data_type' do
      expect(xml_to_hash.form_structure["serial_number"]["data_type"]).to eq("Float")
    end
  end

  context 'XmlFactory form_keys correct' do
    let(:form_keys_text) {"[\"serial_number\", \"total_price\", \"trade_no\", \"trade_status\", \"payment_method\", \"field_45\", \"field_48\", \"field_49\", \"field_1\", \"field_2\", \"field_17\", \"field_18\", \"field_19\", \"field_26\", \"field_25\", \"field_24\", \"gen_code\", \"x_field_weixin_nickname\", \"x_field_weixin_gender\", \"x_field_weixin_country\", \"x_field_weixin_province_city\", \"x_field_weixin_openid\", \"x_field_weixin_headimgurl\", \"creator_name\", \"created_at\", \"updated_at\", \"info_platform\", \"info_os\", \"info_browser\", \"info_remote_ip\"]"}

    it "form_keys" do
      expect(xml_to_hash.form_keys.to_s).to eq(form_keys_text)
    end
  end

end
