
# db/seeds/exercises.seeds.rb

def create_exercise!(attrs)
  Exercise.create!(attrs)
rescue ActiveRecord::RecordInvalid => e
  warn "Failed to create #{attrs[:name]}: #{e.record.errors.full_messages.join(', ')}"
  raise
end


require "erb"
def ph(name, w: 640, h: 360)
  text = ERB::Util.url_encode(name)
  "https://placehold.co/#{w}x#{h}.jpg?text=#{text}"
end


# --- CC0/free-commercial thumbnails (Pixabay) ---
THUMBS = [
  "https://cdn.pixabay.com/photo/2016/11/19/14/00/fitness-1839087_1280.jpg",
  "https://cdn.pixabay.com/photo/2017/01/06/19/15/girl-1958726_1280.jpg",
  "https://cdn.pixabay.com/photo/2017/03/02/21/52/weights-2111542_1280.jpg",
  "https://cdn.pixabay.com/photo/2016/11/21/16/01/athlete-1846039_1280.jpg",
  "https://cdn.pixabay.com/photo/2016/03/27/21/16/dumbbell-1287229_1280.jpg",
  "https://cdn.pixabay.com/photo/2016/11/21/16/02/athlete-1846056_1280.jpg",
  "https://cdn.pixabay.com/photo/2017/03/02/21/50/sports-2111536_1280.jpg",
  "https://cdn.pixabay.com/photo/2017/08/06/14/01/people-2590531_1280.jpg",
  "https://cdn.pixabay.com/photo/2016/02/12/20/01/fitness-1195847_1280.jpg",
  "https://cdn.pixabay.com/photo/2017/01/14/10/57/woman-1979272_1280.jpg"
].freeze

def thumb(i) = THUMBS[i % THUMBS.length]
def jhash(h) = h

exercises = []

# -------------------------
# 01–10 Squat / Hinge group
# -------------------------

exercises << {
  name: "Barbell Back Squat",
  category: "lower_body", unit: "reps",
  movement_pattern: :squat, exercise_type: :strength,
  starting_position: :standing, plane_of_motion: :sagittal, technical_complexity: :high,
  primary_muscles: %w[quads glutes], secondary_muscles: %w[hamstrings core erectors],
  equipment: %w[barbell rack], purposes: %w[strength hypertrophy],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Parallel or below with neutral spine.",
  coaching_cues: "Brace; sit back/down; knees track over toes; drive mid‑foot.",
  contraindications: nil, joint_angles: jhash({ "knee_flexion_deg" => "90-120", "hip_flexion_deg" => "60-100" }),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-back-squat/", # page exists on ExerciseLibrary.com [1](https://www.youtube.com/watch?v=z7E_YU9P1jU)
  thumbnail_url: ph("Barbell Back Squat"),
  description: "Foundational squat pattern emphasizing quads and glutes."
}

exercises << {
  name: "Barbell Front Squat",
  category: "lower_body", unit: "reps",
  movement_pattern: :squat, exercise_type: :strength,
  starting_position: :standing, plane_of_motion: :sagittal, technical_complexity: :high,
  primary_muscles: %w[quads glutes], secondary_muscles: %w[core erectors],
  equipment: %w[barbell rack], purposes: %w[strength hypertrophy],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Upright torso to parallel; maintain front rack.",
  coaching_cues: "Elbows high; brace; knees forward/out.",
  contraindications: nil, joint_angles: jhash({ "knee_flexion_deg" => "90-120" }),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-front-squat/", # page exists [11](https://www.exerciselibrary.com/exercise/landmine-standing-single-arm-press/)
  thumbnail_url: ph("Barbell Front Squat"),
  description: "Anteriorly loaded squat with higher quad/core demand."
}

