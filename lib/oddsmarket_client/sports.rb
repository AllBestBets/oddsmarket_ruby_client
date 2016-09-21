module OddsmarketClient
  class Sports
    attr_reader :last_response
    URL = 'https://api-mst.oddsmarket.org/v1/sports'
    
    def all(args = {})
      @last_response = HtppClient::call(URL, permit_args(args), :get)
    end
    
    def permit_args(args)
      permited = [:format]
      args.select { |k| permited.include?(k) }
    end
  end
end