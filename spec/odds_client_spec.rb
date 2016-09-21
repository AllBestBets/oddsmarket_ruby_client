require 'spec_helper'

describe 'Odds Client spec' do
  let(:prematch_client) { OddsmarketClient::PrematchOdds.new(PREMATCH_ODDS_API_KEY) }
  let(:live_client) { OddsmarketClient::LiveOdds.new(LIVE_ODDS_API_KEY) }

  it 'prematch should return 200' do
    json = Oj.load(prematch_client.odds( {bookmakerIds: [1] }).body)
    expect(json['errors'].keys.length).to eq 0
    
    json = Oj.load(prematch_client.odds( {bookmakerIds: [1] }, :get).body)
    expect(json['errors'].keys.length).to eq 0
  end

  it 'live should return 200' do
    json = Oj.load(live_client.odds( {bookmakerIds: [1] }).body)
    expect(json['errors'].keys.length).to eq 0
    
    json = Oj.load(live_client.odds( {bookmakerIds: [1] }, :get).body)
    expect(json['errors'].keys.length).to eq 0
  end
end