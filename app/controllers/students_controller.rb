class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_student_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_student_unprocessable


    def index
        students = Student.all 
        render json: students, status: :ok
    end 

    def show
        student = find_student
        render json: student

    end 

    def create 
        student = Student.create!(student_params)
        render json: student, status: :created
    end 

    def destroy
        student = find_student 
        intructor.destroy 
        head :no_content
    end

    private 
    def find_student
        Student.find(params[:id])
    end
    def student_params 
        params.permit(:name)
    end

    def render_student_not_found
        render json: {error: "not found"}, status: :not_found
    end

    def render_student_unprocessable(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity 

    end

end
