require 'gosu'
require 'debug'

require './lib/scene'
require './lib/menu'
require './lib/level'
require './lib/constants'
require './lib/time'

class GameWindow < Gosu::Window
    def initialize(width=800, height=600, fullscreen=false)
        super(width, height, fullscreen)
        self.caption = "Rhythm Game"

        level_manager = LevelManager.new(File.read("./assets/levels/test.lvl"), width, height)
        menu_manager = MenuManager.new()
        @scene_manager = SceneManager.new({:level => level_manager, :menu => menu_manager})
        @scene_manager.switch(:menu)
    end

    def switch_scene(scene)
        @scene_manager.switch(scene)
    end

    private

    def button_down(id)
        @scene_manager.button_down(id)
    end

    def update
        $mouse_coords = Point2D.new(mouse_x, mouse_y)
        Time.update

        @scene_manager.update
    end
    
    def draw
        Gosu.draw_rect(0, 0, 800, 600, Gosu::Color.argb(255, MAIN_COLOR.r, MAIN_COLOR.g, MAIN_COLOR.b))
        
        @scene_manager.draw
    end
end

$game = GameWindow.new
$game.show