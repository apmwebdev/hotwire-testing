import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "actionButton",
    "headerCheckbox",
    "row",
    "rowCheckbox",
  ];
  
  connect() {
    this.updateState();
  }
  
  toggleAll(event) {
    const isChecked = event.target.checked;
    this.rowCheckboxTargets.forEach(checkbox => checkbox.checked = isChecked);
    this.updateValidActionsState();
  }
  
  toggleRow(event) {
    this.updateState();
  }
  
  updateHeaderCheckboxState() {
    const totalRowCount = this.rowCheckboxTargets.length;
    const checkedRowCount = this.selectedCheckboxes.length;
    
    if (checkedRowCount === totalRowCount) {
      this.headerCheckboxTarget.checked = true;
      this.headerCheckboxTarget.indeterminate = false;
    } else if (checkedRowCount > 0) {
      this.headerCheckboxTarget.checked = false;
      this.headerCheckboxTarget.indeterminate = true;
    } else {
      this.headerCheckboxTarget.checked = false;
      this.headerCheckboxTarget.indeterminate = false;
    }
  }
  
  updateState() {
    this.updateHeaderCheckboxState();
    this.updateValidActionsState();
  }
  
  updateValidActionsState() {
    if (this.selectedRows.length === 0) {
      this.actionButtonTargets.forEach(t => t.disabled = true);
      return;
    }
    
    const disabledActionIds = new Set();
    const actionButtonTargetsSet = new Set(this.actionButtonTargets);
    this.selectedRows.forEach(row => {
      const rowDisabledActionIds = JSON.parse(row.dataset.disabledActionIds);
      disabledActionIds.add(...rowDisabledActionIds);
    });
    const disabledActionButtons = new Set([...disabledActionIds].map(id => document.getElementById(id)));
    const enabledActionButtons = actionButtonTargetsSet.difference(disabledActionButtons);
    enabledActionButtons.forEach(button => button.disabled = false);
    disabledActionButtons.forEach(button => {
      if (button == null) return;
      button.disabled = true;
    });
  }
  
  get selectedCheckboxes() {
    return this.rowCheckboxTargets.filter(c => c.checked);
  }
  
  get selectedRows() {
    return (this.selectedCheckboxes
      .map(c => c.closest("[data-table-actions-target=row]"))
    );
  }
}
