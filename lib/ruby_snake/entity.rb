# frozen_string_literal: true

module RubySnake
  module Entity
    def update(_dt, _key)
      raise NotImplementedError, "#{self.class} should implement `#update(dt, key)`"
    end

    def draw(_canvas)
      raise NotImplementedError, "#{self.class} should implement `#draw(canvas)`"
    end
  end
end
