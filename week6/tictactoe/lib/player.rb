class Player 
  PLAYER_INDEXES               = (0..1).to_a.freeze
  PLAYER_NAME_MIN_SIZE         = 3
  PLAYER_NAME_MAX_SIZE         = 11
  PLAYER_NAME_SIZE_MESSAGE     = "\e[31mName length must be between (%s-%s) symbols!\e[0m\n".freeze

  attr_reader :name, :point, :index

  def initialize(name, index)
    @name  = name
    @index = index
    @point = 0
    @moves = {}
  end

  def name
    @name.capitalize
  end

  def valid?
    ![valid_name?,valid_index?].any? false
  end

  def valid_name?
    name_len = @name.to_s.length
    min_size = name_len >= PLAYER_NAME_MIN_SIZE
    max_size = name_len <= PLAYER_NAME_MAX_SIZE
    result = min_size && max_size
    why_invalid unless result
    result
  end

  def valid_index?
    PLAYER_INDEXES.include? @index
  end

  def why_invalid
    printf(PLAYER_NAME_SIZE_MESSAGE, PLAYER_NAME_MIN_SIZE, PLAYER_NAME_MAX_SIZE)
  end

  def add_point(point)
    @point += point.to_i
  end

  def add_move(turn, move)
    @moves[turn] = move
  end

  def moves
    @moves
  end
end
