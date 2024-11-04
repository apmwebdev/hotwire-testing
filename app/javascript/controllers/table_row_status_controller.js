import { Controller } from "@hotwired/stimulus"
import classNames from "classnames";

export default class extends Controller {
  static targets = ["statusColor"];
  
  connect() {
    const postStatus = this.element.dataset.postStatus;
    this.statusColorTarget.classList.add(classNames({
      "table-success": postStatus === "Published",
      "table-warning": postStatus === "Draft",
      "table-secondary": postStatus === "Archived",
    }));
  }
}
