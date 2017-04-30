require 'rails_helper'

RSpec.describe Student, type: :model do
  it 'is not valid without a name' do
    expect(Student.new).to_not be_valid
  end

  it 'is valid with a name' do
    expect(Student.new(name: 'Mark Smith')).to be_valid
  end

  it 'must start at the first lesson on creation'
end
