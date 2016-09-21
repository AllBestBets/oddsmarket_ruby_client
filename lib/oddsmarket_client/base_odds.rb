module OddsmarketClient
  module BaseOdds
    
    attr_reader :api_key, :last_response

    def initialize(api_key)
      @api_key = api_key
    end

    def odds(args, method = :post)
      raise ArgumentError.new("require bookmakerIds") if args[:bookmakerIds].nil?
      if args[:bookmakerIds].is_a?(Numeric)
        args[:bookmakerIds] = [args[:bookmakerIds]]
      end
      raise ArgumentError.new("require bookmakerIds") if args[:bookmakerIds].length == 0
      
      args[:apiKey] ||= @api_key
      raise ArgumentError.new("require apiKey") if args[:apiKey].nil? or args[:apiKey].strip.length == 0

      @last_response = HtppClient::call(url(method) % args[:bookmakerIds].join(','), permit_args(args), method)
    end
    
    def permit_args(args)
      permited = [:apiKey, :sportIds, :onlyMain, :onlyBack, :showDirectLink, :lastUpdatedAt, :format]
      args.select { |k| permited.include?(k) }
    end

    def url(method)
      raise "Override url"
    end
      
  end
end