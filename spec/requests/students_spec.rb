require 'rails_helper'
 
#request specs for the Students resource focusing on HTTP requests

# To fit my model, expected_graduation_date is changed to graduation_date

RSpec.describe "Students", type: :request do

  # GET /students (index)
  describe "GET /students" do
    context "when students exist" do
      let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

      # Test 1: Returns a successful response and displays the search form
      it "returns a successful response and displays the search form" do
        get students_path
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Search') # Ensure search form is rendered
      end

      # Test 2: Ensure it does NOT display students without a search
      it "does not display students until a search is performed" do
        get students_path
        expect(response.body).to_not include("Aaron")
      end
    end

    # Test 3: Handle missing records or no search criteria provided
    # Reminder to add a if statement to controller and index for this test!
    context "when no students exist or no search is performed" do
      it "displays a message prompting to search" do
        get students_path
        expect(response.body).to include("Please enter search criteria to find students")
      end
    end
  end

  # Search functionality
  describe "GET /students (search functionality)" do
    let!(:student1) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }
    let!(:student2) { Student.create!(first_name: "Jackie", last_name: "Joyner", school_email: "joyner@msudenver.edu", major: "Data Science and Machine Learning Major", graduation_date: "2026-05-15") }

    # Test 4: Search by major
    it "returns students matching the major" do
      get students_path, params: { search: { major: "Computer Science BS" } }
      expect(response.body).to include("Aaron")
      expect(response.body).to_not include("Jackie")
    end

    # Test 5: Search by expected graduation date (before)
    # To fit with my model, change "after" to "Before"
    # Error with this test. I'm thinking due to the issues the logic in my model is set up with :VALID_BEFOREANDAFTER listed as commands
    # To fix maybe, instead of "data_type", find something else to ensure "Before" works  
    it "returns students graduating before the given date" do
      get students_path, params: { search: { graduation_date: "2026-01-01", date_type: "Before" } }
      expect(response.body).to include("Aaron")
      expect(response.body).to_not include("Jackie")
    end

    # Test 6: Search by expected graduation date (after)
    # To fit with my model, change "after" to "After"
    # Error with this test. I'm thinking due to the issues the logic in my model is set up with :VALID_BEFOREANDAFTER listed as commands
    # To fix maybe, instead of "data_type", find something else to ensure "After" works  
    it "returns students graduating after the given date" do
      get students_path, params: { search: { graduation_date: "2026-01-01", date_type: "After" } }
      expect(response.body).to include("Aaron")
      expect(response.body).to_not include("Jackie")
    end

  end

  # POST /students (create)
  describe "POST /students" do
    context "with valid parameters" do
      # Test 7: Create a new student and ensure it redirects
      it "creates a new student and redirects" do
        expect {
          post students_path, params: { student: { first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15" } }
        }.to change(Student, :count).by(1)

        expect(response).to have_http_status(:found)  # Expect redirect after creation
        follow_redirect!
        expect(response.body).to include("Aaron")  # Student's details in the response
      end

      # Test 8 (Student will complete this part)
      # Ensure that it returns a 201 status or check for creation success
      # Assertion Response is from Slide 16 examples

      it "ensures 201 status or checks for creation success" do
        expect {
          post students_path, params: { student: { first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15" } }
        }.to change(Student, :count).by(1)

        expect(response).to have_http_status(:created)  # Expect creation sucess of Student
      end

    end

    context "with invalid parameters" do
      # Test 9 (Student will complete this part)
      # Ensure it does not create a student and returns a 422 status
      # 422 status is syntax correct, but invalid data

      it "creates a new student that will fail due to bad data" do
        expect {
          post students_path, params: { student: { first_name: "", last_name: "Gordon", school_email: "AaronGemail", 
          major: "Computer Science BS", graduation_date: "2025-05-15" } }
        }.to_not change(Student, :count)

        expect(response).to have_http_status(:not_found)  # Expect 422 status code of bad data in school_email given model restrictions
      end
        
    end
  end

  # GET /students/:id (show)
  describe "GET /students/:id" do
    context "when the student exists" do
      let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

      # Test 10 (Student will complete this part)
      # Ensure it returns a successful response (200 OK)
      it "checks for successful response" do
        get student_path(student) #GET Request for students/id
        expect(response).to have_http_status(:success) # Returns 200 response
      end

      # Test 11 (Student will complete this part)
      # Ensure it includes the student's details in the response body
      it "checks for details in the body" do
        get student_path(student) #GET Request for student. Needed to for response checks
        expect(response.body).to include("Aaron")
        expect(response.body).to include("Gordon")
        expect(response.body).to include("gordon@msudenver.edu")
      end
    end

    # Test 12: Handle missing records, detching a non-existent student
    # Expecting a 404 not found status
    it "checks for non-existent student and returns a 404" do
      get student_path(id: 700) #checking for non-existing 700th student
      expect(response).to have_http_status(:not_found)
    end
    

  end

  # DELETE /students/:id (destroy)
  describe "DELETE /students/:id" do
    let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

    # Test 13: Deletes the student and redirects
    # Incorrect at the moment. Maybe incorrect
    it "deletes the student and redirects" do
      delete "/students/1" #DELETE request to delete student
      expect(response).to have_http_status(:found)  # Expect redirect after deletion
      follow_redirect!
      expect(response).to have_http_status(:success) # Status code 204 to check if redirected link is ok 
    end

    # Test 14: Returns a 404 when trying to delete a non-existent student
    # This code below came with base download
    it "returns a 404 status when trying to delete a non-existent student" do
      delete "/students/9999"
      expect(response).to have_http_status(:not_found)
    end
  end
end
