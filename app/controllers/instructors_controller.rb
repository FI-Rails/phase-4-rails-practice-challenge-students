class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_instructor_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_instructor_unprocessable


    def index 
        instructors = Instructor.all 
        render json: instructors, status: :ok
    end 

    def show
        instructor = find_instructor
        render json: instructor

    end 

    def create 
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end 

    def destroy
        instructor = find_instructor 
        intructor.destroy 
        head :no_content
    end

    private 
    def find_instructor
        Instructor.find(params[:id])
    end
    def instructor_params 
        params.permit(:name)
    end

    def render_instructor_not_found
        render json: {error: "not found"}, status: :not_found
    end

    def render_instructor_unprocessable(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity 

    end

    
end