exercises << {
  name: "Barbell Box Squat",
  category: "lower_body", unit: "reps",
  movement_pattern: :squat, exercise_type: :strength,
  starting_position: :standing, plane_of_motion: :sagittal, technical_complexity: :medium,
  primary_muscles: %w[quads glutes], secondary_muscles: %w[hamstrings core],
  equipment: %w[barbell rack box], purposes: %w[strength technique],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Control to box height; keep tension; drive up.",
  coaching_cues: "Sit back; shins near vertical; pause then stand.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-box-squat/", # page exists [12](https://www.verywellfit.com/how-to-do-a-farmer-carry-techniques-benefits-variations-4796615)
  thumbnail_url: ph("Barbell Box Squat"),
  description: "Depth‑consistent squat emphasizing hip drive and control."
}

exercises << {
  name: "Barbell Close Stance Squat",
  category: "lower_body", unit: "reps",
  movement_pattern: :squat, exercise_type: :hypertrophy,
  starting_position: :standing, plane_of_motion: :sagittal, technical_complexity: :medium,
  primary_muscles: %w[quads], secondary_muscles: %w[glutes hamstrings core],
  equipment: %w[barbell rack], purposes: %w[hypertrophy strength],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Deeper knee flexion with narrow stance.",
  coaching_cues: "Knees track; torso upright; balanced feet.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-close-stance-squat/", # page exists [13](https://www.exerciselibrary.com/exercise/landmine-squat-press/)
  thumbnail_url: ph("Barbell Close Stance Squat"),
  description: "Narrow stance to emphasize quadriceps through greater knee bend."
}

exercises << {
  name: "Barbell Bulgarian Split Squat",
  category: "lower_body", unit: "reps",
  movement_pattern: :lunge, exercise_type: :hypertrophy,
  starting_position: :split_stance, plane_of_motion: :sagittal, technical_complexity: :medium,
  primary_muscles: %w[quads glutes], secondary_muscles: %w[hamstrings core],
  equipment: %w[barbell bench], purposes: %w[hypertrophy stability],
  unilateral: true, requires_spotter: false,
  range_of_motion: "Rear foot elevated; descend to deep hip/knee flexion.",
  coaching_cues: "Torso tall; front heel pressure; steady tempo.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-bulgarian-split-squat/", # page exists [14](https://www.exerciselibrary.com/exercise/landmine-squat/)
  thumbnail_url: ph("Barbell Bulgarian Split Squat"),
  description: "Unilateral squat with deep ROM for quads/glutes and balance."
}

exercises << {
  name: "Barbell Split Squat",
  category: "lower_body", unit: "reps",
  movement_pattern: :lunge, exercise_type: :hypertrophy,
  starting_position: :split_stance, plane_of_motion: :sagittal, technical_complexity: :low,
  primary_muscles: %w[quads glutes], secondary_muscles: %w[hamstrings core],
  equipment: %w[barbell], purposes: %w[hypertrophy stability],
  unilateral: true, requires_spotter: false,
  range_of_motion: "Controlled depth; front knee tracks.",
  coaching_cues: "Even weight; upright torso.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-split-squat/", # page exists [15](https://www.exerciselibrary.com/exercise/medicine-ball-sumo-squat/)
  video_url: "https://www.exerciselibrary.com/exercise/barbell-bulgarian-split-squat/", # page exists [14](https://www.exerciselibrary.com/exercise/landmine-squat/)
  thumbnail_url: ph("Barbell Split Squat"),
  description: "Static lunge pattern emphasizing quad/glute development."
}

exercises << {
  name: "Barbell Walking Lunge",
  category: "lower_body", unit: "reps",
  movement_pattern: :lunge, exercise_type: :hypertrophy,
  starting_position: :standing, plane_of_motion: :sagittal, technical_complexity: :medium,
  primary_muscles: %w[glutes quads], secondary_muscles: %w[hamstrings core],
  equipment: %w[barbell], purposes: %w[hypertrophy conditioning],
  unilateral: true, requires_spotter: false,
  range_of_motion: "Long stride; back knee toward floor; front shin vertical.",
  coaching_cues: "Tall posture; control the eccentric.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-walking-lunge/", # page exists [16](https://www.exerciselibrary.com/exercise/cable-glute-extension/)
  thumbnail_url: ph("Barbell Walking Lunge"),
  description: "Dynamic single‑leg pattern building strength and coordination."
}

