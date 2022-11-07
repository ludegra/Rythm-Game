require 'gosu'
require 'debug'

require './lib/level'
require './lib/constants'

class GameWindow < Gosu::Window
    def initialize(width=800, height=600, fullscreen=false)
        super(width, height, fullscreen)
        self.caption = "Rhythm Game"

        @level_mgr = LevelManager.new(File.read("./assets/levels/test.lvl"), width, height)


        @last = Gosu.milliseconds
    end

    private

    def button_down(id)
        @level_mgr.button_down(id)
    end

    def update
        @delta_time = Gosu.milliseconds - @last
        @last = Gosu.milliseconds

        @level_mgr.update(@delta_time)
    end
    
    def draw
        Gosu.draw_rect(0, 0, 800, 600, Gosu::Color.argb(255, MAIN_COLOR.r, MAIN_COLOR.g, MAIN_COLOR.b))
        
        @level_mgr.draw

    end
end

game = GameWindow.new
game.show