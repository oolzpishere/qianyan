module DvdResultsHelper
  # reject rows on results show page
  # reject sign up not includ numbers
  # sign up value is hash
  # 发票单位全称（开发票抬头） ()前后不可有空格，影响筛选
  def compile_value(value)
    if value.is_a?(Hash)
      value.reject { |k,v| v.empty? }
    # for products
    elsif value.is_a?(Array)
      # value.reject { |item| item.empty? }
      result = []
      value.each {|hash| result << "#{hash['name']} x #{hash['number']} " if hash['name'] && hash['number'] }
      result.join(', ')
    else
      value
    end
  end

end