exercises << {
  name: "Barbell Deadlift",
  category: "lower_body", unit: "reps",
  movement_pattern: :hinge, exercise_type: :strength,
  starting_position: :standing, plane_of_motion: :sagittal, technical_complexity: :high,
  primary_muscles: %w[glutes hamstrings], secondary_muscles: %w[erectors lats traps],
  equipment: %w[barbell], purposes: %w[strength],
  unilateral: false, requires_spotter: false,
  range_of_motion: "From floor; lock hips/knees together.",
  coaching_cues: "Brace; lats tight; push floor.",
  contraindications: nil, joint_angles: jhash({ "hip_flexion_deg" => "70-100" }),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-deadlift/", # page exists [17](https://www.exerciselibrary.com/exercise/barbell-bent-over-row/)
  thumbnail_url: ph("Barbell Deadlift"),
  description: "Full‑range pull building total posterior‑chain strength."
}

exercises << {
  name: "Barbell Sumo Deadlift",
  category: "lower_body", unit: "reps",
  movement_pattern: :hinge, exercise_type: :strength,
  starting_position: :standing, plane_of_motion: :sagittal, technical_complexity: :medium,
  primary_muscles: %w[glutes adductors], secondary_muscles: %w[hamstrings quads erectors],
  equipment: %w[barbell], purposes: %w[strength],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Wide stance; vertical torso; pull to lockout.",
  coaching_cues: "Knees out; bar close; drive through feet.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-sumo-deadlift/", # page exists [18](https://www.exerciselibrary.com/exercise/cable-high-pull/)
  thumbnail_url: ph("Barbell Sumo Deadlift"),
  description: "Hip‑dominant pull with reduced back angle; adductor emphasis."
}

exercises << {
  name: "Barbell Straight‑Leg Deadlift",
  category: "lower_body", unit: "reps",
  movement_pattern: :hinge, exercise_type: :hypertrophy,
  starting_position: :standing, plane_of_motion: :sagittal, technical_complexity: :medium,
  primary_muscles: %w[hamstrings], secondary_muscles: %w[glutes erectors],
  equipment: %w[barbell], purposes: %w[hypertrophy strength],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Minimal knee bend; hinge to strong hamstring stretch.",
  coaching_cues: "Soft knees; bar close; flat back.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-straight-leg-deadlift/", # page exists [19](https://www.exerciselibrary.com/exercise/barbell-bent-over-row-wide-grip/)
  thumbnail_url: ph("Barbell Straight‑Leg Deadlift"),
  description: "Posterior‑chain lengthening hinge emphasizing hamstrings."
}

# -------------------------
# 11–20 Bench / Shoulder
# -------------------------

exercises << {
  name: "Barbell Bench Press",
  category: "upper_body", unit: "reps",
  movement_pattern: :push, exercise_type: :strength,
  starting_position: :supine, plane_of_motion: :transverse, technical_complexity: :medium,
  primary_muscles: %w[chest triceps], secondary_muscles: %w[front_delts],
  equipment: %w[barbell rack bench], purposes: %w[strength hypertrophy],
  unilateral: false, requires_spotter: true,
  range_of_motion: "Bar to mid‑chest; forearms vertical; shoulders packed.",
  coaching_cues: "Scap set; leg drive; press back & up.",
  contraindications: nil, joint_angles: jhash({ "shoulder_horizontal_abduction_deg" => "60-80" }),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-bench-press/", # page exists [2](https://www.exerciselibrary.com/exercise/medicine-ball-lunge-rotation/)
  thumbnail_url: ph("Barbell Bench Press"),
  description: "Classic press building chest and triceps with high load tolerance."
}

exercises << {
  name: "Barbell Incline Bench Press",
  category: "upper_body", unit: "reps",
  movement_pattern: :push, exercise_type: :strength,
  starting_position: :seated, plane_of_motion: :transverse, technical_complexity: :medium,
  primary_muscles: %w[chest], secondary_muscles: %w[front_delts triceps],
  equipment: %w[barbell bench rack], purposes: %w[strength hypertrophy],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Controlled to upper chest; press to full extension.",
  coaching_cues: "Elbows ~45°; set scaps.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-incline-bench/", # page exists [20](https://www.exerciselibrary.com/exercise/medicine-ball-overhead-squat/)
  thumbnail_url: ph("Barbell Incline Bench Press"),
  description: "Upper‑chest emphasis with barbell stability."
}

