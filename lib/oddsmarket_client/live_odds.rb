module OddsmarketClient
  class LiveOdds
    include BaseOdds
    
    def url(method)
      return 'https://api-lv.oddsmarket.org/v1/bookmakers/%s/odds'
    end
  end
end