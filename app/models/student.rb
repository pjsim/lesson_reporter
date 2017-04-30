class Student < ApplicationRecord
  # A newly created student will start at lesson 1, part 1 (database defaults)

  validates :name, presence: true

  validates :lesson, numericality:
                       { greater_than_or_equal_to: 1,
                         less_than_or_equal_to: 100 }

  validates :lesson_part, numericality:
                       { greater_than_or_equal_to: 1,
                         less_than_or_equal_to: 3 }
end