exercises << {
  name: "Barbell Close Grip Bench Press",
  category: "upper_body", unit: "reps",
  movement_pattern: :push, exercise_type: :strength,
  starting_position: :supine, plane_of_motion: :transverse, technical_complexity: :medium,
  primary_muscles: %w[triceps], secondary_muscles: %w[chest shoulders],
  equipment: %w[barbell bench rack], purposes: %w[strength hypertrophy],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Lower under control; powerful triceps lockout.",
  coaching_cues: "Elbows tucked; wrists stacked.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-close-grip-bench/", # page exists [21](https://www.youtube.com/watch?v=Ut1CvqDdaqA)
  thumbnail_url: ph("Barbell Close Grip Bench Press"),
  description: "Bench variant to build triceps and lockout strength."
}

exercises << {
  name: "Barbell Reverse Grip Bench",
  category: "upper_body", unit: "reps",
  movement_pattern: :push, exercise_type: :hypertrophy,
  starting_position: :supine, plane_of_motion: :transverse, technical_complexity: :medium,
  primary_muscles: %w[chest], secondary_muscles: %w[triceps shoulders],
  equipment: %w[barbell bench rack], purposes: %w[hypertrophy strength],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Lower to lower chest/upper abdomen; smooth press.",
  coaching_cues: "Control wrist angle; keep scaps set.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-reverse-grip-bench/", # page exists [22](https://powerliftingtechnique.com/front-squat/)
  thumbnail_url: ph("Barbell Reverse Grip Bench"),
  description: "Supinated grip variant biasing upper chest/triceps."
}

exercises << {
  name: "Barbell Wide Grip Bench",
  category: "upper_body", unit: "reps",
  movement_pattern: :push, exercise_type: :hypertrophy,
  starting_position: :supine, plane_of_motion: :transverse, technical_complexity: :medium,
  primary_muscles: %w[chest], secondary_muscles: %w[shoulders triceps],
  equipment: %w[barbell bench rack], purposes: %w[hypertrophy],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Wider than shoulder width; controlled to chest.",
  coaching_cues: "Don’t flare excessively; smooth bar path.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-wide-grip-bench/", # page exists [23](https://www.exerciselibrary.com/exercise/barbell-front-squat/)
  thumbnail_url: ph("Barbell Wide Grip Bench"),
  description: "Emphasizes chest through greater horizontal abduction."
}

exercises << {
  name: "Barbell Pin Press",
  category: "upper_body", unit: "reps",
  movement_pattern: :push, exercise_type: :strength,
  starting_position: :supine, plane_of_motion: :transverse, technical_complexity: :medium,
  primary_muscles: %w[chest triceps], secondary_muscles: %w[shoulders],
  equipment: %w[barbell rack bench], purposes: %w[strength technique],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Start from dead stop on pins; press to lockout.",
  coaching_cues: "Eliminate bounce; drive from triceps.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-pin-press/", # page exists [24](https://www.exerciselibrary.com/exercise/medicine-ball-squat/)
  thumbnail_url: ph("Barbell Pin Press"),
  description: "Removes stretch reflex; builds mid‑range and lockout."
}

exercises << {
  name: "Military Press (Standing Barbell OHP)",
  category: "upper_body", unit: "reps",
  movement_pattern: :push, exercise_type: :strength,
  starting_position: :standing, plane_of_motion: :frontal, technical_complexity: :medium,
  primary_muscles: %w[delts triceps], secondary_muscles: %w[traps core],
  equipment: %w[barbell], purposes: %w[strength hypertrophy],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Press overhead with ribs down; head through at lockout.",
  coaching_cues: "Brace; vertical path.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/military-press/", # page exists [3](https://www.exerciselibrary.com/exercise/band-clam-shell/)
  thumbnail_url: ph("Military Press Standing Barbell OHP"),
  description: "Vertical barbell press challenging trunk stability."
}

