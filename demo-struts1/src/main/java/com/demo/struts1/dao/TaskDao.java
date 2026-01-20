package com.demo.struts1.dao;

import com.demo.struts1.form.TaskForm;
import com.demo.struts1.model.Task;
import com.demo.struts1.util.HibernateUtil;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.query.Query;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TaskDao {

    private static final Logger logger = LoggerFactory.getLogger(TaskDao.class);

    public TaskDao() {
    }

    public List<Task> getAll() {

        Session session = HibernateUtil.getSession();
        List<Task> data = null;

        try {

            session.beginTransaction();
            Query<Task> query = session.createQuery("FROM Task", Task.class);
            data = query.list();

        } catch (Exception e) {
            logger.error("Error", e);
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }

        return data;
    }

    public List<Task> findByPaginated(int start, int maxResults) {
        Session session = HibernateUtil.getSession();
        List<Task> data = null;

        try {

            session.beginTransaction();
            Criteria query = session.createCriteria(Task.class);
            query.setFirstResult(start);
            query.setMaxResults(maxResults);

            data = query.list();
            logger.info("Checking : {}", data);

        } catch (Exception e) {
            logger.error("Error", e);
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }

        return data;

    }

    public Long getTotalRecords() {

        Session session = HibernateUtil.getSession();
        Long total = null;

        try {

            session.beginTransaction();
            Criteria query = session.createCriteria(Task.class);
            query.setProjection(Projections.rowCount());

            total = (Long) query.uniqueResult();

        } catch (Exception e) {
            logger.error("Error", e);
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }

        return total;

    }

    public boolean createTask(Task taskData) {
        Session session = HibernateUtil.getSession();
        boolean isSuccess = false;

        try {

            session.beginTransaction();
            session.save(taskData);
            session.getTransaction().commit();

            isSuccess = true;


        } catch (Exception e) {
            if (session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            logger.error("Error creating data", e);
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }

        return isSuccess;
    }

    public boolean updateTask(TaskForm task) {
        Session session = HibernateUtil.getSession();
        boolean isSuccess = false;

        try {
            session.beginTransaction();

            Task existingData = session.get(Task.class, task.getId());

            if (existingData != null) {

                existingData.setTaskTitle(task.getTaskTitle());
                existingData.setAssignee(task.getAssignee());
                existingData.setPriority(task.getPriority());
                existingData.setCategory(task.getCategory());
                existingData.setStatus(task.getStatus());

                session.update(existingData);
                session.getTransaction().commit();

                isSuccess = true;
            } else {
                logger.error("Task with id " + task.getId() + " not found.");
            }
        } catch (Exception e) {
            if (session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            logger.error("Error updating data", e);
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }

        return isSuccess;
    }

    public boolean deleteTask(Long id) {
        Session session = HibernateUtil.getSession();
        boolean isSuccess = false;
        Task data = null;

        try {

            session.beginTransaction();
            data = session.get(Task.class, id);

            if (data != null) {
                session.delete(data);
                session.getTransaction().commit();
                isSuccess = true;
            } else {
                logger.warn("Task with id " + id + " not found.");
            }

        } catch (Exception e) {

            if (session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            logger.error("Error deleting Task", e);
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }

        return isSuccess;
    }

    public Task getById(Long id) {
        Session session = HibernateUtil.getSession();
        Task data = null;
        try {
            session.beginTransaction();

            data = session.get(Task.class, id);

        } catch (Exception e) {
            if (session.getTransaction() != null) {
                session.getTransaction().rollback();
            }

            logger.error("Error get by Id", e);
            e.printStackTrace();
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }

        return data;
    }


}

