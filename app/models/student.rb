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

  # Validate the lessons are only updated sequentially (if not using the advance method)
  validate :lesson_and_parts_update_sequentially, on: :update

  # Student is able to progress to the next lesson unless they have reached lesson 100, part 3
  def can_progress?
    lesson < 100 || lesson_part < 3
  end

  # Assign the student the next sequential lesson if able to do so
  def advance
    assign_attributes lesson: next_lesson, lesson_part: next_part if can_progress?
    self
  end

  # Assign the student to the next sequential lesson and commit to the database
  def advance!
    update! lesson: next_lesson, lesson_part: next_part if can_progress?
  end

  private

  # Pass validation only if the changed progress matches what the advance method would have returned
  def lesson_and_parts_update_sequentially
    advanced_progress = use_advance_on_unchanged_progress
    return if changed_progress_matches? advanced_progress
    errors.add :student, "can only progress to lesson #{advanced_progress['lesson']}, part #{advanced_progress['lesson_part']}"
  end

  # Returns the proper lesson progress using advance with progress from before the change
  def use_advance_on_unchanged_progress
    previous_student = dup
    previous_student.assign_attributes(lesson: lesson_was, lesson_part: lesson_part_was)
    previous_student.advance.attributes.slice('lesson', 'lesson_part')
  end

  # Check the students progress attributes against another progress hash
  def changed_progress_matches? advanced_progress
    student_progress = attributes.slice('lesson', 'lesson_part')
    student_progress == advanced_progress
  end

  # Increment the lesson if on part 3 of a lesson, unless at lesson 100
  def next_lesson
    lesson < 100 && lesson_part == 3 ? lesson + 1 : lesson
  end

  # Increment the lesson part unless on part 3
  def next_part
    lesson_part != 3 ? lesson_part + 1 : 1
  end
end
