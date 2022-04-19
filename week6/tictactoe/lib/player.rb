class Player 
  attr_reader :name, :point

  def initialize(name, point = 0)
    @name = name
    @point = point
  end

  def update_point(point)
    @point += point.to_i
  end
end