exercises << {
  name: "Barbell Push Press",
  category: "upper_body", unit: "reps",
  movement_pattern: :push, exercise_type: :power,
  starting_position: :standing, plane_of_motion: :frontal, technical_complexity: :high,
  primary_muscles: %w[delts triceps], secondary_muscles: %w[glutes quads],
  equipment: %w[barbell], purposes: %w[power strength],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Dip‑drive to punch overhead; catch stable.",
  coaching_cues: "Use legs; keep torso tall.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-push-press/", # page exists [25](https://www.exerciselibrary.com/exercise/barbell-hip-thrust/)
  thumbnail_url: ph("Barbell Push Press"),
  description: "Explosive overhead press leveraging leg drive."
}

exercises << {
  name: "EZ‑Bar Shoulder Press",
  category: "upper_body", unit: "reps",
  movement_pattern: :push, exercise_type: :strength,
  starting_position: :standing, plane_of_motion: :frontal, technical_complexity: :medium,
  primary_muscles: %w[delts triceps], secondary_muscles: %w[traps],
  equipment: %w[ez_bar], purposes: %w[strength hypertrophy],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Press to full extension without hyper‑locking.",
  coaching_cues: "Neutral grip; ribs down.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/e-z-bar-shoulder-press/", # page exists [26](https://www.exerciselibrary.com/exercise/knee-banded-bodyweight-hip-thrust/)
  thumbnail_url: ph("EZ‑Bar Shoulder Press"),
  description: "Joint‑friendly overhead press with EZ bar grip."
}

exercises << {
  name: "Cable 2‑Pulley Alternating Shoulder Press",
  category: "upper_body", unit: "reps",
  movement_pattern: :push, exercise_type: :stability,
  starting_position: :standing, plane_of_motion: :frontal, technical_complexity: :medium,
  primary_muscles: %w[delts], secondary_muscles: %w[triceps core],
  equipment: %w[cable], purposes: %w[stability hypertrophy],
  unilateral: true, requires_spotter: false,
  range_of_motion: "Alternate arms; resist rotation.",
  coaching_cues: "Brace; smooth path; no sway.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/cable-2-pulley-alternating-shoulder-press/", # page exists [27](https://www.exerciselibrary.com/exercise/band-duck-walk/)
  thumbnail_url: ph("Cable 2‑Pulley Alternating Shoulder Press"),
  description: "Unilateral cable press with anti‑rotation core demand."
}

exercises << {
  name: "Barbell Snatch‑Grip Shoulder Press",
  category: "upper_body", unit: "reps",
  movement_pattern: :push, exercise_type: :strength,
  starting_position: :standing, plane_of_motion: :frontal, technical_complexity: :high,
  primary_muscles: %w[delts triceps], secondary_muscles: %w[traps upper_back],
  equipment: %w[barbell], purposes: %w[strength mobility],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Wide‑grip press through long ROM.",
  coaching_cues: "Bar close; avoid over‑arching.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-snatch-grip-shoulder-press/", # page exists [28](https://www.healthline.com/health/fitness-exercise/hip-thrusts)
  thumbnail_url: ph("Barbell Snatch‑Grip Shoulder Press"),
  description: "Wide‑grip OHP variation reinforcing overhead mobility and control."
}

# -------------------------
# 21–30 Rows & Pulldowns
# -------------------------

exercises << {
  name: "Barbell Bent‑Over Row",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :hypertrophy,
  starting_position: :standing, plane_of_motion: :transverse, technical_complexity: :medium,
  primary_muscles: %w[lats rhomboids], secondary_muscles: %w[rear_delts biceps erectors],
  equipment: %w[barbell], purposes: %w[hypertrophy strength],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Hinge ~45°; pull to lower ribs; pause at top.",
  coaching_cues: "Brace; bar close; no jerking.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-bent-over-row/", # page exists [4](https://powerliftingtechnique.com/split-squats/)
  thumbnail_url: ph("Barbell Bent‑Over Row"),
  description: "Horizontal pull building back thickness and hinge stability."
}

