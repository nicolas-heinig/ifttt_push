require 'spec_helper'

describe IftttPush do
  describe "#configure" do
    before do
      IftttPush.configure do |config|
        config.key = 'mytestapikey'
      end
    end

    it 'stores the configuration' do
      expect(IftttPush.configuration.key).to eq('mytestapikey')
    end
  end
end
