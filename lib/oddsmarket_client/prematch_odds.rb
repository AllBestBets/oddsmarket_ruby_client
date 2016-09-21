module OddsmarketClient
  class PrematchOdds
    include BaseOdds
    
    def url(method)
      return 'https://api-pr.oddsmarket.org/v1/bookmakers/%s/odds'
    end
  end
end