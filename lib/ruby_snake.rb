# frozen_string_literal: true

require 'rich_engine'
require_relative 'ruby_snake/entity'
require_relative 'ruby_snake/food'
require_relative 'ruby_snake/snake'
require_relative 'ruby_snake/version'

module RubySnake
  class Game < RichEngine::Game
    FPS = 1.0 / 60

    def on_create
      @canvas = RichEngine::Canvas.new(@width, @height, bg: '.')
      @snake = Snake.new
      @entities = [@snake, Food.new(30, 5)]
      @game_over = false
    end

    def on_update(dt, key)
      @entities.each do |obj|
        obj.update(dt, key)
      end

      binding.irb if key == :n
      @game_over = @snake.dead? || key == :q

      @canvas.clear
      @entities.each do |obj|
        obj.draw(@canvas)
      end
      render

      sleep [FPS - dt, 0].max

      !@game_over
    end

    def render
      @io.write(@canvas.canvas)
      puts "\nScore: 0"
    end
  end
end
