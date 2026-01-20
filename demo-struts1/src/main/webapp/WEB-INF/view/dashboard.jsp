<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>

<style>
    .dashboard-container {
        background: linear-gradient(135deg, #FFF8F0 0%, #F5E6D3 100%);
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(255, 140, 66, 0.1);
    }
    .dashboard-title {
        color: #4A3F35;
        font-size: 2rem;
        font-weight: bold;
        margin-bottom: 30px;
    }
    .dashboard-text {
        color: #4A3F35;
        line-height: 1.8;
        margin-bottom: 20px;
    }
    .task-link {
        display: inline-block;
        background: #FF8C42;
        color: white;
        padding: 12px 24px;
        border-radius: 8px;
        text-decoration: none;
        margin: 10px 10px 10px 0;
        transition: all 0.3s;
    }
    .task-link:hover {
        background: #FF6B6B;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(255, 140, 66, 0.3);
        color: white;
        text-decoration: none;
    }
</style>

<div class="container-fluid px-4">
    <div class="dashboard-container">
        <h1 class="dashboard-title"><bean:write name="dashboardForm" property="title" /></h1>

        <p class="dashboard-text">タスク管理アプリケーションへようこそ。このアプリケーションでは、日々のタスクを効率的に管理できます。</p>
        
        <p class="dashboard-text">以下の機能をご利用いただけます：</p>
        <ul class="dashboard-text">
            <li>タスクの一覧表示</li>
            <li>ページネーション機能</li>
            <li>タスクデータの初期化</li>
        </ul>

        <div style="margin-top: 30px;">
            <a href="task-list.do" class="task-link">📋 タスク一覧</a>
            <a href="task-pagination.do" class="task-link">📄 ページネーション</a>
            <a href="task-init.do?action=create" class="task-link">🔄 データ初期化</a>
        </div>
    </div>
</div>
