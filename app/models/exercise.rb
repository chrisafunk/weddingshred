
# app/models/exercise.rb
class Exercise < ApplicationRecord
  # --- Enums ---
  enum :movement_pattern, {
    squat: 0, hinge: 1, push: 2, pull: 3, carry: 4,
    rotation: 5, anti_rotation: 6, lunge: 7, jump: 8,
    gait: 9, core_other: 10, multiplane: 11
  }

  enum :exercise_type, {
    strength: 0, hypertrophy: 1, power: 2, stability: 3, mobility: 4, cardio: 5, technique: 6
  }

  enum :starting_position, {
    standing: 0, seated: 1, supine: 2, prone: 3, kneeling: 4,
    hanging: 5, side_lying: 6, quadruped: 7, split_stance: 8
  }

  enum :plane_of_motion, {
    sagittal: 0, frontal: 1, transverse: 2, multi_plane: 3, vertical: 4
  }

  enum :technical_complexity, {
    low: 0, medium: 1, high: 2
  }

  # --- Optional vocabularies to validate arrays ---
  MUSCLES = %w[
    chest triceps biceps delts front_delts rear_delts traps lats rhomboids
    erectors core obliques glutes quads hamstrings calves hip_flexors
    forearms adductors abductors mid_back shoulders upper_back posterior_chain
  ].freeze

  EQUIPMENT = %w[
    bodyweight dumbbell barbell kettlebell cable machine band trap_bar
    smith_machine ez_bar suspension sled medicine_ball landmine rack box bench
  ].freeze

  PURPOSES = %w[
    strength hypertrophy power conditioning fat_loss athletic_performance
    rehab mobility stability technique grip
  ].freeze

  # --- Normalizations ---
  before_validation :normalize_fields

  # --- Validations ---
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 120 }

  validates :movement_pattern, :exercise_type, :starting_position,
            :plane_of_motion, :technical_complexity, presence: true

  validate :arrays_within_vocab
  # --- validate :tempo_format

  # ---validates :reps_min, :reps_max, :sets_min, :sets_max, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  # --- validates :rest_seconds, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  # --- validates :load_min_kg, :load_max_kg, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  # ---validates :target_rpe,  numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }, allow_nil: true
  # ---validates :rir,         numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }, allow_nil: true

  validates :video_url, format: { with: /\Ahttps?:\/\/\S+\z/ }, allow_blank: true

  validates :description, presence: true, length: { maximum: 2000 }

  # === Validations ===

  # Accept any HTTPS URL; many CDNs (Unsplash, etc.) don't expose a file extension.
  validates :thumbnail_url,
              format: { with: /\Ahttps:\/\/\S+\z/ },
              allow_blank: true


  before_validation :autofill_thumbnail_from_video

  # --- Scopes ---
  scope :with_primary_muscle, ->(muscle) { where("? = ANY (primary_muscles)", muscle) }
  scope :with_equipment,      ->(equip)  { where("? = ANY (equipment)", equip) }
  scope :for_purpose,         ->(p)      { where("? = ANY (purposes)", p) }

  private


  # Auto-populate thumbnail for YouTube links when thumbnail_url is blank.
  # Uses the public, no-auth thumbnail endpoints:
  #   https://img.youtube.com/vi/<id>/hqdefault.jpg  (classic)
  #   https://i.ytimg.com/vi/<id>/hqdefault.jpg      (mirror)
  def autofill_thumbnail_from_video
    return if thumbnail_url.present? || video_url.blank?

    yt_id = extract_youtube_id(video_url)
    self.thumbnail_url = "https://img.youtube.com/vi/#{yt_id}/hqdefault.jpg" if yt_id
  end

  # Supports typical YouTube URL shapes: watch?v=, youtu.be/<id>, embed/<id>, shorts/<id>
  def extract_youtube_id(url)
    uri = URI.parse(url) rescue nil
    return nil unless uri&.host

    host = uri.host.downcase
    return uri.path.split('/')[1] if host.include?('youtu.be') && uri.path.present?

    if host.include?('youtube.com')
      if uri.path&.start_with?('/embed/')
        return uri.path.split('/')[2]
      elsif uri.path&.start_with?('/shorts/')
        return uri.path.split('/')[2]
      else
        params = Rack::Utils.parse_query(uri.query)
        return params['v'] if params['v'].present?
      end
    end

    nil
  end

  def normalize_fields
    self.name = name.to_s.strip
    %i[primary_muscles secondary_muscles equipment purposes].each do |attr|
      self[attr] = (self[attr] || []).map { |v| v.to_s.downcase.strip }.reject(&:blank?).uniq
    end
  end

  def arrays_within_vocab
    (primary_muscles || []).each do |m|
      errors.add(:primary_muscles, "#{m.inspect} is not recognized") unless MUSCLES.include?(m)
    end
    (secondary_muscles || []).each do |m|
      errors.add(:secondary_muscles, "#{m.inspect} is not recognized") unless MUSCLES.include?(m)
    end
    (equipment || []).each do |e|
      errors.add(:equipment, "#{e.inspect} is not supported") unless EQUIPMENT.include?(e)
    end
    (purposes || []).each do |p|
      errors.add(:purposes, "#{p.inspect} is not allowed") unless PURPOSES.include?(p)
    end
  end

  # Accepts "3-1-1" or "3:1:1:0" etc.
  # ---def tempo_format
  # --- return if tempo.blank?
  # --- errors.add(:tempo, "must be like 3-1-1 or 3-1-1-0") unless tempo.match?(/\A\d{1,2}([:-]\d{1,2}){2,3}\z/)
  # ---end
end
