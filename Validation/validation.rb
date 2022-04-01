class Validation
  def initialize
    @validations = []
  end

  def validate_type(value, type, name)
    Class.send(type.to_s, value) rescue @validations.push("#{name} must be #{type}!")
  end

  def validate_presence(value, name)
    @validations.push("you must enter #{name}!") if value.to_s.empty? 
  end

  def check_all_validations
    if @validations.empty? == false
      puts "\e[41mYou have validation errors!\e[0m"
      @validations.each do |message|
        puts "\e[31m#{message}\e[0m"
      end
      exit 1
    end
  end
end
