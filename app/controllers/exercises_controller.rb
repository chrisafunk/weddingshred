class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]


  def index
    @exercises = Exercise.order(:name)
    respond_to do |format|
      format.html
      format.json { render json: @exercises }
    end
  end

  def show
    @exercise = Exercise.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @exercise }
    end
  end

  def new
    @exercise = Exercise.new
  end


  def create
    @exercise = Exercise.new(exercise_params)
    if @exercise.save
      respond_to do |format|
        format.html { redirect_to @exercise, notice: "Exercise created." }
        format.json { render json: @exercise, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @exercise.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end


  def edit
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to exercises_path, notice: "Exercise updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @exercise.destroy
    redirect_to exercises_path, notice: "Exercise deleted."
  end

  private

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end


  private

  def exercise_params
    params.require(:exercise).permit(
      :name, :category, :unit,
      :movement_pattern, :exercise_type, :starting_position,:plane_of_motion,
      :technical_complexity,
      # --- :tempo, :reps_min, :reps_max, :sets_min, :sets_max, :rest_seconds,
      # --- :load_min_kg, :load_max_kg, :target_rpe, :rir,
      :unilateral, :requires_spotter, :range_of_motion,
      :video_url, :contraindications, :coaching_cues,
      :description,
      :thumbnail_url,
      primary_muscles: [], secondary_muscles: [], equipment: [], purposes: [],
      joint_angles: {}
    )
  end

end
