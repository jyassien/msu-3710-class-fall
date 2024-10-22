require 'rails_helper'

RSpec.describe "Students", type: :request do
  # Test GET /students
  describe "GET /students" do
    context "when students exist" do
      let!(:student) { Student.create!(first_name: "Bob", last_name: "John", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

      it "returns a successful response and displays the search form" do
        get students_path
        expect(response).to have_http_status(:ok)  
        expect(response.body).to include('Search')  
      end

      it "does not display students until a search is performed" do
        get students_path
        expect(response.body).to_not include("Hulk") 
      end

      it "returns students when searched by graduation date after a specific date" do
        get students_path, params: { student: { graduation_date_option: 'after', graduation_date: '2024-12-11' } }
        
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Bob") 
      end
    end

    context "when no students exist or no search is performed" do
      it "displays a message prompting to search" do
        Student.delete_all
        get students_path
        expect(response.body).to include("Please enter search criteria to find students")  
      end
    end
  end

  describe "POST /students" do
    context "with valid parameters" do
      let(:valid_attributes) do
        {
          student: {
            first_name: "Abe",
            last_name: "Kebe",
            school_email: "akebe@msudenver.edu",
            major: "Computer Science BS",
            graduation_date: "2026-05-15"
          }
        }
      end

      it "creates a new student and returns a 201 Created status" do
        expect {
          post students_path, params: valid_attributes
        }.to change(Student, :count).by(1) 

        expect(response).to have_http_status(:created)   
        expect(response.body).to include("Student was successfully created.")  
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        {
          student: {
            first_name: "",
            last_name: "",
            school_email: "not-an-email",
            major: "",
            graduation_date: "not-a-date"
          }
        }
      end

      it "does not create a new student and returns a 422 Unprocessable Entity status" do
        expect {
          post students_path, params: invalid_attributes
        }.not_to change(Student, :count)  

        expect(response).to have_http_status(:unprocessable_entity)  
        expect(response.body).to include("prohibited this student from being saved")  
      end
    end
  end

  describe "GET /students/:id" do
    context "when the student exists" do
      let!(:student) { Student.create!(first_name: "Bob", last_name: "John", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

      it "returns a 200 OK status" do
        get student_path(student)
        expect(response).to have_http_status(:ok)  
      end

      it "includes the correct student details in the response body" do
        get student_path(student)
        expect(response.body).to include("Bob")  
        expect(response.body).to include("John")  
        expect(response.body).to include("gordon@msudenver.edu")  
        expect(response.body).to include("Computer Science BS")  
        expect(response.body).to include("2025-05-15") 
      end
    end

    context "when the student does not exist" do
      it "returns a 404 Not Found status" do
        get student_path(id: 404)  
        expect(response).to have_http_status(:not_found)  
      end
    end
  end

  describe "DELETE /students/:id" do
    context "when the student exists" do
      let!(:student) { Student.create!(first_name: "Bob", last_name: "John", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

      it "deletes the student and redirects to the students index" do
        expect {
          delete student_path(student)
        }.to change(Student, :count).by(-1) 

        expect(response).to redirect_to(students_path)   
        follow_redirect!   
        expect(response.body).to include("Student was successfully deleted.")   
      end
    end

    context "when the student does not exist" do
      it "returns a 404 Not Found status" do
        delete student_path(id: 404)  
        expect(response).to have_http_status(:not_found)  
      end
    end
  end
end
