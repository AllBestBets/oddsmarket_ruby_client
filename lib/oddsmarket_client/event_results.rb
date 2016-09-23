module OddsmarketClient
  class EventResults
    URL = 'https://api-mst.oddsmarket.org/v1/eventResults'

    attr_reader :api_key, :last_response, :args
    
    def initialize(api_key, args = {})
      @api_key = api_key
      @args = args
    end

    def results(method = :post)
      @args[:apiKey] ||= @api_key
      raise ArgumentError.new("require apiKey") if @args[:apiKey].nil? or @args[:apiKey].strip.length == 0
      if @args[:sportIds].is_a?(Numeric)
        @args[:sportIds] = [@args[:sportIds]]
      end
      u = URL
      u = "#{u}?apiKey=#{@args[:apiKey]}" if method == :post
      @last_response = HtppClient::call(u, permit_args(@args), method)
    end

    def permit_args(args)
      permited = [:apiKey, :sportIds, :leagueId, :startedFrom, :startedTo, :format]
      args.select { |k| permited.include?(k) }
    end
  end
end