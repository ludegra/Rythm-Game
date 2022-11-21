require './lib/scene'
require './lib/components/button'

class MenuManager < Scene
    def initialize
        @menu_stack = []

        main_menu = Menu.new
        main_menu.add_button("Play", 30, 100, 100, 100, 30) do
            $game.switch_scene(:level)
        end

        @menu_stack << main_menu

        super
    end

    def draw
        @menu_stack.last.draw

        super
    end

    def button_down(id)
        @menu_stack.last.button_down(id)

        super
    end
end
    
class Menu
    def initialize
        @buttons = []
    end

    def add_button(text, font_size, x, y, width, height, &block)
        @buttons << Button.new(text, font_size, x, y, width, height, &block)
    end

    def draw
        @buttons.each do |button|
            button.draw
        end
    end

    def button_down(id)
        @buttons.each do |button|
            button.button_down(id)
        end
    end
end