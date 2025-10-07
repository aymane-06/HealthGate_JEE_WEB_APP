<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mot de passe oublié - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .forgot-password-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-width: 500px;
            width: 100%;
            padding: 3rem;
            text-align: center;
        }
        .forgot-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="forgot-password-container">
        <div class="forgot-icon">🔐</div>
        <h2>Mot de passe oublié ?</h2>
        <p class="text-muted mb-4">Entrez votre email pour recevoir un lien de réinitialisation</p>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/forgot-password" method="post" data-validate>
            <div class="form-group text-left">
                <label for="email" class="form-label required">Email</label>
                <input type="email" class="form-control" id="email" name="email" 
                       placeholder="votre.email@example.com" required>
            </div>
            
            <button type="submit" class="btn btn-primary btn-block btn-lg">Envoyer le lien</button>
        </form>
        
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/auth/login.jsp">
                ← Retour à la connexion
            </a>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
