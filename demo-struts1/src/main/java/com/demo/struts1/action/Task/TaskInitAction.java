package com.demo.struts1.action.Task;

import com.demo.struts1.action.BaseAction;
import com.demo.struts1.util.HibernateUtil;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.hibernate.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TaskInitAction extends BaseAction {

    private static final Logger logger = LoggerFactory.getLogger(TaskInitAction.class);

    @Override
    protected ActionForward performAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

        String actionType = request.getParameter("action");
        
        if ("create".equals(actionType)) {
            // Show initialization form
            return mapping.findForward("success");
        } else {
            // Perform initialization
            Session session = HibernateUtil.getSession();
            try {
                session.beginTransaction();
                
                // Delete all existing tasks
                session.createQuery("DELETE FROM Task").executeUpdate();
                
                // Insert sample data using native SQL
                String insertSQL = "INSERT INTO task (task_title, assignee, category, priority, status) VALUES " +
                    "('プロジェクト提案書を作成', '田中', '仕事', 85, '進行中'), " +
                    "('週次レポートを提出', '佐藤', '仕事', 70, '未着手'), " +
                    "('クライアントミーティング準備', '鈴木', '仕事', 90, '進行中'), " +
                    "('新機能の設計書レビュー', '山田', '仕事', 75, '完了'), " +
                    "('英語の勉強', '田中', '勉強', 50, '未着手'), " +
                    "('ジムに行く', '佐藤', '個人', 40, '未着手'), " +
                    "('食材を買う', '鈴木', '買い物', 60, '未着手'), " +
                    "('部屋の掃除', '山田', '家事', 45, '進行中'), " +
                    "('確定申告の準備', '田中', '個人', 95, '未着手'), " +
                    "('友人の誕生日プレゼント購入', '佐藤', '買い物', 55, '完了'), " +
                    "('車の点検予約', '鈴木', '個人', 65, '未着手'), " +
                    "('読書（ビジネス書）', '山田', '勉強', 35, '進行中'), " +
                    "('洗濯', '田中', '家事', 30, '完了'), " +
                    "('データベース最適化', '佐藤', '仕事', 80, '進行中'), " +
                    "('チームビルディングイベント企画', '鈴木', '仕事', 50, '未着手')";
                
                session.createNativeQuery(insertSQL).executeUpdate();
                
                session.getTransaction().commit();
                logger.info("Task data initialized successfully");
                
                return mapping.findForward("success");
                
            } catch (Exception e) {
                if (session.getTransaction() != null) {
                    session.getTransaction().rollback();
                }
                logger.error("Error initializing task data", e);
                throw e;
            } finally {
                if (session != null && session.isOpen()) {
                    session.close();
                }
            }
        }
    }
}
