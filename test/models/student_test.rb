require "test_helper"

class StudentTest < ActiveSupport::TestCase
  # Test #1 "Testing missing field first_name
  do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(last_name: "Thao", major: "CS", school_email: "Thao@msudenver.edu", minor: "Math")
    end

  # Test #2 "Testing valid school email"
  do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name: "Thao" last_name: "Thao", major: "CS", school_email: "Thao@gmail.com")
    end

  # Test #3 "Testing Student one is valid"
  student = students(:one)
  do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name: "Thao" last_name: "Thao", major: "CS", school_email: "Thao@gmail.com")
    end
end
