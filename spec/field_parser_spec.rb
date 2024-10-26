# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../src/field_parser'

RSpec.describe FieldParser do
  describe '#parse' do
    subject { described_class.new(field:, min:, max:).parse }

    describe 'when given single values' do
      let(:field) { '0' }
      let(:min) { 0 }
      let(:max) { 10 }

      it 'returns the expected values' do
        expect(subject).to eq([0])
      end
    end

    describe 'when given a range' do
      let(:field) { '1-5' }
      let(:min) { 0 }
      let(:max) { 10 }

      it 'returns the expected values' do
        expect(subject).to eq([1, 2, 3, 4, 5])
      end
    end

    describe 'when given a wildcard' do
      let(:field) { '*' }
      let(:min) { 1 }
      let(:max) { 5 }

      it 'returns the expected values' do
        expect(subject).to eq([1, 2, 3, 4, 5])
      end
    end

    describe 'when given a list' do
      let(:field) { '1,2,3,5' }
      let(:min) { 1 }
      let(:max) { 5 }

      it 'returns the expected values' do
        expect(subject).to eq([1, 2, 3, 5])
      end
    end

    describe 'when given a step' do
      let(:field) { '*/2' }
      let(:min) { 0 }
      let(:max) { 10 }

      it 'returns the expected values' do
        expect(subject).to eq([0, 2, 4, 6, 8, 10])
      end
    end

    describe 'when given a range and a step' do
      let(:field) { '1-7/2' }
      let(:min) { 1 }
      let(:max) { 10 }

      it 'returns the expected values' do
        expect(subject).to eq([1, 3, 5, 7])
      end
    end

    describe 'when given a list, range and a step' do
      let(:field) { '1,2-7/2' }
      let(:min) { 1 }
      let(:max) { 10 }

      it 'returns the expected values' do
        expect(subject).to eq([1, 2, 4, 6])
      end
    end
  end
end
