require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { Student.new name: Faker::Name.name }
  let(:persisted_student) { Student.create! name: Faker::Name.name }

  it 'is invalid without a name' do
    student.name = nil
    expect(student).to be_invalid
  end

  it 'is valid with a name' do
    expect(student).to be_valid
  end

  it 'must start at the first lesson on creation' do
    expect(student.lesson).to eq 1
    expect(student.lesson_part).to eq 1
  end

  it 'is valid with a lesson between 1 and 100' do
    (1..100).each do |x|
      student.lesson = x
      expect(student).to be_valid
    end
  end

  it 'is invalid with a lesson less than 1' do
    student.lesson = 0
    expect(student).to be_invalid
  end

  it 'is invalid with a lesson more than 100' do
    student.lesson = 101
    expect(student).to be_invalid
  end

  it 'is valid with a lesson part between 1 and 3' do
    (1..3).each do |x|
      student.lesson_part = x
      expect(student).to be_valid
    end
  end

  it 'is invalid with a lesson part less than 1' do
    student.lesson_part = 0
    expect(student).to be_invalid
  end

  it 'is invalid with a lesson part more than 3' do
    student.lesson_part = 4
    expect(student).to be_invalid
  end

  it 'can belong to a teacher' do
    s = Student.reflect_on_association(:teacher)
    expect(s.macro).to eq :belongs_to
  end

  it 'can tell if it can still progress through the lessons' do
    expect(student.can_progress?).to eq true
  end

  it 'can tell when it can progress no further' do
    student.lesson = 100; student.lesson_part = 3
    expect(student.can_progress?).to eq false
  end

  it 'can assign itself the next sequential lesson' do
    student.advance
    expect(student.lesson).to eq 1
    expect(student.lesson_part).to eq 2
    expect(student.persisted?).to eq false
  end

  it 'will progress to the next lesson when advancing from part 3 of a lesson' do
    3.times { student.advance }
    expect(student.lesson).to eq 2
    expect(student.lesson_part).to eq 1
  end

  it 'can update itself to the next sequential lesson' do
    student.advance!
    expect(student.lesson).to eq 1
    expect(student.lesson_part).to eq 2
    expect(student.persisted?).to eq true
  end

  it 'is invalid if updating the lesson and part is not sequential' do
    persisted_student.lesson = 3
    persisted_student.lesson_part = 1
    expect(persisted_student).to be_invalid
  end

  it 'is valid if updating the lesson and part is sequential' do
    persisted_student.lesson = 1
    persisted_student.lesson_part = 2
    expect(persisted_student).to be_valid
  end
end
