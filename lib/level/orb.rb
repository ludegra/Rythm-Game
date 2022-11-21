require './lib/data'

class Orb
    attr_reader :t

    def initialize(start_cx, start_cy, end_cx, end_cy, size, bpm, quarters)
        @size = size
        
        @start_x = start_cx - @size / 2
        @start_y = start_cy - @size / 2 
        @end_x = end_cx - @size / 2
        @end_y = end_cy - @size / 2

        @x = @start_x
        @y = @start_y

        @time = (60000 / bpm) * quarters
        @t = 0
    end

    def update
        @t += Time.delta_time.to_f / @time
        if @t >= 1.1
            return true
        end 

        calculate_position
        false
    end

    def draw
        Gosu.draw_rect(@x, @y, @size, @size, Gosu::Color::RED)
    end

    def calculate_position
        @x = @start_x + (@end_x - @start_x) * @t.clamp(0, 1)
        @y = @start_y + (@end_y - @start_y) * @t.clamp(0, 1)
    end

    def position
        Point2D.new(@x, @y)
    end
end