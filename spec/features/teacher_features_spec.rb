require 'spec_helper'

feature 'Teacher features' do
  given!(:teacher) { Teacher.create! name: Faker::Name.name }
  given!(:students) do
    Student.transaction do
      names = []
      5.times { names << { name: Faker::Name.name, teacher: teacher } }
      Student.create!(names)
    end
  end
  given!(:student) { students.sample }
  given!(:student_on_final_lesson) do
    Student.create! name: Faker::Name.name, teacher: teacher, lesson: 100, lesson_part: 3
  end

  feature 'See a list of teachers' do
    scenario 'from the home page' do
      visit root_path
      click_link 'See Teachers'
      expect(page).to have_content('Teachers')
      expect(page).to have_content(teacher.name)
    end

    scenario 'from the navbar' do
      visit root_path
      within("//li[@id='nav-teachers']") do
        click_link 'Teachers'
      end
      expect(page).to have_content('Teachers')
      expect(page).to have_content(teacher.name)
    end
  end

  feature 'See a progression report for a teacher\'s students' do
    scenario 'from the teachers page' do
      visit teachers_path
      click_link 'Report', match: :first
      expect(page).to have_content(teacher.name)
      expect(page).to have_content(student.name)
      expect(page).to have_content(student.lesson)
      expect(page).to have_content(student.lesson_part)
    end
  end

  feature 'Can advance a student forward one lesson at a time' do
    scenario 'if they have lessons they can progress to' do
      visit teacher_path(teacher)
      # Click on the Advance button in the same table row which has the student's name
      find(:xpath, "//tr[contains(.,\"#{student.name}\")]/td/a", text: 'Advance').click
      student.reload
      expect(page).to have_content(teacher.name)
      expect(page).to have_content(student.name)
      expect(page).to have_content(
        "#{student.name} has been advanced to lesson #{student.lesson}, part #{student.lesson_part}"
      )
    end

    scenario 'but not if they have reached the final lesson' do
      visit teacher_path(teacher)
      # Click on the Advance button in the same table row which has the student's name
      find(:xpath, "//tr[contains(.,\"#{student_on_final_lesson.name}\")]/td/a", text: 'Advance').click
      student_on_final_lesson.reload
      expect(page).to have_content(teacher.name)
      expect(page).to have_content(student_on_final_lesson.name)
      expect(page).to have_content('This student cannot advance further')
    end
  end
end
