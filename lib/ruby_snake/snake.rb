# frozen_string_literal: true

require_relative 'point'

module RubySnake
  class Snake
    def initialize
      @body = [Point.new(60, 15), Point.new(61, 15), Point.new(62, 15), Point.new(63, 15)]
      @direction = :right
    end
  end
end
