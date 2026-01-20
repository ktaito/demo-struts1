package com.demo.struts1.action.Task;

import com.demo.struts1.action.BaseAction;
import com.demo.struts1.dao.TaskDao;
import com.demo.struts1.model.Task;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;


public class TaskListAction extends BaseAction {

    @Override
    protected ActionForward performAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

        TaskDao taskDao = new TaskDao();
        List<Task> results = taskDao.getAll();

        String dynamicTitle = "Task List";
        request.setAttribute("pageTitle", dynamicTitle);
        request.setAttribute("results", results);
        return mapping.findForward("success");

    }

}
