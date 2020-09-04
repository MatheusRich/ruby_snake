# frozen_string_literal: true

require_relative 'point'

module RubySnake
  class Snake
    #using RichEngine::StringColors

    INITIAL_SNAKE = [
      Point.new(3, 0),
      Point.new(2, 0),
      Point.new(1, 0),
      Point.new(0, 0),
    ].freeze
    DIRECTIONS = %i[up down left right].freeze
    INVERSE_DIRECTIONS = {
      up: :down,
      down: :up,
      left: :right,
      right: :left
    }

    def initialize
      @body = INITIAL_SNAKE.dup
      @direction = :right
      @move_cooldown = RichEngine::Timer.new
      @speed_timer = RichEngine::Timer.new
      @speed = 0.3
    end

    def update(elapsed_time, key)
      handle_input(key)
      @move_cooldown.update(elapsed_time)
      @speed_timer.update(elapsed_time)

      move! if @move_cooldown.get > @speed
    end

    def draw(canvas)
      @body.each do |x, y|
        canvas[x, y] = '█'
      end

      canvas
    end

    private

    def handle_input(key)
      return unless DIRECTIONS.include?(key)
      return if inverse_direction?(key)

      @direction = key
    end

    def inverse_direction?(key)
      key == INVERSE_DIRECTIONS[@direction]
    end

    def move!
      grow!
      @body.pop
      @move_cooldown.reset!
    end

    def move_up!
      @body.unshift(Point.new(head.x, head.y - 1))
    end

    def move_down!
      @body.unshift(Point.new(head.x, head.y + 1))
    end

    def move_right!
      @body.unshift(Point.new(head.x + 1, head.y))
    end

    def move_left!
      @body.unshift(Point.new(head.x - 1, head.y))
    end

    def grow!
      send("move_#{@direction}!")
    end

    def head
      @body.first
    end
  end
end
