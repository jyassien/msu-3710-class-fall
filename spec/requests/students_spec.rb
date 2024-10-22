require 'rails_helper'

RSpec.describe "Students", type: :request do
  describe "GET /students" do
    it "works! (now write some real specs)" do
      get students_path
      expect(response).to have_http_status(200)
    end
  end
end

RSpec.describe "Students", type: :request do
  describe "GET /students" do
    it "returns a successful response" do
      get students_path
      expect(response).to have_http_status(:ok)
    end
  end
 end
 
 # GET /students (index)
 describe "GET /students" do
  context "when students exist" do
    let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", expected_graduation_date: "2025-05-15") }

    # Test 1: Returns a successful response and displays the search form
    it "returns a successful response and displays the search form" do
      get students_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Search') # Ensure search form is rendered
    end

#     # Test 2: Ensure it does NOT display students without a search
#     it "does not display students until a search is performed" do
#       get students_path
#       expect(response.body).to_not include("Aaron")
#     end
#   end

#   # Test 3: Handle missing records or no search criteria provided
#   context "when no students exist or no search is performed" do
#     it "displays a message prompting to search" do
#       get students_path
#       expect(response.body).to include("Please enter search criteria to find students")
#     end
#   end
# end
