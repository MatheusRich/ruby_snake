# frozen_string_literal: true

module RubySnake
  class Food
    include Entity

    attr_reader :position

    def initialize(x, y)
      @position = Point.new(x, y)
    end

    def update(_dt, _key); end

    def draw(canvas)
      canvas[@position.x, @position.y] = '*'

      canvas
    end
  end
end
