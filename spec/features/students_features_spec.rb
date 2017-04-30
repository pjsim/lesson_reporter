require 'spec_helper'

feature 'See a list of students' do
  given!(:student) { Student.create! name: Faker::Name.name }

  scenario 'from the home page' do
    visit root_path
    click_link 'See Students'
    expect(page).to have_content('Students')
    expect(page).to have_content(student.name)
  end
end

feature 'See a student\'s progress in JSON format' do
  given!(:student) { Student.create! name: Faker::Name.name }
  given!(:student_as_json) do
    {
      student: {
        name: student.name,
        progress: { lesson: student.lesson, lesson_part: student.lesson_part }
      }
    }.to_json
  end

  scenario 'from the students page' do
    visit students_path
    click_link 'JSON', match: :first
    expect(page).to have_content(student_as_json)
  end
end

feature 'See a form to update a student\'s progress' do
  given!(:student) { Student.create! name: Faker::Name.name }

  scenario 'from the students page' do
    visit students_path
    click_link 'Edit', match: :first
    expect(page).to have_content(student.name)
    expect(page).to have_content('Edit Student')
  end
end

feature 'Update a student\'s progression' do
  given!(:student) { Student.create! name: Faker::Name.name }

  scenario 'with valid inputs' do
    visit students_path
    click_link 'Edit', match: :first
    fill_in 'student[lesson]', with: 40
    click_button 'Update Student'
    expect(page).to have_content("#{student.name}'s progression was successfully updated.")
  end

  scenario 'with invalid inputs' do
    visit students_path
    click_link 'Edit', match: :first
    fill_in 'student[lesson]', with: 400
    click_button 'Update Student'
    expect(page).to have_content('Lesson must be less than or equal to 100')
  end
end
