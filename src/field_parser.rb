# frozen_string_literal: true

class FieldParser
  def initialize(field:, min:, max:)
    @field = field
    @min = min
    @max = max
  end

  def parse
    parts = field.split(',')
    parts.flat_map { |part| parse_part(part) }
  end

  private

  attr_reader :field, :min, :max

  def parse_part(part)
    part, step = part.split('/')
    step = [1, step.to_i].max

    expand_part(part, step)
  end

  def expand_part(part, step)
    return expand_wildcard(step) if part.include?('*')
    return expand_range(part, step) if part.include?('-')

    [part.to_i]
  end

  def expand_wildcard(step)
    (min..max).step(step).to_a
  end

  def expand_range(part, step)
    start, finish = part.split('-')
    (start.to_i..finish.to_i).step(step).to_a
  end
end
