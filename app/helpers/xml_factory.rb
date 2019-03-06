# coding: utf-8
class XmlFactory
  attr_reader :path, :key_type
  def initialize(ps = {})
    file_name = 'form_' + ps[:form]
    @path = ps[:path] || File.join(File.expand_path(  "../form_files", __FILE__ ), file_name)
    # @key_type = ps[:key_type]
  end

  # getting: ["serial_number", "total_price", "trade_no", "trade_status", "payment_method", "field_45", "field_48".....]
  def form_keys
    form_structure_array.map { |hash| hash.keys.first }
  end

  # finally getting [{"serial_number"=>{"label"=>"序号", "data_type"=>"Float"}}, {"total_price"=>{"label"=>"应付金额", "data_type"=>"Float"}}, {"trade_no"=>{"label"=>"交易号", "data_type"=>"String"}}, {"trade_status"=>{"label"=>"交易状态", "data_type"=>"String"}}, {"payment_method"=>{"label"=>"支付渠道", "data_type"=>"String"}}, {"field_45"=>{"label"=>"发票号", "data_type"=>"String"}}......]
  def form_structure_array(data = xml_data)
    xml_hash = hash_from_xml(data)
    td_array = get_td_array(xml_hash)

    # ["序号", "Float", "serial_number"]
    td_array.map do |arr|
      h = Hash.new
      api_code = arr[2]
      h[api_code] = {
        "label" => arr[0],
        "data_type" => arr[1]
      }
      h
    end
    # delete change the source
    # ["序号", "Float", "serial_number"] > ["序号", "serial_number"]
    # td_array.each {|td| td.delete_at(1)}
    # reverse_array_item
    # td_array.map {|arr| arr.reverse}.to_h
  end

  # get tds array[{"td"=>["序号", "Float", "serial_number"]}, {"td"=>["总价", "Float", "total_price"]}]
  def get_td_array(xml_hash)
    xml_hash.dig("tbody","tr").map {|h| h["td"]}
  end

  def hash_from_xml(data)
    Hash.from_xml(data)
  end

  # <tbody> data
  def xml_data
    data = ""
    File.read(path).each_line {|line| data << line.chomp}
    data
  end
end
