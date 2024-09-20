require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "should raise error when saving student without first name" do
    assert_raises ActiveRecord::RecordInvalid do
        Student.create!(last_name: "Nikola", school_email: "jokic@msudenver.edu", major: "CS")
    end
 end

end
