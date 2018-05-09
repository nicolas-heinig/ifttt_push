require 'spec_helper'

describe IftttPush do
  before do
    stub_request(:post, %r{http://maker.ifttt.com})
  end

  subject do
    IftttPush.new(
      title: 'Something happens!',
      message: 'Hey look at this, maybe it is imporant',
      link_url: 'http://example.com/'
    )
  end

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

  describe '.push!' do
    it 'makes the request' do
      subject.push!

      expect(
        a_request(:post, %{http://maker.ifttt.com/trigger/push_notification/with/key/mytestapikey})
      ).to have_been_made
    end
  end

  describe '.on_complete' do
    it 'calls the on_complete handler' do
      ran = false

      subject.on_complete do
        ran = true
      end.push!

      expect(ran).to be true
    end
  end
end
