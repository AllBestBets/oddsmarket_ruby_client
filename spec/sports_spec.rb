require 'spec_helper'

describe 'Sports Client spec' do
  let(:sports_client) { OddsmarketClient::Sports.new }
  
  it 'should all sports_client' do
    resp = sports_client.all
    expect(resp.code).to eq 200
    json = Oj.load(resp.body)
    expect(json['response'].select { |x| x['name'] == 'Baseball' }.first['id']).to eq 1
  end
end