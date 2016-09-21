module OddsmarketClient
  class PrematchArbs
    include BaseArbs
    
    def url(method)
      if method == :post
        return 'https://api-pr.oddsmarket.org/v1/bookmakers/%s/arbs?apiKey=%s'
      else
        return 'https://api-pr.oddsmarket.org/v1/bookmakers/%s/arbs'
      end
    end
  end
end