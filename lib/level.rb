require './lib/scene'

require './lib/level/lane'
require './lib/level/end_card'

OrbData = Struct.new(:delta_time, :length, :lane, :type)

class Level
    attr_reader :orbs, :bpm, :time_signature

    def initialize(level_src)
        sections = level_src.split("\n---\n")

        meta = sections[0].split("\n")
        @bpm = meta[0].to_i

        time = meta[1].split("/")
        @time_signature = TimeSignature.new(time[0].to_i, time[1].to_i)

        @orbs = sections[1].split("\n").map do |orb|
            orb_data = orb.split(" ")
            OrbData.new(orb_data[0].to_f, orb_data[1].to_f, orb_data[2].to_i, orb_data[3].to_i)
        end

        @ended = false
    end
end

class LevelManager
    def initialize(level, width, height)
        @width = width
        @height = height

        @level = Level.new(level)

        @lanes = []

        @lanes << Lane.new(50, height * 1.0/5.0, width - 2 * 50, height * 1.0/5.0, @level.bpm)
        @lanes << Lane.new(50, height * 2.0/5.0, width - 2 * 50, height * 2.0/5.0, @level.bpm)
        @lanes << Lane.new(50, height * 3.0/5.0, width - 2 * 50, height * 3.0/5.0, @level.bpm)
        @lanes << Lane.new(50, height * 4.0/5.0, width - 2 * 50, height * 4.0/5.0, @level.bpm)

        @end_modal = EndCard.new(width, height)

        super()
    end

    def wake
        @last_event = 0
        @current_orb = 0
        
        @ended = false
        
        @level_time = Time.now
    end

    def button_down(id)
        lane_index = case id
        when Gosu::KB_W
            0
        when Gosu::KB_A
            1
        when Gosu::KB_S
            2
        when Gosu::KB_D
            3
        end

        @lanes[lane_index].button_down if !lane_index.nil?
        @end_modal.button_down(id) if @ended
    end

    def update
        if !@current_orb.nil?
            time = Time.since(@level_time)
            if time - @last_event > @level.orbs[@current_orb].delta_time
                @lanes[@level.orbs[@current_orb].lane].add_orb(@level.orbs[@current_orb].length, @level.orbs[@current_orb].type)
    
                @last_event += @level.orbs[@current_orb].delta_time
                if @level.orbs[@current_orb + 1].nil?
                    @current_orb = nil
                else
                    @current_orb += 1
                end
            end
        else
            if @lanes.all? { |lane| !lane.has_orbs } && !@ended
                @ended = true
                @end_modal.fade_in(500)
            end
        end

        if !@ended
            @lanes.each do |lane|
                lane.update
            end
        end

        @end_modal.update if @ended
    end

    def draw
        @lanes.each do |lane|
            lane.draw
        end

        font = Gosu::Font.new(20)
        font.draw_text("W", 50, 600 * 1.0/5.0, 1, 1, 1, Gosu::Color::WHITE)
        font.draw_text("A", 50, 600 * 2.0/5.0, 1, 1, 1, Gosu::Color::WHITE)
        font.draw_text("S", 50, 600 * 3.0/5.0, 1, 1, 1, Gosu::Color::WHITE)
        font.draw_text("D", 50, 600 * 4.0/5.0, 1, 1, 1, Gosu::Color::WHITE)

        if @ended
            @end_modal.draw
        end
    end
end