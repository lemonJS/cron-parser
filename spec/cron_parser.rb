# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../src/cron_parser'

RSpec.describe CronParser do
  describe '#parse' do
    let(:cron_string) { '*/15 0 1,15 * 1-5 /usr/bin/find' }
    let(:instance) { described_class.new(cron_string:) }

    before do
      allow(instance).to receive(:puts)
    end

    subject { instance.parse }

    it 'outputs the expected fields' do
      subject
      expect(instance).to have_received(:puts).with(
        <<~TEXT.chomp
          minute         0 15 30 45
          hour           0
          day of month   1 15
          month          1 2 3 4 5 6 7 8 9 10 11 12
          day of week    1 2 3 4 5
          command        /usr/bin/find
        TEXT
      )
    end
  end
end
