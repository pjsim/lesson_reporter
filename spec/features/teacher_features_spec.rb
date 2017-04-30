require 'spec_helper'

feature 'See a list of teachers' do
  given!(:teacher) { Teacher.create! name: Faker::Name.name }

  scenario 'from the home page' do
    visit root_path
    click_link 'See Teachers'
    expect(page).to have_content('Teachers')
    expect(page).to have_content(teacher.name)
  end
end

feature 'See a progression report for a teacher\'s students' do
  given!(:teacher) { Teacher.create! name: Faker::Name.name }
  given!(:student) { Student.create! name: Faker::Name.name, teacher: teacher }

  scenario 'from the teachers page' do
    visit teachers_path
    click_link 'Report', match: :first
    expect(page).to have_content(student.name)
    expect(page).to have_content(student.lesson)
    expect(page).to have_content(student.lesson_part)
  end
end