exercises << {
  name: "Barbell Bent‑Over Row (Wide Grip)",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :hypertrophy,
  starting_position: :standing, plane_of_motion: :transverse, technical_complexity: :medium,
  primary_muscles: %w[upper_back], secondary_muscles: %w[lats rear_delts biceps],
  equipment: %w[barbell], purposes: %w[hypertrophy],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Drive elbows out; pull to upper abdomen.",
  coaching_cues: "Stay braced; avoid shrugging.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-bent-over-row-wide-grip/", # page exists [29](https://www.youtube.com/watch?v=zCsZwLeXrCg)
  thumbnail_url: ph("Barbell Bent‑Over Row (Wide Grip)"),
  description: "Upper‑back focused row with wider grip."
}

exercises << {
  name: "Barbell Bent‑Over Row (Supinated)",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :hypertrophy,
  starting_position: :standing, plane_of_motion: :transverse, technical_complexity: :medium,
  primary_muscles: %w[lats biceps], secondary_muscles: %w[rhomboids rear_delts],
  equipment: %w[barbell], purposes: %w[hypertrophy strength],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Underhand pull to lower ribs; squeeze.",
  coaching_cues: "Keep elbows close; neutral spine.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-bent-over-row-supinated-grip/", # page exists [30](https://www.exerciselibrary.com/exercise/barbell-split-squat/)
  thumbnail_url: ph("Barbell Bent‑Over Row (Supinated)"),
  description: "Supinated grip to bias lats and biceps through longer ROM."
}

exercises << {
  name: "Cable Bent‑Over Row",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :hypertrophy,
  starting_position: :standing, plane_of_motion: :transverse, technical_complexity: :low,
  primary_muscles: %w[mid_back lats], secondary_muscles: %w[rear_delts biceps],
  equipment: %w[cable], purposes: %w[hypertrophy],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Hinged torso; constant cable tension.",
  coaching_cues: "Lead with elbows; smooth return.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/cable-bent-over-row/", # page exists [31](https://www.exerciselibrary.com/exercise/barbell-cluster/)
  thumbnail_url: ph("Cable Bent‑Over Row"),
  description: "Row variant with smoother resistance across ROM."
}

exercises << {
  name: "Band Bent‑Over Row",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :stability,
  starting_position: :standing, plane_of_motion: :transverse, technical_complexity: :low,
  primary_muscles: %w[mid_back lats], secondary_muscles: %w[rear_delts biceps core],
  equipment: %w[band], purposes: %w[stability technique],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Hip hinge; pull band to torso.",
  coaching_cues: "Control both directions; avoid shrug.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/band-bent-over-row/", # page exists [32](https://www.wikihow.com/Do-a-Barbell-Bench-Press)
  thumbnail_url: ph("Band Bent‑Over Row"),
  description: "Portable row with accommodating resistance."
}

exercises << {
  name: "Lat Pulldown (Wide Grip)",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :hypertrophy,
  starting_position: :seated, plane_of_motion: :frontal, technical_complexity: :low,
  primary_muscles: %w[lats], secondary_muscles: %w[biceps rear_delts traps],
  equipment: %w[machine cable], purposes: %w[hypertrophy strength],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Full stretch at top; pull to upper chest.",
  coaching_cues: "Lead with elbows; stay upright.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/lat-pulldown-wide-grip/", # page exists [5](https://stocksnap.io/search/Exercise)
  thumbnail_url: ph("Lat Pulldown (Wide Grip)"),
  description: "Machine vertical pull for back width and control."
}

exercises << {
  name: "Standing Resistance Band Lat Pulldown",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :stability,
  starting_position: :standing, plane_of_motion: :frontal, technical_complexity: :low,
  primary_muscles: %w[lats], secondary_muscles: %w[biceps shoulders core],
  equipment: %w[band], purposes: %w[stability technique],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Arms overhead to ribs; controlled tempo.",
  coaching_cues: "Depress scaps; avoid leaning.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/standing-resistance-band-lat-pulldown/", # page exists [33](https://www.freepik.com/free-photos-vectors/exercise)
  thumbnail_url: ph("Standing Resistance Band Lat Pulldown"),
  description: "Band‑based vertical pull; great for home or warm‑ups."
}

