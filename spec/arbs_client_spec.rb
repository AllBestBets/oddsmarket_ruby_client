require 'spec_helper'

describe 'Arbs Client spec' do
  let(:prematch_client) { OddsmarketClient::PrematchArbs.new(PREMATCH_ARBS_API_KEY) }
  let(:live_client) { OddsmarketClient::LiveArbs.new(LIVE_ARBS_API_KEY) }

  it 'prematch should return 200' do
    resp = prematch_client.arbs( {bookmakerIds: [1,2] })
    expect(resp.code).to eq 200
    json = Oj.load(resp.body)
    expect(json['errors'].keys.length).to eq 0
    
    resp = prematch_client.arbs( {bookmakerIds: [1,2] }, :get)
    expect(resp.code).to eq 200
    json = Oj.load(resp.body)
    expect(json['errors'].keys.length).to eq 0
  end

  it 'live should return 200' do
    resp = live_client.arbs( {bookmakerIds: [1,2] })
    expect(resp.code).to eq 200
    json = Oj.load(resp.body)
    expect(json['errors'].keys.length).to eq 0
    
    resp = live_client.arbs( {bookmakerIds: [1,2] }, :get)
    expect(resp.code).to eq 200
    json = Oj.load(resp.body)
    expect(json['errors'].keys.length).to eq 0
  end
end