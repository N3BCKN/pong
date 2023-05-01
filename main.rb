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
  attr_reader :x, :y

  def initialize(direction)
    @direction = direction
    @x = @direction == 'left' ? 30 : WIDTH - 30
    @y = HEIGHT / 2 
  end 

  def draw
    Rectangle.new(x: @x, y: @y, width: 7, height: 30, color: LINE_COLOR)
  end 

  def move_up
    @y = (@y - 7).clamp(0, HEIGHT * 0.93)
  end 

  def move_down
    @y = (@y + 7).clamp(0, HEIGHT * 0.93)
  end 

  def hitbox
    (@y-15..@y+15)
  end 

  private 
end 

class Ball
  def initialize
    @x = WIDTH / 2
    @y = HEIGHT  / 2
    @direction = -1
  end 

  def draw
    Circle.new(x: @x, y: @y, radius: 5, color: LINE_COLOR)
  end 

  def move
    hit_top_or_bottom?

    @x += (5 * @direction)
    @y += (2 * @direction)
  end

  def hit_paddle?(player, opponent)
    if (player.hitbox.include?(@y) && @x == 30) || (opponent.hitbox.include?(@y) && @x == WIDTH - 30) 
      @direction *= -1
    end
  end 

  def over_map?
    @x >= WIDTH || @x <= 0 
  end 

  def reset_position
    @x = WIDTH / 2
    @y = HEIGHT  / 2
    @direction = rand > 0.5 ? -1 : 1  
  end 

  private
  def hit_top_or_bottom?
    if @y >= HEIGHT || @y <= 0 
      @direction *= -1
    end 
  end 
end 

player   = Paddle.new('left')
opponent = Paddle.new('right')
ball     = Ball.new 
 

update do
  clear

  draw_dotted_line
  player.draw
  opponent.draw
  ball.draw
  ball.move

  Text.new(
  'Hello',
  x: 150, y: 470,
  font: 'vera.ttf',
  style: 'bold',
  size: 20,
  color: 'blue',
  rotate: 90,
  z: 10
)


  ball.hit_paddle?(player, opponent)

  if ball.over_map?
    ball.reset_position
  end 

end 


on :key_held do |event|
  if event.key == 'up'
    player.move_up
  elsif event.key == 'down'
    player.move_down
  end
end

show