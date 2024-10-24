class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @search_params = params[:search] || {}
    
    #Intialize Students to be empty before search
    @students = Student.none

    #If search is present, hide all
    if params[:search].present?
      
      #When search is made, show student index according to filter
      @students = Student.all


      #Major Search, tied to _search_form.html
      if @search_params[:major].present?
        @students = @students.where(major: @search_params[:major])
      end

      #Graduation Date Search on Controller for before/after gradution date
      if @search_params[:graduation_date].present?
        if @search_params[:VALID_BEFOREANDAFTER] == 'Before'
          @students = @students.where('graduation_date <= ?', @search_params[:graduation_date])
        elsif @search_params[:VALID_BEFOREANDAFTER] == 'After'
          @students = @students.where('graduation_date >= ?', @search_params[:graduation_date])
        end

        #Testing for before/after commands parsing graduation date
        #date = Date.parse(@search_params[graduation_date])
        #@students = @students.where('graduation_date <= ?', ...date)
      end
    

    end #End of hide all

    # In the case that there is no search, send this message
    #For testing purposes in Rspec Test #3
    if @students.empty?
      @students_message = "Please enter search criteria to find students" 
    end
  
   

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
        format.html { redirect_to @student, notice: "Student was successfully created." }
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
        format.html { redirect_to @student, notice: "Student was successfully updated." }
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
      format.html { redirect_to students_path, status: :see_other, notice: "Student was successfully destroyed." }
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
      params.require(:student).permit(:first_name, :last_name, :image, :school_email, :major, :minor, :graduation_date)
    end
end
