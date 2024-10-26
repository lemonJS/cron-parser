# frozen_string_literal: true

require_relative 'field_parser'

class CronParser
  def initialize(cron_string:)
    @cron_string = cron_string
  end

  def parse
    parts = cron_string.split

    format_output(
      ['minute',       FieldParser.new(field: parts[0], min: 0, max: 59).parse],
      ['hour',         FieldParser.new(field: parts[1], min: 0, max: 23).parse],
      ['day of month', FieldParser.new(field: parts[2], min: 1, max: 31).parse],
      ['month',        FieldParser.new(field: parts[3], min: 1, max: 12).parse],
      ['day of week',  FieldParser.new(field: parts[4], min: 1, max: 7).parse],
      ['command',      parts.slice(5..)]
    )
  end

  private

  attr_reader :cron_string

  def format_output(*fields)
    rows = fields.map { |name, field| "#{name.ljust(14)} #{field.join(' ')}" }

    puts rows.join("\n")
  end
end
