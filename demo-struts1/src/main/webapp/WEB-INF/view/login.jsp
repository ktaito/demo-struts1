<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    body {
        background: linear-gradient(135deg, #FFF8F0 0%, #F5E6D3 100%);
    }
    .login-card {
        background: white;
        border: 2px solid #F5E6D3;
        border-radius: 12px;
        box-shadow: 0 8px 24px rgba(255, 140, 66, 0.15);
    }
    .login-header {
        background: linear-gradient(135deg, #FF8C42 0%, #FF6B6B 100%);
        color: white;
        padding: 20px;
        border-radius: 10px 10px 0 0;
    }
    .login-title {
        font-size: 1.8rem;
        font-weight: bold;
        margin: 0;
    }
    .form-control {
        border: 2px solid #F5E6D3;
        border-radius: 8px;
    }
    .form-control:focus {
        border-color: #FF8C42;
        box-shadow: 0 0 0 0.2rem rgba(255, 140, 66, 0.25);
    }
    .btn-login {
        background: linear-gradient(135deg, #FF8C42 0%, #FF6B6B 100%);
        color: white;
        border: none;
        padding: 12px 30px;
        border-radius: 8px;
        font-weight: bold;
        transition: all 0.3s;
    }
    .btn-login:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(255, 140, 66, 0.3);
        color: white;
    }
</style>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-5">
            <div class="card login-card shadow-lg border-0 rounded-lg mt-5">
                <div class="login-header">
                    <h3 class="login-title text-center">タスク管理システム</h3>
                </div>
                <div class="card-body" style="padding: 30px;">
                    <form action="<c:url value='/postLogin.do' />" method="post">
                        <div class="form-floating mb-3">
                            <input name="username" class="form-control" id="inputUsername" type="text" placeholder="Username" />
                            <label for="inputUsername">ユーザー名</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input name="password" class="form-control" id="inputPassword" type="password" placeholder="Password" />
                            <label for="inputPassword">パスワード</label>
                        </div>
                        <div class="d-flex align-items-center justify-content-center mt-4 mb-0">
                            <button type="submit" class="btn btn-login">ログイン</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
