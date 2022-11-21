require './lib/constants'

class Button
    attr_accessor :selected

    def initialize(text, size, x, y, width, height, &block)
        @text = text
        @size = size

        @x = x
        @y = y
        @width = width
        @height = height
        @block = block
        @selected = false

        @font = Gosu::Font.new(@size)
    end

    def update
        if $mouse_coords.x >= @x && $mouse_coords.x <= @x + @width && $mouse_coords.y >= @y && $mouse_coords.y <= @y + @height
            @selected = true
        else
            @selected = false
        end
    end

    def draw
        Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color.argb(255, MAIN_COLOR.r, MAIN_COLOR.g, MAIN_COLOR.b))
        if @selected
            Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color.argb(127, 255, 255, 255))
        end
        @font.draw_text(@text, @x, @y, 1, 1, 1, Gosu::Color::WHITE)
    end

    def button_down(id)
        if id == Gosu::MsLeft && $mouse_coords.x >= @x && $mouse_coords.x <= @x + @width && $mouse_coords.y >= @y && $mouse_coords.y <= @y + @height
            @block.call
        end
    end
end