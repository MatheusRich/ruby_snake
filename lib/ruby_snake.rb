# frozen_string_literal: true

require 'rich_engine'
require_relative 'ruby_snake/snake'
require_relative 'ruby_snake/version'

module RubySnake
  class Game < RichEngine::Game
    def on_create; end

    def on_update(_x, _y)
      true
    end
  end
end
