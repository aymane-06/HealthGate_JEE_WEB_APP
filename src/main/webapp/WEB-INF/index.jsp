<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clinique Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .hero-container {
            text-align: center;
            color: white;
            max-width: 800px;
            padding: 2rem;
        }
        .hero-logo {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
        .hero-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        .hero-subtitle {
            font-size: 1.25rem;
            margin-bottom: 3rem;
            opacity: 0.9;
        }
        .hero-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        .hero-btn {
            padding: 1rem 2rem;
            font-size: 1.125rem;
            background: white;
            color: #667eea;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .hero-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
            color: #667eea;
        }
        .hero-btn.secondary {
            background: transparent;
            color: white;
            border: 2px solid white;
        }
        .hero-btn.secondary:hover {
            background: white;
            color: #667eea;
        }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            margin-top: 4rem;
        }
        .feature {
            background: rgba(255,255,255,0.1);
            padding: 1.5rem;
            border-radius: 16px;
            backdrop-filter: blur(10px);
        }
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }
        .feature-title {
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="hero-container">
        <div class="hero-logo">🏥</div>
        <h1 class="hero-title">Clinique Digitale</h1>
        <p class="hero-subtitle">
            Plateforme moderne de gestion médicale pour patients, docteurs et personnel administratif
        </p>
        
        <div class="hero-buttons">
            <a href="${pageContext.request.contextPath}/auth/login.jsp" class="hero-btn">
                Connexion
            </a>
            <a href="${pageContext.request.contextPath}/auth/register.jsp" class="hero-btn secondary">
                S'inscrire
            </a>
        </div>
        
        <div class="features">
            <div class="feature">
                <div class="feature-icon">📅</div>
                <div class="feature-title">Réservation en ligne</div>
                <p>Prenez rendez-vous facilement</p>
            </div>
            <div class="feature">
                <div class="feature-icon">👨‍⚕️</div>
                <div class="feature-title">Suivi médical</div>
                <p>Historique et notes médicales</p>
            </div>
            <div class="feature">
                <div class="feature-icon">⏰</div>
                <div class="feature-title">Gestion horaires</div>
                <p>Disponibilités en temps réel</p>
            </div>
            <div class="feature">
                <div class="feature-icon">🔒</div>
                <div class="feature-title">Sécurisé</div>
                <p>Données protégées et confidentielles</p>
            </div>
        </div>
    </div>
</body>
</html>
