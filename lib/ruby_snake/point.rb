# frozen_string_literal: true

module RubySnake
  class Point
    attr_accessor :x, :y, :next

    def initialize(x, y)
      @x = x
      @y = y
    end

    def to_ary
      [x, y]
    end
  end
end
