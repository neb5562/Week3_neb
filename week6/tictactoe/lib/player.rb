class Player 
  PLAYER_X_INDEX               = 1
  PLAYER_O_INDEX               = 0
  PLAYER_NAME_MIN_SIZE         = 3
  PLAYER_NAME_MAX_SIZE         = 11
  PLAYER_NAME_MIN_SIZE_MESSAGE = "name must not be less than %s symbols!\n".freeze
  PLAYER_NAME_MAX_SIZE_MESSAGE = "name must not be over %s symbols!\n".freeze

  attr_reader :name, :point

  def initialize(name)
    @name  = name
    @point = 0
    
    min_symbols_message = sprintf(PLAYER_NAME_MIN_SIZE_MESSAGE, PLAYER_NAME_MIN_SIZE)
    max_symbols_message = sprintf(PLAYER_NAME_MAX_SIZE_MESSAGE, PLAYER_NAME_MAX_SIZE)
    Validation.validate_presence(@name, "name")
    #Validation.validate_with_lambda(@name.to_s.length > PLAYER_NAME_MIN_SIZE, min_symbols_message)
    #Validation.validate_with_lambda(@name.to_s.length < PLAYER_NAME_MAX_SIZE, max_symbols_message)
  rescue AttributeError => e
    e.message
  end

  def add_point(point)
    @point += point.to_i
  end
end
