class Student < ApplicationRecord
  validates :name, presence: true

  # A newly created Student will start at lesson 1, part 1 (database defaults)
  validates :lesson, numericality:
                       { greater_than_or_equal_to: 1,
                         less_than_or_equal_to: 100 }

  validates :lesson_part, numericality:
                       { greater_than_or_equal_to: 1,
                         less_than_or_equal_to: 3 }
end
