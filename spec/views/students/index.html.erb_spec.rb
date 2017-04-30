require 'rails_helper'

RSpec.describe 'students/index.html.slim', type: :view do
  it 'renders a list of students' do
    assign(:students, [Student.create!(name: 'Mark Stevens'), Student.create!(name: 'Mark Stevens')])
    render
    assert_select 'tr>td', text: 'Mark Stevens'.to_s, count: 2
  end
end
