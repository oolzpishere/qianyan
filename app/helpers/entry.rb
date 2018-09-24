# coding: utf-8
class Entry

  attr_reader :result, :entry, :form, :form_name, :name_pair

  # hd=hash_data
  # [params] Result.any
  def initialize(ps = {})
    @result = ps[:result]
    @entry = result[:entry]
    form = result[:form]
    form_name = result[:form_name]
    # key_type = eng_key? ? "eng" : "chinese"
    xmlFactory = XmlFactory.new(form: form)
    @name_pair = xmlFactory.name_pair
  end

  def values
    values = eng_key? ? change_name : filter_entry
    except_hash(values)
  end

  def except_hash(values)
    values =  values.except( '发票号', '邮寄状态','提交人', '微信头像', '微信OpenID', '微信昵称', '微信性别', '微信国家', '微信省市', '修改时间', 'IP' )
    reject_empty(values)
  end

  # reject empty products
  def reject_empty(values)
    values.reject { |k,v|
      ( !v.to_s.match(/\d/) if v.is_a?(Hash) || v.is_a?(Array) ) || v.to_s.chomp.empty?
    }
  end

  # from {"serial_number" =>123, ... } become {"序号" => 123, ... }
  # from english name change to chinese name
  # eg. serial_number to 序号
  def change_name
    filter_entry.inject({}) { |h, (k,v)| h[name_pair[k]] = v; h }
  end

  # 对应不上最新name_pair的则不显示
  # english key use keys or chinese key use values from name_pair
  def filter_entry
    key_type = eng_key? ? "keys" : "values"
    entry.select do |k, _|
      keys = name_pair.send(key_type)
      keys.include?(k)
    end
  end

  private

  def eng_key?
    entry.keys.any? {|k| k.match(/serial/) || k.match(/field/)}
  end
  # json post from jinshuju, product if not choose number, it's not show the product and number.
  # def entry_to_h
  #   JSON.parse entry.gsub('=>', ':') # .gsub('nil', "\"\"")
  # end
end
