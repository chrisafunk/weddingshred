
# app/helpers/exercises_helper.rb
module ExercisesHelper
  def exercise_thumb(exercise, width: 240, height: 135, class_name: 'rounded me-3 mb-md-0 mb-3')
    url = exercise.thumbnail_url
    begin
      uri = URI.parse(url)
      valid = uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
      valid = false
    end
    url = valid ? url : asset_path('avatar/34.png')
    image_tag(url, alt: "#{exercise.name} thumbnail", loading: :lazy, width: width, height: height, class: class_name)
    end
end
