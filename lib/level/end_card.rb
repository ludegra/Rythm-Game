require './lib/modal'
require './lib/components/text'
require './lib/components/button'

class EndCard < Modal
    WIDTH_PERCENTAGE = 0.8
    HEIGHT_PERCENTAGE = 0.6

    def initialize(scr_width, scr_height)
        width = scr_width * WIDTH_PERCENTAGE
        height = scr_height * HEIGHT_PERCENTAGE
        cx = scr_width / 2
        cy = scr_height / 2

        @x = cx - width / 2
        @y = cy - height / 2

        @children = []

        @heading = Text.new("Level Complete", 100, @x + 10, @y + 10)
        @children << @heading

        @menu_button = Button.new("Menu", 30, @x + 10, @y + height - 40, 100, 30) do
            $game.switch_scene(:menu)
        end
        @children << @menu_button

        super(@x, @y, width, height, scr_width, scr_height)
    end

    def draw
        super

        @children.each do |child|
            child.draw
        end

    end

    def button_down(id)
        @menu_button.button_down(id)
    end
end