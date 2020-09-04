# frozen_string_literal: true

require 'rich_engine'
require_relative 'ruby_snake/snake'
require_relative 'ruby_snake/version'

module RubySnake
  class Game < RichEngine::Game
    FPS = 1.0 / 60

    def on_create
      @game_objects = [Snake.new]
    end

    def on_update(dt, key)
      game_over = false

      # @canvas.clear
      @game_objects.each do |obj|
        obj.update(dt, key)
      end

      @game_objects.each do |obj|
        obj.draw(@canvas)
      end

      binding.irb if key == :n
      game_over = key == :q

      render

      sleep [FPS - dt, 0].max

      !game_over
    end
  end
end

RubySnake::Game.play
