RSpec.describe FlexDiscount do
  it 'has a version number' do
    expect(FlexDiscount::VERSION).not_to be nil
  end

  it 'has a Checkout class' do
    expect{FlexDiscount::Checkout}.not_to raise_error(error=NameError)
  end
end
