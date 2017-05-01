require 'spec_helper'

feature 'Student features' do
  given!(:student) { Student.create! name: Faker::Name.name }
  given!(:student_as_json) do
    {
      student: {
        name: student.name,
        progress: { lesson: student.lesson, lesson_part: student.lesson_part }
      }
    }.to_json
  end

  feature 'See a list of students' do
    scenario 'from the home page' do
      visit root_path
      click_link 'See Students'
      expect(page).to have_content('Students')
      expect(page).to have_content(student.name)
    end

    scenario 'from the navbar' do
      visit root_path
      within("//li[@id='nav-students']") do
        click_link 'Students'
      end
      expect(page).to have_content('Students')
      expect(page).to have_content(student.name)
    end
  end

  feature 'Perform actions from the students page' do
    scenario 'See a student\'s progress in JSON format' do
      visit students_path
      click_link 'JSON', match: :first
      expect(page).to have_content(student_as_json)
    end

    scenario 'See a form to update a student\'s progress' do
      visit students_path
      click_link 'Edit', match: :first
      expect(page).to have_content(student.name)
      expect(page).to have_content('Edit Student')
    end

    describe 'Update a student\'s progress' do
      scenario 'with valid inputs' do
        visit students_path
        click_link 'Edit', match: :first
        fill_in 'student[lesson_part]', with: 2
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

      scenario 'with non sequential inputs' do
        visit students_path
        click_link 'Edit', match: :first
        fill_in 'student[lesson]', with: 2
        click_button 'Update Student'
        expect(page).to have_content('Student can only progress to lesson 1, part 2')
      end
    end
  end
end
