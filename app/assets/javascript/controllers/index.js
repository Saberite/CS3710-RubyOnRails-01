// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
//eagerLoadControllersFrom("controllers", application) // Not needed

application.register("dropdown", DropdownController); // Register the controller with Stimulus. From https://docs.google.com/document/d/1vEKcUoX_q2g8ZvuA9YYjU4qT4FP-KyYgOEuI7HDABDI/edit?tab=t.0