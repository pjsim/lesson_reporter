require 'rails_helper'

RSpec.describe Student, type: :model do
  it 'is not valid without a name' do
    expect(Student.new).to_not be_valid
  end

  it 'is valid with a name' do
    expect(Student.new(name: 'Mark Smith')).to be_valid
  end

  it 'must start at the first lesson on creation' do
    student = Student.create! name: 'Mark Smith'
    expect(student.lesson).to eq 1
    expect(student.lesson_part).to eq 1
  end

  it 'is valid with a lesson between 1 and 100' do
    (1..100).each do |x|
      expect(Student.new(name: 'Mark Smith', lesson: x, lesson_part: 1)).to be_valid
    end
  end

  it 'is invalid with a lesson less than 1' do
    expect(Student.new(name: 'Mark Smith', lesson: 0, lesson_part: 1)).to be_invalid
  end

  it 'is invalid with a lesson more than 100' do
    expect(Student.new(name: 'Mark Smith', lesson: 101, lesson_part: 1)).to be_invalid
  end

  it 'is valid with a lesson part between 1 and 3' do
    (1..3).each do |x|
      expect(Student.new(name: 'Mark Smith', lesson: 1, lesson_part: x)).to be_valid
    end
  end

  it 'is invalid with a lesson part less than 1' do
    expect(Student.new(name: 'Mark Smith', lesson: 1, lesson_part: 0)).to be_invalid
  end

  it 'is invalid with a lesson part more than 3' do
    expect(Student.new(name: 'Mark Smith', lesson: 1, lesson_part: 4)).to be_invalid
  end

  it 'can belong to a teacher' do
    s = Student.reflect_on_association(:teacher)
    expect(s.macro).to eq :belongs_to
  end
end
