class Student < ApplicationRecord
  # A newly created student will start at lesson 1, part 1 (database defaults)

  belongs_to :teacher, optional: true # A student might not always have a teacher assigned to them

  validates :name, presence: true

  validates :lesson, numericality:
                       { greater_than_or_equal_to: 1,
                         less_than_or_equal_to: 100 }

  validates :lesson_part, numericality:
                       { greater_than_or_equal_to: 1,
                         less_than_or_equal_to: 3 }
end
