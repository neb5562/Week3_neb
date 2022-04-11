require 'repdigit'
require 'faker'
SYMBOLS_NUMBER_FROM = 1
SYMBOLS_NUMBER_TO = 999

NUMBER_CHAR_FROM = 0
NUMBER_CHAR_TO = 9

GENERATE_MIN = 1
GENERATE_MAX = 1_000_000

STRING_LEN_FROM = 1
STRING_LEN_TO = 30

100.times do
  describe RepDigit do
    # must raise AttributeError fo ar negative numbers as it will not pass validation
    it "raises AttributeError" do
      expect{RepDigit.new(Faker::Number.negative).call}.to raise_error(AttributeError)
    end

    # will generate random numbers like 3333333, 555555555555555, 22222222. all msut be true
    it "returns true" do
      expect(RepDigit.new(Faker::Number.within(range: NUMBER_CHAR_FROM..NUMBER_CHAR_TO).to_s * rand(SYMBOLS_NUMBER_FROM...SYMBOLS_NUMBER_TO).to_i).call).to be_truthy
    end

    # need to generate non repdigit numbers
    it "returns false" do
      expect(RepDigit.new(Faker::Number.between(from: GENERATE_MIN, to: GENERATE_MAX).to_i).call).to be_falsey
    end
    # will generate random string
    it "raises AttributeError" do
      expect{ RepDigit.new(Faker::String.random(length: STRING_LEN_FROM..STRING_LEN_TO)).call }.to raise_error(AttributeError)
    end

  end
end

# empty value or nil
describe RepDigit do

  it "raises AttributeError" do
    expect{ RepDigit.new('').call }.to raise_error(AttributeError)
  end

  it "raises AttributeError" do
    expect{ RepDigit.new(nil).call }.to raise_error(AttributeError)
  end

end
