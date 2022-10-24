require 'gosu'
require 'debug'

require './lib/level'

class GameWindow < Gosu::Window
    def initialize(width=800, height=600, fullscreen=false)
        super(width, height, fullscreen)
        self.caption = "Rhythm Game"

        @level_mgr = LevelManager.new(File.read("./assets/levels/test.lvl"), width, height)


        @last = Gosu.milliseconds

        @font = Gosu::Font.new(20)
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
        Gosu.draw_rect(0, 0, 800, 600, Gosu::Color.argb(255, 50, 168, 141))

        @font.draw_text("W", 50, 600 * 1.0/5.0, 1, 1, 1, Gosu::Color::WHITE)
        @font.draw_text("A", 50, 600 * 2.0/5.0, 1, 1, 1, Gosu::Color::WHITE)
        @font.draw_text("S", 50, 600 * 3.0/5.0, 1, 1, 1, Gosu::Color::WHITE)
        @font.draw_text("D", 50, 600 * 4.0/5.0, 1, 1, 1, Gosu::Color::WHITE)
        
        @level_mgr.draw

    end
end

game = GameWindow.new
game.show