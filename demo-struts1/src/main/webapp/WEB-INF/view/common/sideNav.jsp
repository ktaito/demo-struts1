<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .sb-sidenav-dark {
        background: linear-gradient(180deg, #4A3F35 0%, #3A2F25 100%);
    }
    .sb-sidenav-dark .nav-link {
        color: #F5E6D3;
    }
    .sb-sidenav-dark .nav-link:hover {
        background: rgba(255, 140, 66, 0.2);
        color: #FF8C42;
    }
    .sb-sidenav-dark .sb-sidenav-menu-heading {
        color: #FF8C42;
    }
    .sb-sidenav-footer {
        background: #3A2F25;
        color: #F5E6D3;
    }
</style>

<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <div class="sb-sidenav-menu-heading">メニュー</div>

                <a href="<c:url value='/dashboard.do' />" class="nav-link">
                    <div class="sb-nav-link-icon">
                        <i class="fas fa-tachometer-alt"></i>
                    </div>
                    ダッシュボード
                </a>

                <a href="<c:url value='/task-list.do' />" class="nav-link">
                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                    タスク一覧
                </a>

                <a href="<c:url value='/task-pagination.do' />" class="nav-link">
                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                    タスク一覧（ページネーション）
                </a>

            </div>
        </div>
        <div class="sb-sidenav-footer">
            <div class="small">ログイン中:</div>
            <%
                String username = (String) session.getAttribute("loggedInUser");
            %>
             <span>
                 <%= username != null ? username : "Guest" %>
             </span>
        </div>
    </nav>
</div>