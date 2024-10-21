//Added drop_down controller from https://docs.google.com/document/d/1vEKcUoX_q2g8ZvuA9YYjU4qT4FP-KyYgOEuI7HDABDI/edit?tab=t.0
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
   connect() {
       console.log("Bootstrap dropdown initialized");
   }
}
