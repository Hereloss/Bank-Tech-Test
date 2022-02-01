require './lib/atm_validity'

describe AtmValidity do

  it "Will return true if an input is valid" do
    expect(subject.valid_amount(500)).to eq(true)
    expect(subject.valid_amount("£500")).to eq(true)
  end

  it 'Will raise an error if an input is invalid' do
    expect{subject.valid_amount("Fiver")}.to raise_error('Not a valid amount')
  end

  it "Will return the integer if given an integer value" do
    expect(subject.converting_from_string_to_amount(500)).to eq(500)

  end

  it 'Will return the integer after the £ sign if given a number in the format "£500"' do
    expect(subject.converting_from_string_to_amount("£500")).to eq(500)

  end

end