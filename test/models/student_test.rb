require "test_helper"

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should raise error when saving student with no values" do
    assert_raises ActiveRecord::RecordInvalid do
        Student.create!()
    end
  end

  test "should raise error when saving student without first name" do
    assert_raises ActiveRecord::RecordInvalid do
        Student.create!(last_name: "John", school_email: "bjohn@msudenver.edu", major: "CS", graduation_date: Date.parse("2024-09-23"))
    end
  end

  test "should raise error when saving student without last name" do
    assert_raises ActiveRecord::RecordInvalid do
        Student.create!(first_name: "Bob", school_email: "jbob@msudenver.edu", major: "CS", graduation_date: Date.parse("2024-09-24"))
    end
  end

  test "should raise error when saving student without email" do
    assert_raises ActiveRecord::RecordInvalid do
        Student.create!(first_name: "Bob", last_name: "John", major: "CS", graduation_date: Date.parse("2024-09-25"))
    end
  end

  test "should raise error when saving student without @msudenver.edu email address" do
    assert_raises ActiveRecord::RecordInvalid do
        Student.create!(first_name: "Bob", last_name: "John", school_email: "jbob@gmail.com", major: "CS", graduation_date: Date.parse("2024-09-26"))
    end
  end

  test "should raise error when saving student without major" do
    assert_raises ActiveRecord::RecordInvalid do
        Student.create!(first_name: "Bob", last_name: "John", school_email: "jbob22@msudenver.edu", graduation_date: Date.parse("2024-09-27"))
    end
  end


  test "should raise error when saving student without graduation date" do
    assert_raises ActiveRecord::RecordInvalid do
        Student.create!(first_name: "Bob", last_name: "John", school_email: "jbob22@msudenver.edu")
    end
  end

  test "should save student with no minor attributes" do
    student = Student.create(first_name: "Bob", last_name: "Miller", school_email: "mbob@msudenver.edu", major: "CS", graduation_date: Date.parse("2024-09-28"))
    assert student.persisted?, "Student was not persisted"
  end
  

  test "should save student with valid attributes" do
    student = Student.create!(first_name: "Bob", last_name: "Miller", school_email: "mbob@msudenver.edu", major: "CS", minor: "Maths", graduation_date: Date.parse("2024-09-29"))
    assert student.persisted?, "Student was not persisted"
  end
 

end
