require './lib/modal'

class EndCard < Modal
    WIDTH_PERCENTAGE = 0.8
    HEIGHT_PERCENTAGE = 0.6

    def initialize(scr_width, scr_height)
        width = scr_width * WIDTH_PERCENTAGE
        height = scr_height * HEIGHT_PERCENTAGE
        cx = scr_width / 2
        cy = scr_height / 2

        super(cx - width / 2, cy - height / 2, width, height, scr_width, scr_height)
    end
end