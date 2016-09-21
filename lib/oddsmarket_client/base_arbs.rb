module OddsmarketClient
  module BaseArbs
    
    attr_reader :api_key, :last_response

    def initialize(api_key)
      @api_key = api_key
    end
    
    def arbs(args, method = :post)
      raise ArgumentError.new("require bookmakerIds") if args[:bookmakerIds].nil?
      if args[:bookmakerIds].is_a?(Numeric)
        args[:bookmakerIds] = [args[:bookmakerIds]]
      end
      raise ArgumentError.new("require bookmakerIds") if args[:bookmakerIds].length == 0
      
      args[:apiKey] ||= @api_key
      raise ArgumentError.new("require apiKey") if args[:apiKey].nil? or args[:apiKey].strip.length == 0
      
      u = url(method) % args[:bookmakerIds].join(',') if method == :get
      u = url(method) % [args[:bookmakerIds].join(','), args[:apiKey]] if method == :post
      
      @last_response = HtppClient::call(u, permit_args(args, method), method)
    end
    
    def permit_args(args, method)
      permited = [:sportIds, :grouped, 
                  :eventId, :minPercent, :maxPercent, 
                  :limit, :excludedBetIds, :excludedBkEventIds, 
                  :excludedArbIds, :sortBy, :format]
      
      permited << :apiKey if method == :get

      args.select { |k| permited.include?(k) }
    end

    def url(method)
      raise "Override url"
    end
      
  end
end