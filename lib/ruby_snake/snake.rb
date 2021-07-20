# frozen_string_literal: true

require_relative 'point'

module RubySnake
  class Snake
    include Entity

    BODY = [
      Point.new(3, 0),
      Point.new(2, 0),
      Point.new(1, 0),
      Point.new(0, 0)
    ].freeze
    DIRECTIONS = %i[up down left right].freeze
    INVERSE_DIRECTIONS = {
      up: :down,
      down: :up,
      left: :right,
      right: :left
    }.freeze

    def initialize
      @body = BODY.dup
      @direction = :right
      @move_cooldown = RichEngine::Cooldown.new(0.1)
      @is_dead = false
    end

    def update(dt, key)
      handle_input(key)
      check_is_dead
      move(dt)
    end

    def draw(canvas)
      @body.each do |x, y|
        canvas[x, y] = current_sprite
      end

      canvas
    end

    def dead?
      @is_dead
    end

    private

    def handle_input(key)
      return unless DIRECTIONS.include?(key)
      return if inverse_direction?(key)

      @direction = key
    end

    def check_is_dead
      @is_dead = hit_itself? || hit_boundary?
    end

    def inverse_direction?(key)
      key == INVERSE_DIRECTIONS[@direction]
    end

    def move(dt)
      return if dead?

      @move_cooldown.update(dt)
      move! if @move_cooldown.ready?
    end

    def move!
      grow!
      @body.pop
      @move_cooldown.reset!
    end

    def move_up!
      @body.prepend(Point.new(head.x, head.y - 1))
    end

    def move_down!
      @body.prepend(Point.new(head.x, head.y + 1))
    end

    def move_right!
      @body.prepend(Point.new(head.x + 1, head.y))
    end

    def move_left!
      @body.prepend(Point.new(head.x - 1, head.y))
    end

    def grow!
      send("move_#{@direction}!")
    end

    def ungrow!
      @body.shift
    end

    def head
      @body.first
    end

    def current_sprite
      dead? ? 'X' : '█'
    end

    def hit_itself?
      head, *tail = @body

      tail.any? { |p| p == head }
    end

    def hit_boundary?
      x_out_of_bounds = head.x.negative? || head.x >= 50
      y_out_of_bounds = head.y.negative? || head.y >= 30

      x_out_of_bounds || y_out_of_bounds
    end
  end
end
