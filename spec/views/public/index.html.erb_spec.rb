require 'rails_helper'

RSpec.describe "public/index.html.slim", type: :view do
  it 'displays Welcome to The Progress Report' do
    render
    expect(rendered).to include 'Welcome to The Progress Report'
  end
end
