module OddsmarketClient
  class LiveArbs
    include BaseArbs
    
    def url(method)
      if method == :post
        return 'https://api-lv.oddsmarket.org/v1/bookmakers/%s/arbs?apiKey=%s'
      else
        return 'https://api-lv.oddsmarket.org/v1/bookmakers/%s/arbs'
      end
    end
  end
end