class Modal
    def initialize(x, y, width, height, scr_width, scr_height)
        @x = x
        @y = y
        @width = width
        @height = height
        @scr_width = scr_width
        @scr_height = scr_height
        @visible = false
        @components = []
    end

    def add_component(component)
        @components << component
    end

    def draw
        if @visible
            Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color.argb(127, 0, 0, 0))
            Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color::RED)
        end
    end

    def make_visible
        @visible = true
    end
end
