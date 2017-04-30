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
