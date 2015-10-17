require 'rails_helper'

RSpec.describe Ipsum, type: :model do

  it 'should not be valid without title' do
    ipsum = Ipsum.new(title: nil)
    expect(ipsum).not_to be_valid
  end

end
