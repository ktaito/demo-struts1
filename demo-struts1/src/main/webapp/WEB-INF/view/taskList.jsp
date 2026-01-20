<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>

<style>
    .task-container {
        background: #FFF8F0;
        padding: 20px;
        border-radius: 8px;
    }
    .task-title {
        color: #4A3F35;
        font-size: 1.8rem;
        font-weight: bold;
        margin-bottom: 20px;
    }
    .task-card {
        background: white;
        border: 2px solid #F5E6D3;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(255, 140, 66, 0.1);
    }
    .task-card-header {
        background: linear-gradient(135deg, #FF8C42 0%, #FF6B6B 100%);
        color: white;
        padding: 15px;
        border-radius: 6px 6px 0 0;
        font-weight: bold;
    }
    .task-table {
        width: 100%;
        margin: 0;
    }
    .task-table thead {
        background: #F5E6D3;
        color: #4A3F35;
    }
    .task-table th {
        padding: 12px;
        font-weight: bold;
    }
    .task-table td {
        padding: 10px;
        border-bottom: 1px solid #F5E6D3;
        color: #4A3F35;
    }
    .task-table tbody tr:hover {
        background: #FFF8F0;
    }
</style>

<div class="container-fluid px-4 task-container">
    <h1 class="task-title">タスク一覧</h1>

    <div class="card mb-4 mt-4" style="border: 2px solid #F5E6D3;">
        <div class="card-body" style="background: #FFF8F0;">
            <p style="color: #4A3F35; margin: 0;">全てのタスクを一度に取得し、クライアント側でページネーションを行います。小規模なデータセットに適しています。</p>
        </div>
    </div>

    <div class="task-card mb-4">
        <div class="task-card-header">
            <i class="fas fa-table me-1"></i>
            タスクリスト
        </div>
        <div class="card-body">
            <table id="datatablesSimple" class="task-table">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>タスク名</th>
                        <th>担当者</th>
                        <th>カテゴリ</th>
                        <th>優先度</th>
                        <th>ステータス</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="entity" items="${results}" varStatus="i">
                        <tr>
                            <td>${i.index+1}</td>
                            <td>${entity.taskTitle}</td>
                            <td>${entity.assignee}</td>
                            <td>${entity.category}</td>
                            <td>${entity.priority}</td>
                            <td>${entity.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
