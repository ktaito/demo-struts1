package com.demo.struts1.form;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

import javax.servlet.http.HttpServletRequest;

public class TaskForm extends ActionForm {

    private Long id;
    private String taskTitle;
    private String assignee;
    private String category;
    private Integer priority;
    private String status;
    private String actionType;


    public String getTaskTitle() {
        return taskTitle;
    }

    public void setTaskTitle(String taskTitle) {
        this.taskTitle = taskTitle;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAssignee() {
        return assignee;
    }

    public void setAssignee(String assignee) {
        this.assignee = assignee;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {

        ActionErrors errors = new ActionErrors();
        String priorityInput = request.getParameter("priority");

        if (taskTitle == null || taskTitle.trim().isEmpty()) {
            errors.add("taskTitle", new ActionMessage("error.task.taskTitle.required"));
        }
        if (assignee == null || assignee.trim().isEmpty()) {
            errors.add("assignee", new ActionMessage("error.task.assignee.required"));
        }
        if (category == null || category.trim().isEmpty()) {
            errors.add("category", new ActionMessage("error.task.category.required"));
        }
        if (status == null || status.trim().isEmpty()) {
            errors.add("status", new ActionMessage("error.task.status.required"));
        }
        if (priorityInput == null  || priorityInput.trim().isEmpty()) {
            errors.add("priority", new ActionMessage("error.task.priority.required"));
        } else {
            try {
                priority = Integer.parseInt(priorityInput);
                if (priority <= 0) {
                    errors.add("priority", new ActionMessage("error.task.priority.invalid"));
                }
            } catch (NumberFormatException e) {
                errors.add("priority", new ActionMessage("error.task.priority.invalid"));
            }
        }

        return errors;
    }

}
