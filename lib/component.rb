class Component
    def initialize
    end

    def draw
    end
end

class Text < Component
    def initialize(x, y, text, size=20)
        @x = x
        @y = y
        @text = text
        @size = size

        @font = Gosu::Font.new(@size)
    end

    def draw
        @font.draw_text(@text, @x, @y, 1, 1, 1, Gosu::Color::WHITE)
    end
end

class Button < Component
    def initialize(x, y, width, height, text, text_size, color, text_color)
        @x = x
        @y = y
        @width = width
        @height = height
        @text = text
        @color = color
        @text_color = text_color

        @font = Gosu::Font.new(text_size)
    end

    def button_down(id, mouse_x, mouse_y, &block)
        if id == Gosu::MsLeft && mouse_x >= @x && mouse_x <= @x + @width && mouse_y >= @y && mouse_y <= @y + @height
            yield
        end
    end

    def draw
        Gosu.draw_rect(@x, @y, @width, @height, @color)
        @font.draw_text(@text, @x + @width / 2 - @text.length * 10, @y + @height / 2 - 10, 1, 1, 1, @text_color)
    end
end