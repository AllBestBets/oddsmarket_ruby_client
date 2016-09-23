require 'spec_helper'

describe 'Odds Client spec' do
  let(:prematch_client) { OddsmarketClient::PrematchOdds.new(PREMATCH_ODDS_API_KEY, {bookmakerIds: [1] }) }
  let(:live_client) { OddsmarketClient::LiveOdds.new(LIVE_ODDS_API_KEY, {bookmakerIds: [1] }) }

  it 'prematch should return 200' do
    json = Oj.load(prematch_client.odds.body)
    expect(json['errors'].keys.length).to eq 0
    
    json = Oj.load(prematch_client.odds(:get).body)
    expect(json['errors'].keys.length).to eq 0
  end

  it 'live should return 200' do
    json = Oj.load(live_client.odds.body)
    expect(json['errors'].keys.length).to eq 0
    
    json = Oj.load(live_client.odds(:get).body)
    expect(json['errors'].keys.length).to eq 0
  end
end