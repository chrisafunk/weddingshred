
// app/javascript/controllers/exercise_filter_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["planSelect", "exerciseSelect", "weightInput", "unitHint"]

    connect() {
        // auto-load on connect if a plan is preselected
        if (this.planSelectTarget.value) this.fetchExercises()
    }

    changePlan() { this.fetchExercises() }

    async fetchExercises() {
        const planId = this.planSelectTarget.value
        if (!planId) return
        const res = await fetch(`/month_plans/${planId}/exercises`)
        const exercises = await res.json()
        this.exerciseSelectTarget.innerHTML =
            `<option value=''>Select exercise</option>` +
            exercises.map(e => `<option value='${e.id}'>${e.name}</option>`).join("")
    }

    updateUnit() {
        // Optional: Show unit hint when an exercise selected (requires unit in DOM or data attributes)
        if (this.unitHintTarget) this.unitHintTarget.textContent = ""
    }
}
