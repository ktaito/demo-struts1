package com.demo.struts1.action.Task;

import com.demo.struts1.action.BaseAction;
import com.demo.struts1.dao.TaskDao;
import com.demo.struts1.model.Task;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class TaskListPaginationAction extends BaseAction {

    private static final int PAGE_SIZE = 10;

    @Override
    protected ActionForward performAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

        TaskDao taskDao = new TaskDao();
        String pageParam = request.getParameter("page");
        int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
        int start = (currentPage - 1) * PAGE_SIZE;

        List<Task> data = taskDao.findByPaginated(start, PAGE_SIZE);
        long totalRecords = taskDao.getTotalRecords();
        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

        request.setAttribute("data", data);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        return mapping.findForward("success");
    }

}
