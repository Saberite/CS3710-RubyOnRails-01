require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "should raise error when saving student without first name" do
      assert_raises ActiveRecord::RecordInvalid do
          Student.create!(last_name: "Test0", school_email: "test@msudenver.edu", major: "CS", graduation_date: 05-22-2025)
      end
    end

  test "should raise error when saving with no email" do
      assert_raises ActiveRecord::RecordInvalid do
          Student.create!(first_name: "Test1", last_name: "Tester1", major: "CS", graduation_date: 10-22-2025)
      end
    end
  test "should raise error when saving with non-MSU email" do
      assert_raises ActiveRecord::RecordInvalid do
          Student.create!(first_name: "Test2", last_name: "Tester2", school_email: "test@gmail.com", major: "CS", graduation_date: 10-22-2025)
      end
    end

  test "should raise error when saving with missing Major" do
      assert_raises ActiveRecord::RecordInvalid do
          Student.create!(first_name: "Test3", last_name: "Tester3", school_email: "test3@msudenver.edu", graduation_date: 10-22-2025)
      end
    end

    test "should raise error when saving with missing last name" do
      assert_raises ActiveRecord::RecordInvalid do
          Student.create!(first_name: "Test4", school_email: "test4@msudenver.edu", major: "CS", graduation_date: 10-22-2025)
      end
    end

    test "should raise error when saving with no graduation date entered" do
      assert_raises ActiveRecord::RecordInvalid do
          Student.create!(first_name: "Test5",  last_name: "Tester5", school_email: "test5@msudenver.edu", major: "CS")
      end
    end
     
    test "should raise error when saving with duplicate emails" do
      #Reading from Student(one) compared to "test6@msudenver.edu"
      student = student(:one)
      assert_raises ActiveRecord::RecordInvalid do
          Student.create!(first_name: "Test6",  last_name: "Tester6", school_email: "test6@msudenver.edu", major: "CS", graduation_date: 10-22-2025)
      end
    end

    test "should work correctly when all values are correct" do
      assert_raises ActiveRecord::RecordInvalid do
          Student.create!(first_name: "Test7",  last_name: "Tester7", school_email: "test7@msudenver.edu", major: "CS", graduation_date: 10-22-2025)
      end
    end
end

