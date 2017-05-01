require 'rails_helper'

RSpec.describe Teacher, type: :model do
  let(:teacher) { Teacher.new name: Faker::Name.name }
  it 'is not valid without a name' do
    teacher.name = nil
    expect(teacher).to be_invalid
  end

  it 'is valid with a name' do
    expect(teacher).to be_valid
  end

  it 'can have many students' do
    t = Teacher.reflect_on_association(:students)
    expect(t.macro).to eq :has_many
  end
end
