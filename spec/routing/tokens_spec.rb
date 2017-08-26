require 'rails_helper'

describe 'tokens' do
  it 'should route to tokens create' do
    expect(post '/login').to route_to('tokens#create')
  end

  it 'should route to tokens delete' do
    expect(delete '/login').to route_to('tokens#destroy')
  end
end

