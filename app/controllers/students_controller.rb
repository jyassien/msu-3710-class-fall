class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # def home
  # end

  # GET /students or /students.json
  # def index
  #   @students = Student.all

  #   if params[:student]
  #     major = params[:student][:major]
  #     graduation_option = params[:student][:graduation_date_option]
  #     date = params[:student][:graduation_date]

  #     @students = @students.where(major: major) if major.present?

  #     if graduation_option.present? && date.present?
  #       if graduation_option == 'before'
  #         @students = @students.where('graduation_date < ?', date)
  #       elsif graduation_option == 'after'
  #         @students = @students.where('graduation_date > ?', date)
  #       end
  #     end
  #   end
  # end

  # def index
  #   puts "\n\n>>>> All Params <<<<"
  #   params.each do |key, value|
  #     puts "#{key}: #{value}"
  #   end
  #   puts ">>>> End of Params <<<<\n\n"
  # end



  def index

    puts "\n\n>>>> All Params <<<<"
    params.each do |key, value|
      puts "#{key}: #{value}"
    end
    puts ">>>> End of Params <<<<\n\n"
  
    @students = [] # This will make sure every get request starts with empty list of students.
  
    if params[:show_all].present?
      @students = Student.all
    elsif params[:student].present?
      major = params[:student][:major]
      graduation_option = params[:student][:graduation_date_option]
      date = params[:student][:graduation_date]
  
      puts ">>>> Search Criteria:"
      puts "Major: #{major}"
      puts "Graduation Option: #{graduation_option}"
      puts "Graduation Date: #{date} \n\n"
  
      # Check for empty param values
      if major.blank? && graduation_option.blank? && date.blank?
        flash.now[:alert] = "Please provide at least one search criterion."
        @students = []  # Empty previous results if any.
      else
        
        @students = Student.all  # Prepare list of all students
        # check for major type or if "Any Major" found
        if major.present? && major != "Any Major"
          @students = @students.where(major: major)
          puts ">>>> Filtered by Major: #{major}"
        else
          puts ">>>> No specific major filter applied. 'Any Major' selected."
        end
  
        # check graduation date options
        if graduation_option.present? && date.present?
          if graduation_option == 'before'
            @students = @students.where('graduation_date < ?', date)
            puts ">>>> Filtered for Graduation Date Before: #{date}"
          elsif graduation_option == 'after'
            @students = @students.where('graduation_date > ?', date)
            puts ">>>> Filtered for Graduation Date After: #{date}"
          end
        end
      end
    else
      puts ">>>> No search parameters provided.\n"
    end
  
    # Show total number of resulting students
    puts ">>>> Resulting Students Count: #{@students.count} \n"
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :school_email, :major, :minor, :graduation_date, :profile_picture)
    end


end
