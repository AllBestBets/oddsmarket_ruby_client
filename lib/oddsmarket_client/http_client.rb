require 'httpi'
require 'oj'

module OddsmarketClient
  module HtppClient
    class << self
      def call(url, args = {}, method)
        connection(url, args, method)
      end

      def connection(url, args = {}, method)
        args[:format] ||= :json
        args[:http_headers] ||= {}
        args[:http_headers]['Content-Type'] ||= "text/#{args[:format].to_s}"
        args[:http_headers]['Accept'] ||= "application/#{args[:format].to_s}"
        args[:http_headers]['Accept-Encoding'] ||= 'gzip'
        clean_args = args.select { |k| k != :http_headers and k != :format }

        if method == :get
          request = HTTPI::Request.new("#{url}?#{clean_args.map{|k,v| "#{k}=#{v.is_a?(Array) ? v.join(',') : v}"}.join('&')}")
          request.headers = args[:http_headers]
          HTTPI.get(request)
        else
          request = HTTPI::Request.new(url)
          request.body = Oj.dump(clean_args, {:mode => :compat })
          request.headers = args[:http_headers]
          HTTPI.post(request)
        end
      end
    end
  end
end