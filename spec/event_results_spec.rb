require 'spec_helper'

describe 'Bookmakers Client spec' do
  let(:event_results_client) { OddsmarketClient::EventResults.new(EVENT_RESULTS_API_KEY, sportIds: 21) }

  it 'should all results' do
    resp = event_results_client.results
    expect(resp.code).to eq 200
    json = Oj.load(resp.body)
    expect(json['errors'].keys.length).to eq 0

    resp = event_results_client.results(:get)
    expect(resp.code).to eq 200
    json = Oj.load(resp.body)
    expect(json['errors'].keys.length).to eq 0
  end
end