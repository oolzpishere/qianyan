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


    def load
      Roo::Spreadsheet.open(file)
    end

    def sheet
      load.sheet(0)
    end

    def head
      h = {}
      row1 = sheet.row(1)

      row1.each_with_index do |item, i|
        next if item.nil?
        h[item] = nil

        if row1[i + 1].nil? && ((i + 1) < row1.length)
          cc = children_count(row1, i)
          # h[item] = []
          h[item] = {}
          cc.times do |j|
            nest_key = get_cell(sheet, 2, i + j + 1)
            # _h = {}
            # _h["name"] = nest_key
            # _h["number"] = nil
            # h[item] << _h
            h[item][nest_key] = nil
          end
        end
      end
      h
    end

    def values
      arr = []
      3.upto(sheet.last_row) do |num|
        row = sheet.row(num)
        _head = head.dup
        _i = 0

        _head.each do |k,_|
          if _head[k].is_a?(Hash)
            _head[k].each do |nk, nv|
              _head[k][nk] = row[_i]
              _i += 1
            end
          else
            _head[k] = row[_i]
            _i += 1
          end
        end
        arr << _head
      end
      arr
    end

    private

    def children_count(row, i)
      j = i
      count = 0
      while (row[j + 1].nil?) do
        j += 1
        count += 1
      end
      # for last one
      count += 1
    end

    def get_cell(sheet, row, column)
      sheet.cell(row, column)
    end


  end
end
