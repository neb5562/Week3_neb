class Validation
  def initialize
    @validations = []
  end

  def validate_int(number, name)
    if number.to_i.to_s != number
      @validations.push("#{name} must be integer!")
    end
  end

  def validate_presence_of(value, name)
    if value.to_s.empty? == true
      @validations.push("you must enter #{name}!")
    end
  end

  def check_all_validations
    if @validations.empty? == false
      @validations.each do |message|
        puts message
      end
      exit 1
    end
  end
end
