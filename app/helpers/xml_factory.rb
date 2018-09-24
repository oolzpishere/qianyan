# coding: utf-8
class XmlFactory
  attr_reader :path, :key_type
  def initialize(ps = {})
    file_name = 'form_' + ps[:form]
    @path = ps[:path] || File.join(File.expand_path(  "../form_files", __FILE__ ), file_name)
    # @key_type = ps[:key_type]
  end

  # get tds hash[{"td"=>["序号", "Float", "serial_number"]}, {"td"=>["总价", "Float", "total_price"]}]
  # finally getting {"serial_number"=>"序号", ...}
  def name_pair(data = xml_data)
    h = Hash.from_xml(data)
    arr = h.dig("tbody","tr").map {|h| h["td"]}
    # delete change the source
    # ["序号", "Float", "serial_number"] > ["序号", "serial_number"]
    arr.each {|td| td.delete_at(1)}
    # reverse_array_item
    arr.map {|arr| arr.reverse}.to_h
  end

  # <tbody> data
  def xml_data
    data = ""
    File.read(path).each_line {|line| data << line.chomp}
    data
  end
end
