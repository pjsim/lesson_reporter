# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts 'Seeding teachers'
teachers = Teacher.transaction do
  names = []
  5.times { names << { name: Faker::Name.name } }
  Teacher.create!(names)
end

puts 'Seeding students'
Student.transaction do
  30.times do
    Student.create!(
      name: Faker::Name.name,
      lesson: rand(1..100),
      lesson_part: rand(1..3),
      teacher: teachers.sample
    )
  end
end
