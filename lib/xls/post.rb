# coding: utf-8
#############################
## decide to abandon, backup plan is use Jinshuju's official search.
#############################
require 'xls/parse'
require 'net/http'

module Xls
  class Post

    attr_reader :file, :uri, :pass, :subject

    # new(file, url, subject(class name:CamelCase))
    def initialize(file, url, subject)
      @file = file
      # File.join(File.expand_path("../files", __FILE__), "_v9KUmP_小学英语会议报名_20170817162821.xls")
      url = url || "http://localhost:3000/dvd_results"
      @pass = ENV["QIANYAN_PASS"]
      @subject = subject.camelize
      @uri = gen_uri(url)
    end

    def post(range = 0..-1)
      ranged = values[range]
      ranged.each do |row|
        Net::HTTP.post(uri,
               row.to_json,
               {"Content-Type" => "application/json", 'Accept' => 'application/json'})

        # req = Net::HTTP::Post.new( uri.path, initheader = {"Content-Type" => "application/json", 'Accept' => 'application/json'} )
        # # req.body = row.merge({'pass' => pass, 'subject' => subject}).to_json
        # req.body = row.to_json
        # res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        #   http.request(req)
        # end
      end
      # Net::HTTP.post( uri, hashs.first.to_json, { "Content-Type" => 'application/json', 'Accept' => 'application/json'} )
    end

    def values
      Xls::Parse.new(file: @file).values_handle
    end

    def gen_uri(url)
      uri = URI( url )
      uri.query = ( {pass: pass, subject: subject}.to_query )
      uri
    end

  end
end
