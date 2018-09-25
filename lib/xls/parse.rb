# coding: utf-8
require 'roo'
require 'roo-xls'

module Xls
  class Parse

    attr_reader :file, :form, :form_name

    def initialize(ps = {})
      @file = ps[:file]
      name = file.split('/').last
      form_names = name.split('_')
      # file name pattern: v9KUmP_小学英语会议报名_20170817162821.xls
      # file name can't have "" double quote
      # form is form id
      @form = form_names[0]
      @form_name = form_names[1]
    end

    def to_hash
      result.map do |res|
        entry = {}
        res.each {|hash| entry.deep_merge! hash}
        {"entry" => entry}.merge(important_value(entry))
      end
    end

    def important_value(entry)
      Hash[
        "id" => entry["序号"].to_i,
        "form" => form,
        "form_name" => form_name,
        "openid" => entry["微信OpenID"],
        # "gen_code" => entry["确认码"].delete(" "),
        "created_at" => entry["提交时间"],
        "updated_at" => entry["修改时间"]
      ]
    end

    def load
      Roo::Spreadsheet.open(file)
    end

    def sheet
      load.sheet(0)
    end

    # keys of level1
    def row1
      sheet.row(1)
    end

    #loop until don't have nil in row1
    def row1_dup_nil(row)
      if (row.any? {|item| item.nil?})
        row  =  dup_nil(row)
        row1_dup_nil(row)
      else
        row
      end
    end

    # some child of level1
    def row2
      sheet.row(2)
    end

    def row2_values
      arr = []
      3.upto(sheet.last_row) do |i|
        row_value = sheet.row(i)
        arr << match_value(row2, row_value)
      end
      arr
    end

    #row 1 merge all
    def result
      row2_values.map { |rv|
        match_value(row1_dup_nil(row1), rv) }
    end

    # def mto_json
    #   to_hash.map { |row| row.to_json }
    # end

    private

    def dup_nil(row)
      row.each_with_index.map do |item, index|
        if index < (row.count) - 1 # not last item
          item || item = row[index - 1]
        else
          item
        end
      end
    end

    def match_value(keys_array, values_array)
      arr = []
      keys_array.each_with_index do |item, index|
        # "values_array[index].to_s" change nil to empty string
        value = values_array[index] || values_array[index].to_s
        c = item ? { item => value } : value
        arr << c
      end
      arr
    end

  end
end
