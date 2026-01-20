<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
    .btn-task {
        background: #FF8C42;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 6px;
        transition: all 0.3s;
    }
    .btn-task:hover {
        background: #FF6B6B;
        color: white;
    }
    .datatable-pagination-list-item-link {
        color: #FF8C42 !important;
    }
    .datatable-active .datatable-pagination-list-item-link {
        background: #FF8C42 !important;
        color: white !important;
    }
</style>

<div class="container-fluid px-4 task-container">
    <h1 class="task-title">タスク一覧（ページネーション）</h1>
    
    <div class="card mb-4 mt-4" style="border: 2px solid #F5E6D3;">
        <div class="card-body" style="background: #FFF8F0;">
            <p style="color: #4A3F35; margin: 0;">カスタムページネーションでは、サーバーから1ページ分のデータのみを取得します。大規模なデータセットに適しています。</p>
        </div>
    </div>
    
    <div class="task-card mb-4">
        <div class="task-card-header">
            <i class="fas fa-table me-1"></i>
            タスクリスト（ページネーション）
        </div>
        <div class="card-body">
           <table id="datatablesSimpleCustom" class="task-table">
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
                   <c:forEach var="entity" items="${data}" varStatus="i">
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

           <div class="datatable-bottom">
               <nav class="datatable-pagination">
                    <ul class="datatable-pagination-list">
                        <c:forEach var="page" begin="1" end="${totalPages}" step="1">
                             <c:choose>
                               <c:when test="${page == currentPage}">
                                   <li class="datatable-pagination-list-item datatable-active">
                                       <a data-page="${page}" class="datatable-pagination-list-item-link">${page}</a>
                                   </li>
                               </c:when>
                               <c:otherwise>
                                   <li class="datatable-pagination-list-item">
                                        <a href="task-pagination.do?page=${page}" data-page="${page}" class="datatable-pagination-list-item-link">${page}</a>
                                   </li>
                               </c:otherwise>
                              </c:choose>
                        </c:forEach>
                    </ul>
               </nav>
           </div>
        </div>
    </div>
</div>
