require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it 'is not valid without a name' do
    expect(Teacher.new).to_not be_valid
  end

  it 'is valid with a name' do
    expect(Teacher.new(name: 'Mark Smith')).to be_valid
  end

  it 'can have many students' do
    t = Teacher.reflect_on_association(:students)
    expect(t.macro).to eq :has_many
  end
end