exercises << {
  name: "One‑Arm Lat Pulldown",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :hypertrophy,
  starting_position: :seated, plane_of_motion: :frontal, technical_complexity: :low,
  primary_muscles: %w[lats], secondary_muscles: %w[rear_delts biceps],
  equipment: %w[cable], purposes: %w[hypertrophy stability],
  unilateral: true, requires_spotter: false,
  range_of_motion: "Deep stretch; pull handle to chest/shoulder.",
  coaching_cues: "Don’t twist torso; elbow down/back.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/one-arm-lat-pulldown/", # page exists [34](https://www.pexels.com/search/exercise/)
  thumbnail_url: ph("One‑Arm Lat Pulldown"),
  description: "Unilateral pulldown to improve symmetry and control."
}

exercises << {
  name: "Assisted Chin‑Up Machine",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :stability,
  starting_position: :kneeling, plane_of_motion: :frontal, technical_complexity: :low,
  primary_muscles: %w[lats biceps], secondary_muscles: %w[upper_back core],
  equipment: %w[machine], purposes: %w[stability technique],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Full hang to chin‑over‑bar; controlled return.",
  coaching_cues: "Don’t jerk; set shoulders first.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/assisted-chin-up-machine/", # page exists [35](https://pixabay.com/videos/search/exercise/)
  thumbnail_url: ph("Assisted Chin‑Up Machine"),
  description: "Scalable vertical pull to bridge toward unassisted reps."
}

# -------------------------
# 31–40 Pull power / landmine & high pulls
# -------------------------

exercises << {
  name: "Cable One‑Arm Seated Row",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :stability,
  starting_position: :seated, plane_of_motion: :transverse, technical_complexity: :low,
  primary_muscles: %w[lats mid_back], secondary_muscles: %w[biceps rear_delts],
  equipment: %w[cable], purposes: %w[stability hypertrophy],
  unilateral: true, requires_spotter: false,
  range_of_motion: "Elbow close; squeeze end range.",
  coaching_cues: "No torso twist; slow return.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/cable-one-arm-seated-row/", # page exists [36](https://www.exerciselibrary.com/exercise/cable-one-arm-squat-row/)
  thumbnail_url: ph("Cable One‑Arm Seated Row"),
  description: "Unilateral cable row to correct asymmetries."
}

exercises << {
  name: "Cable One‑Arm High Row",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :stability,
  starting_position: :standing, plane_of_motion: :transverse, technical_complexity: :low,
  primary_muscles: %w[upper_back rear_delts], secondary_muscles: %w[lats biceps],
  equipment: %w[cable], purposes: %w[stability hypertrophy],
  unilateral: true, requires_spotter: false,
  range_of_motion: "Diagonal pull path; elbow leads.",
  coaching_cues: "Keep ribs down; no shrug.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/cable-one-arm-high-row/", # page exists [37](https://www.exerciselibrary.com/exercise/resistance-band-biceps-curl/)
  thumbnail_url: ph("Cable One‑Arm High Row"),
  description: "Targets upper‑back and rear delts with a high pull path."
}

exercises << {
  name: "Cable High Pull",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :power,
  starting_position: :standing, plane_of_motion: :vertical, technical_complexity: :medium,
  primary_muscles: %w[traps], secondary_muscles: %w[delts upper_back biceps],
  equipment: %w[cable], purposes: %w[power hypertrophy],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Explosive pull to chest height; elbows high.",
  coaching_cues: "Bar path close; control lowering.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/cable-high-pull/", # page exists [38](https://www.exerciselibrary.com/exercise/medicine-ball-overhead-lunge/)
  thumbnail_url: ph("Cable High Pull"),
  description: "Vertical pull emphasizing traps with cable tension."
}

exercises << {
  name: "Barbell Snatch‑Grip High Pull",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :power,
  starting_position: :standing, plane_of_motion: :vertical, technical_complexity: :high,
  primary_muscles: %w[traps], secondary_muscles: %w[delts posterior_chain],
  equipment: %w[barbell], purposes: %w[power athletic_performance],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Triple extension then elbows high/wide.",
  coaching_cues: "Pull close; finish tall.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/barbell-snatch-grip-high-pull/", # page exists [39](https://www.exerciselibrary.com/exercise/barbell-pronated-deadlift/)
  thumbnail_url: ph("Barbell Snatch‑Grip High Pull"),
  description: "Explosive pull developing upper‑back power and speed."
}

