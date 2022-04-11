require 'repdigit'

describe RepDigit do
  it "returns true" do
    expect(RepDigit.new(1).call).to equal true
  end
end

describe RepDigit do
  it "returns false" do
    expect(RepDigit.new(10).call).to equal false
  end
end


describe RepDigit do
  it "returns true" do
    expect(RepDigit.new('555').call).to equal true
  end
end

describe RepDigit do
  it "returns true" do
    expect(RepDigit.new(9999999999999999).call).to equal true
  end
end

describe RepDigit do
  it "returns true" do
    expect(RepDigit.new('9999999999999999').call).to equal true
  end
end


describe RepDigit do
  it "returns true" do
    expect(RepDigit.new(555).call).to equal true
  end
end

describe RepDigit do
  it "returns false" do
    expect(RepDigit.new(4555).call).to equal false
  end
end

describe RepDigit do
  it "raises AttributeError" do
    expect{ RepDigit.new('4555a').call }.to raise_error(AttributeError)
  end
end

describe RepDigit do
  it "raises AttributeError" do
    expect{ RepDigit.new('').call }.to raise_error(AttributeError)
  end
end

describe RepDigit do
  it "raises AttributeError" do
    expect{ RepDigit.new(-1).call }.to raise_error(AttributeError)
  end
end

describe RepDigit do
  it "raises AttributeError" do
    expect{ RepDigit.new('asfasf43534').call }.to raise_error(AttributeError)
  end
end
