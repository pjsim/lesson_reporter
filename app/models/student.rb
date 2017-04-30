class Student < ApplicationRecord

  validates :name, presence: true

  before_create :assign_to_first_lesson_and_part

  private

  def assign_to_first_lesson_and_part
    # TODO: assign lesson 1, part 1 before creation
  end
end
