require 'thread'

require './lib/level/orb'

class Lane
    ORB_SIZE = 20

    def initialize(start_x, start_y, end_x, end_y, bpm=60)
        @start_x = start_x
        @start_y = start_y
        @end_x = end_x
        @end_y = end_y

        @bpm = bpm

        @orbs = []

        @zone_color = Gosu::Color.argb(255, 50, 168, 141)
    end

    def button_down
        @zone_color = Gosu::Color.argb(255, 168, 50, 50)

        threads = []
        threads << Thread.new do
            sleep(0.1)
            @zone_color = Gosu::Color.argb(255, 50, 168, 141)
        end

        @orbs.each do |orb|
            if orb.t > 0.9 && orb.t < 1.1
                @orbs.delete(orb)
            end
        end
    end
        
    def update
        @orbs.each_with_index do |orb, i|
            if orb.update 
                @orbs.delete_at(i)
            end
        end
    end

    def draw
        Gosu.draw_line(@start_x, @start_y, Gosu::Color::WHITE, @end_x, @end_y, Gosu::Color::WHITE)
        Gosu.draw_rect(@end_x - ORB_SIZE / 2 - 1, @end_y - ORB_SIZE / 2 - 1, ORB_SIZE + 2, ORB_SIZE + 2, Gosu::Color::WHITE)
        Gosu.draw_rect(@end_x - ORB_SIZE / 2, @end_y - ORB_SIZE / 2, ORB_SIZE, ORB_SIZE, @zone_color)
        
        @orbs.each do |orb|
            orb.draw
        end
    end

    def add_orb(length, _type)
        @orbs << Orb.new(@start_x, @start_y, @end_x, @end_y, ORB_SIZE, @bpm, length)
    end

    def has_orbs
        @orbs.length > 0
    end
end