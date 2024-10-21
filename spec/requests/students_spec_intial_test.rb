require 'rails_helper'

#Get Request
RSpec.describe "Students", type: :request do
  describe "GET /students" do
    it "returns a successful response" do
      get students_path
      expect(response).to have_http_status(:ok)
      puts "GET Request Students Index done"
    end
  end
end

RSpec.describe "Students", type: :request do
  describe "GET /students" do
    context "when students exist" do
      let!(:student) {Student.create!(first_name: "Aaron", last_name: "Gordon", 
      school_email:"gordon@msudenver.edu", major:"Computer Science BS",
      graduation_date:"2025-05-15")}
  end
end
