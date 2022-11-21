class Text
  def initialize(value, size, x, y)
    @text = value
    @size = size

    @x = x
    @y = y

    @font = Gosu::Font.new(@size)
  end

  def draw
    @font.draw_text(@text, @x, @y, 1, 1, 1, Gosu::Color::WHITE)
  end

  def text=(text)
    @text = text
  end
end