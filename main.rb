require 'ruby2d'


WIDTH = 800
HEIGHT = 600
BACKGROUND_COLOR = '#000000'
LINE_COLOR = '#FFFFFF'

set background: BACKGROUND_COLOR
set width: WIDTH, height: HEIGHT

def draw_dotted_line
  (0..HEIGHT).step(25) do |i|
    Line.new(x1: WIDTH/2 , x2: WIDTH/2 , y1: i , y2: i + 10, width: 3 , color: LINE_COLOR)
  end 
end 

class Paddle
  def initialize(direction)
    @direction = direction
    @x = @direction == 'left' ? 30 : WIDTH - 30
    @y = HEIGHT / 2 
  end 

  def draw
    Rectangle.new(x: @x, y: @y, width: 7, height: 30, color: LINE_COLOR)
  end 

  def move_up
    @y = (@y - 7).clamp(0, HEIGHT)
    p @y
  end 

  def move_down
    @y = (@y + 7).clamp(0, HEIGHT)
    p @y
  end 

  private 
end 

# class Ball
# end 

player = Paddle.new('left')
opponent = Paddle.new('rights')
 

update do
  clear

  draw_dotted_line
  player.draw
  opponent.draw

end 


on :key_held do |event|
  if event.key == 'up'
    player.move_up
  elsif event.key == 'down'
    player.move_down
  end
end

show