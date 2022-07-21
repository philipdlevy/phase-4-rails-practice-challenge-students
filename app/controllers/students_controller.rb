class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        # This code works with the nested student route in the instructor route
        if params[:instructor_id]
            instructor = Instructor.find(params[:instructor_id])
            students = instructor.students
        else
            students = Student.all 
        end
        render json: students, except: [:created_at, :updated_at], include: :instructor
    end

    def show
        student = Student.find(params[:id])
        render json: student, except: [:created_at, :updated_at], include: :instructor, except: [:created_at, :updated_at]
    end

    def create 
        student = Student.create!(student_params)
        render json: student, status: :created
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
    end

end
