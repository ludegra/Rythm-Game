class SceneManager
    def initialize(scenes)
        @scenes = scenes
        @current_scene = nil
    end

    def switch(scene_id)
        @current_scene = @scenes[scene_id]
        @current_scene.wake
    end

    def scene
        @current_scene
    end

    def update
        @current_scene.update
    end

    def draw
        @current_scene.draw
    end

    def button_down(id)
        @current_scene.button_down(id)
    end
end

class Scene
    def wake
    end

    def initialize
    end

    def update
    end

    def draw
    end

    def button_down(id)
    end
end