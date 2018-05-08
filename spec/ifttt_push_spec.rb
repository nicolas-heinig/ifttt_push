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

  describe '#notify' do
    before do
      stub_request(:post, %r{http://maker.ifttt.com})
    end

    subject do
      IftttPush.notify(
        title: 'Something happens!',
        message: 'Hey look at this, maybe it is imporant',
        link_url: 'http://example.com/'
      )
    end

    it 'makes the request' do
      subject

      expect(
        a_request(:post, %{http://maker.ifttt.com/trigger/push_notification/with/key/mytestapikey})
      ).to have_been_made
    end
  end
end
