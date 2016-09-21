require 'spec_helper'

describe 'Bookmakers Client spec' do
  let(:bookmakers_client) { OddsmarketClient::Bookmakers.new }

  it 'should all bookmakers' do
    resp = bookmakers_client.all
    expect(resp.code).to eq 200
    json = Oj.load(resp.body)
    expect(json['response'].select { |x| x['name'] == 'Pinnacle' }.first['id']).to eq 1
  end
end