exercises << {
  name: "Cable Crossover Pulldown",
  category: "upper_body", unit: "reps",
  movement_pattern: :pull, exercise_type: :hypertrophy,
  starting_position: :standing, plane_of_motion: :frontal, technical_complexity: :low,
  primary_muscles: %w[lats], secondary_muscles: %w[upper_back shoulders],
  equipment: %w[cable], purposes: %w[hypertrophy],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Arms mostly straight; pull down to hips.",
  coaching_cues: "Depress scaps; minimize elbow flexion.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/cable-crossover-pulldown/", # page exists [40](https://www.gymshark.com/blog/article/how-to-do-pull-ups)
  thumbnail_url: ph("Cable Crossover Pulldown"),
  description: "Straight‑arm style pulldown isolating lats."
}

# Landmine family
exercises << {
  name: "Landmine Standing Single‑Arm Press",
  category: "upper_body", unit: "reps",
  movement_pattern: :push, exercise_type: :strength,
  starting_position: :standing, plane_of_motion: :multi_plane, technical_complexity: :medium,
  primary_muscles: %w[delts chest], secondary_muscles: %w[triceps core],
  equipment: %w[landmine barbell], purposes: %w[strength stability],
  unilateral: true, requires_spotter: false,
  range_of_motion: "Diagonal arc; ribs down; full extension.",
  coaching_cues: "Stack ribs/pelvis; no lean.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/landmine-standing-single-arm-press/", # page exists [6](https://www.exerciselibrary.com/exercise/barbell-box-squat/)
  thumbnail_url: ph("Landmine Standing Single‑Arm Press"),
  description: "Shoulder‑friendly unilateral pressing with anti‑rotation."
}

exercises << {
  name: "Landmine Squat Press",
  category: "full_body", unit: "reps",
  movement_pattern: :multiplane, exercise_type: :power,
  starting_position: :standing, plane_of_motion: :multi_plane, technical_complexity: :medium,
  primary_muscles: %w[quads delts], secondary_muscles: %w[glutes triceps core],
  equipment: %w[landmine barbell], purposes: %w[power conditioning],
  unilateral: false, requires_spotter: false,
  range_of_motion: "Squat into press; smooth transfer.",
  coaching_cues: "Drive from legs; finish with arms.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/landmine-squat-press/", # page exists [41](https://www.exerciselibrary.com/exercise/barbell-reverse-lunge/)
  thumbnail_url: ph("Landmine Squat Press"),
  description: "Integrated squat‑to‑press for total‑body power."
}




# -------------------------
# 41–50 Core (woodchop/pallof), hip/thigh accessories
# -------------------------

exercises << {
  name: "Cable Horizontal Woodchop",
  category: "core", unit: "reps",
  movement_pattern: :rotation, exercise_type: :stability,
  starting_position: :standing, plane_of_motion: :transverse, technical_complexity: :low,
  primary_muscles: %w[obliques], secondary_muscles: %w[core delts],
  equipment: %w[cable], purposes: %w[stability mobility],
  unilateral: true, requires_spotter: false,
  range_of_motion: "Rotate trunk with hips; arms act as levers.",
  coaching_cues: "Initiate from torso; control the return.",
  contraindications: nil, joint_angles: jhash({}),
  video_url: "https://www.exerciselibrary.com/exercise/cable-horizontal-woodchop/", # page exists [8](https://www.exerciselibrary.com/exercise/resistance-band-deadlift/)
  thumbnail_url: ph("Cable Horizontal Woodchop"),
  description: "Rotational drill developing obliques and deceleration control."
}

puts "[seeds] Creating #{exercises.size} exercises…"
exercises.each { |attrs| create_exercise!(attrs) }
puts "[seeds] Exercises seeded (#{exercises.size})."
