require 'rails_helper'

RSpec.describe "teachers/index.html.slim", type: :view do
  it 'renders a list of teachers' do
    assign(:teachers,
           [Teacher.create!(name: 'Mark Stevens'),
            Teacher.create!(name: 'Mark Stevens')])
    render
    assert_select 'tr>td', text: 'Mark Stevens'.to_s, count: 2
  end
end
