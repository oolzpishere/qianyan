# coding: utf-8
class Entry

  attr_reader :result, :entry, :form, :form_name, :form_structure, :xml_factory

  # hd=hash_data
  # [params] Result.any
  def initialize(ps = {})
    @result = ps[:result]
    @entry = result[:entry]
    # eg. form: LB9WCe
    form = result[:form]
    form_name = result[:form_name]
    # key_type = eng_key? ? "eng" : "chinese"
    @xml_factory = XmlFactory.new(form: form)
    @form_structure = xmlFactory.form_structure
  end

  def show_values
    name_values = {}
    values.each do |k,v|
      label = form_structure[k] && form_structure[k]["label"]
      name_values[label] = v
    end
    name_values
  end

  def values
    # values = eng_key? ? change_name : filter_entry
    # except_hash(values)
    v = except_hash(filter_entry)
    reject_empty(v)
  end

  def except_hash(values)
    # values =  values.except( '发票号', '邮寄状态','提交人', '微信头像', '微信OpenID', '微信昵称', '微信性别', '微信国家', '微信省市', '修改时间', 'IP' )
    reject_array = ['发票号', '邮寄状态','提交人', '微信头像', '微信OpenID', '微信昵称', '微信性别', '微信国家', '微信省市', '修改时间', 'IP']
    values.reject{|k,_| reject_array.includ?( form_structure[k]["label"] ) }
  end

  # reject empty products
  def reject_empty(values)
    values.reject { |k,v|
      ( !v.to_s.match(/\d/) if v.is_a?(Hash) || v.is_a?(Array) ) || v.to_s.chomp.empty?
    }
  end

  # 对应不上最新form_files的则不显示
  # english key use keys or chinese key use values from name_pair
  def filter_entry
    entry.select do |k, _|
      xml_factory.form_keys.include?(k)
    end
  end

  # private
  #
  # def eng_key?
  #   entry.keys.any? {|k| k.match(/serial/) || k.match(/field/)}
  # end
  #
  # json post from jinshuju, product if not choose number, it's not show the product and number.
  # def entry_to_h
  #   JSON.parse entry.gsub('=>', ':') # .gsub('nil', "\"\"")
  # end
end
