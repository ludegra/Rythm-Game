require './lib/constants'

class Modal
    def initialize(x, y, width, height, scr_width, scr_height, border=true)
        @x = x
        @y = y
        @width = width
        @height = height
        @scr_width = scr_width
        @scr_height = scr_height
        @visible = false
        @components = []
        @border = border
        @border_width = 1
        @animation = nil
        @opacity = 1
        @t = 0
    end

    attr_accessor :border_width

    def add_component(component)
        @components << component
    end

    def make_visible
        @visible = true
    end

    def fade_in(duration)
        make_visible

        @t = 0
        @duration = duration
        @opacity = 0

        @animation = -> () do
            t = Time.delta_time * 1.0 / @duration
            @opacity = t

            t
        end
    end

    def update
        if !@animation.nil?
            @t += @animation.call
            @opacity = @t

            if @t >= 1
                @t = 0
                @opacity = 1
                @animation = nil
            end
            
        end
    end

    def draw
        if @visible
            Gosu.draw_rect(0, 0, @scr_width, @scr_height, Gosu::Color.argb(127 * @opacity, 0, 0, 0))
            Gosu.draw_rect(@x - @border_width, @y - border_width, @width + @border_width * 2, @height + @border_width * 2, Gosu::Color.argb(255 * @opacity, 255, 255, 255)) if @border
            Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color.argb(255 * @opacity, MAIN_COLOR.r, MAIN_COLOR.g, MAIN_COLOR.b))
            
        end
    end

    private

    def calc_fade

    end
end
