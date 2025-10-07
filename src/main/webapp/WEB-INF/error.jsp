<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${errorCode} - ${errorTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #0066CC 0%, #00A3E0 50%, #00D9A5 100%);
        }
        
        .error-container {
            text-align: center;
            color: white;
            max-width: 600px;
            padding: 3rem 2rem;
        }
        
        .error-code {
            font-size: 8rem;
            font-weight: 800;
            line-height: 1;
            margin-bottom: 1rem;
            text-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            animation: bounce 2s ease-in-out infinite;
        }
        
        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-20px);
            }
        }
        
        .error-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }
        
        .error-message {
            font-size: 1.25rem;
            margin-bottom: 3rem;
            opacity: 0.95;
            line-height: 1.6;
        }
        
        .error-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .error-btn {
            padding: 1rem 2rem;
            font-size: 1rem;
            background: white;
            color: #0066CC;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 700;
            transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        
        .error-btn:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
        }
        
        .error-btn.secondary {
            background: transparent;
            color: white;
            border: 3px solid white;
        }
        
        .error-btn.secondary:hover {
            background: white;
            color: #0066CC;
        }
        
        .error-icon {
            font-size: 5rem;
            margin-bottom: 2rem;
            filter: drop-shadow(0 10px 20px rgba(0, 0, 0, 0.2));
        }
    </style>
</head>
<body>
    <div class="error-container">
        <c:choose>
            <c:when test="${errorCode == '403'}">
                <div class="error-icon">🚫</div>
            </c:when>
            <c:when test="${errorCode == '404'}">
                <div class="error-icon">🔍</div>
            </c:when>
            <c:otherwise>
                <div class="error-icon">⚠️</div>
            </c:otherwise>
        </c:choose>
        
        <div class="error-code">${errorCode}</div>
        <h1 class="error-title">${errorTitle}</h1>
        <p class="error-message">${errorMessage}</p>
        
        <div class="error-actions">
            <a href="javascript:history.back()" class="error-btn secondary">
                ← Retour
            </a>
            <a href="${pageContext.request.contextPath}/" class="error-btn">
                🏠 Accueil
            </a>
        </div>
    </div>
</body>
</html>
