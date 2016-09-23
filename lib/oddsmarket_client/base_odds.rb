module OddsmarketClient
  module BaseOdds
    
    attr_reader :api_key, :last_response, :last_updated_at, :args

    def initialize(api_key, args)
      @api_key = api_key
      @args = args
    end

    def odds(method = :post)
      raise ArgumentError.new("require bookmakerIds") if @args[:bookmakerIds].nil?
      if @args[:bookmakerIds].is_a?(Numeric)
        @args[:bookmakerIds] = [@args[:bookmakerIds]]
      end
      raise ArgumentError.new("require bookmakerIds") if @args[:bookmakerIds].length == 0
      
      @args[:apiKey] ||= @api_key
      raise ArgumentError.new("require apiKey") if @args[:apiKey].nil? or @args[:apiKey].strip.length == 0

      new_updated_at = Time.now.to_i

      unless @last_response.nil?
        @args[:http_headers] ||= {}
        @args[:http_headers]['If-None-Match'] = @last_response.headers['Etag'] unless @last_response.headers['Etag'].nil?
      end
      
      if @args[:notUseLastUpdateAt].nil? and !@last_updated_at.nil?
        @args[:lastUpdatedAt] = @last_updated_at
      end
      
      @last_response = HtppClient::call(url(method) % @args[:bookmakerIds].join(','), permit_args(@args), method)
      @last_updated_at = new_updated_at if 200 == @last_response.code
      @last_response
    end
    
    def permit_args(args)
      permited = [:apiKey, :sportIds, :onlyMain, :onlyBack, :showDirectLink, :lastUpdatedAt, :format, :http_headers]
      args.select { |k| permited.include?(k) }
    end

    def url(method)
      raise "Override url"
    end
      
  end
end