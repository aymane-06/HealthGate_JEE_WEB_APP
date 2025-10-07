<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .login-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            width: 100%;
            max-width: 1000px;
            display: flex;
        }
        .login-left {
            flex: 1;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .login-right {
            flex: 1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
        }
        .login-logo {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }
        .login-subtitle {
            color: var(--gray-600);
            margin-bottom: 2rem;
        }
        .illustration {
            width: 100%;
            max-width: 300px;
        }
        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }
            .login-right {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-left">
            <div class="login-logo">Clinique Digitale</div>
            <p class="login-subtitle">Connectez-vous à votre compte</p>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm" data-validate>
                <div class="form-group">
                    <label for="email" class="form-label required">Email</label>
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="votre.email@example.com" required>
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label required">Mot de passe</label>
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="••••••••" required>
                </div>
                
                <div class="form-check mb-3">
                    <input type="checkbox" class="form-check-input" id="remember" name="remember">
                    <label class="form-check-label" for="remember">Se souvenir de moi</label>
                </div>
                
                <button type="submit" class="btn btn-primary btn-block btn-lg">Se connecter</button>
            </form>
            
            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/auth/forgot-password.jsp">Mot de passe oublié ?</a>
            </div>
            
            <div class="text-center mt-3">
                <p>Vous n'avez pas de compte ? 
                    <a href="${pageContext.request.contextPath}/auth/register.jsp">S'inscrire</a>
                </p>
            </div>
        </div>
        
        <div class="login-right">
            <svg class="illustration" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">
                <circle cx="250" cy="250" r="200" fill="rgba(255,255,255,0.1)"/>
                <rect x="150" y="180" width="200" height="140" rx="10" fill="white" opacity="0.9"/>
                <circle cx="250" cy="120" r="40" fill="white" opacity="0.9"/>
                <path d="M 200 350 Q 250 320 300 350" stroke="white" stroke-width="8" fill="none" opacity="0.9"/>
            </svg>
            <h2 class="mt-4">Bienvenue !</h2>
            <p class="text-center">Accédez à votre espace de gestion de santé digitale</p>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
