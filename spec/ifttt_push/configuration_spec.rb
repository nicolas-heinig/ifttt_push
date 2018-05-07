require 'spec_helper'

describe IftttPush::Configuration do
  it 'stores the key configuration' do
    config = IftttPush::Configuration.new
    config.key = 'mytestkey'

    expect(config.key).to eq('mytestkey')
  end
end