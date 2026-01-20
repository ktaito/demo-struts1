<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .init-container {
        background: linear-gradient(135deg, #FFF8F0 0%, #F5E6D3 100%);
        padding: 60px 20px;
        border-radius: 12px;
        text-align: center;
        box-shadow: 0 4px 12px rgba(255, 140, 66, 0.15);
        margin: 40px auto;
        max-width: 600px;
    }
    .init-title {
        color: #4A3F35;
        font-size: 2rem;
        font-weight: bold;
        margin-bottom: 20px;
    }
    .init-text {
        color: #4A3F35;
        font-size: 1.1rem;
        line-height: 1.8;
        margin-bottom: 30px;
    }
    .init-button {
        background: linear-gradient(135deg, #FF8C42 0%, #FF6B6B 100%);
        color: white;
        border: none;
        padding: 15px 40px;
        font-size: 1.1rem;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s;
        box-shadow: 0 4px 12px rgba(255, 140, 66, 0.3);
    }
    .init-button:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 16px rgba(255, 140, 66, 0.4);
    }
    .back-link {
        display: inline-block;
        margin-top: 20px;
        color: #FF8C42;
        text-decoration: none;
        font-weight: bold;
    }
    .back-link:hover {
        color: #FF6B6B;
    }
</style>

<div class="container-fluid px-4">
    <div class="init-container">
        <h1 class="init-title">🔄 タスクデータ初期化</h1>
        
        <p class="init-text">
            この操作により、既存のタスクデータが削除され、<br>
            サンプルタスクデータ（15件）が再作成されます。
        </p>
        
        <p class="init-text" style="font-size: 0.95rem; color: #FF6B6B;">
            ⚠️ この操作は取り消せません
        </p>
        
        <form action="<c:url value='/task-init.do' />" method="post" onsubmit="return confirm('本当にデータを初期化しますか？');">
            <button type="submit" class="init-button">
                データを初期化する
            </button>
        </form>
        
        <a href="task-pagination.do" class="back-link">← タスク一覧に戻る</a>
    </div>
</div>
