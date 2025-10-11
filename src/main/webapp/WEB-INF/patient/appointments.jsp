<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Rendez-vous - Clinique Digitale</title>

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#e6f2ff', 100: '#b3d9ff', 200: '#80bfff',
                            300: '#4da6ff', 400: '#1a8cff', 500: '#0073e6',
                            600: '#0066CC', 700: '#0052a3', 800: '#003d7a',
                            900: '#002952',
                        },
                        secondary: {
                            50: '#e6fff9', 100: '#b3ffe9', 200: '#80ffd9',
                            300: '#4dffc9', 400: '#1affb9', 500: '#00e6a0',
                            600: '#00D9A5', 700: '#00a67a', 800: '#007352',
                            900: '#004029',
                        }
                    }
                }
            }
        }
    </script>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <style>
        * { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-gray-50">
    <div class="flex h-screen overflow-hidden">

        <!-- Sidebar -->
        <aside class="w-64 bg-gradient-to-b from-primary-900 to-primary-800 text-white flex-shrink-0 hidden md:flex flex-col shadow-2xl">
            <div class="p-6 border-b border-primary-700">
                <div class="flex items-center space-x-3">
                    <i class="fas fa-hospital text-3xl text-secondary-400"></i>
                    <div>
                        <h1 class="text-xl font-bold">Clinique</h1>
                        <p class="text-xs text-primary-200">Espace Patient</p>
                    </div>
                </div>
            </div>

            <div class="p-6 border-b border-primary-700">
                <div class="flex items-center space-x-3">
                    <div class="w-12 h-12 bg-gradient-to-br from-secondary-500 to-secondary-600 rounded-full flex items-center justify-center text-white font-bold text-lg shadow-lg">
                        ${sessionScope.user.firstName.substring(0,1)}${sessionScope.user.lastName.substring(0,1)}
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="font-semibold truncate">${sessionScope.user.firstName} ${sessionScope.user.lastName}</p>
                        <p class="text-xs text-primary-200 truncate">Patient</p>
                    </div>
                </div>
            </div>

            <nav class="flex-1 p-4 overflow-y-auto">
                <ul class="space-y-2">
                    <li>
                        <a href="${pageContext.request.contextPath}/patient/dashboard" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                            <i class="fas fa-chart-line w-5"></i>
                            <span class="font-medium">Tableau de bord</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/patient/book-appointment" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                            <i class="fas fa-calendar-plus w-5"></i>
                            <span class="font-medium">Prendre RDV</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/patient/appointments" class="flex items-center space-x-3 p-3 rounded-lg bg-primary-700/50 text-white">
                            <i class="fas fa-calendar-alt w-5"></i>
                            <span class="font-medium">Mes Rendez-vous</span>
                            <span class="ml-auto bg-secondary-500 text-white text-xs px-2 py-1 rounded-full">${upcomingCount}</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/patient/history" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                            <i class="fas fa-file-medical w-5"></i>
                            <span class="font-medium">Mon Historique</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/patient/prescriptions" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                            <i class="fas fa-prescription w-5"></i>
                            <span class="font-medium">Mes Ordonnances</span>
                        </a>
                    </li>
                </ul>

                <div class="mt-6 pt-6 border-t border-primary-700">
                    <ul class="space-y-2">
                        <li>
                            <a href="${pageContext.request.contextPath}/profile" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                                <i class="fas fa-user-circle w-5"></i>
                                <span class="font-medium">Mon Profil</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/logout" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-red-600/80 transition-colors text-primary-100 hover:text-white">
                                <i class="fas fa-sign-out-alt w-5"></i>
                                <span class="font-medium">Déconnexion</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </aside>

        <!-- Main Content -->
        <div class="flex-1 flex flex-col overflow-hidden">

            <!-- Top Bar -->
            <header class="bg-white shadow-sm border-b border-gray-200">
                <div class="flex items-center justify-between p-4">
                    <div class="flex items-center space-x-4">
                        <button id="menu-toggle" class="md:hidden text-gray-600 hover:text-gray-900">
                            <i class="fas fa-bars text-2xl"></i>
                        </button>
                        <div>
                            <h2 class="text-2xl font-bold text-gray-900">Mes Rendez-vous 📋</h2>
                            <p class="text-sm text-gray-500">Gérez vos consultations à venir et passées</p>
                        </div>
                    </div>

                    <div class="flex items-center space-x-4">
                        <a href="${pageContext.request.contextPath}/patient/book-appointment" class="hidden sm:flex items-center space-x-2 bg-secondary-600 hover:bg-secondary-700 text-white rounded-lg px-4 py-2 font-semibold transition-colors">
                            <i class="fas fa-calendar-plus"></i>
                            <span>Nouveau RDV</span>
                        </a>
                        <div class="relative">
                            <button class="relative p-2 text-gray-600 hover:text-gray-900 hover:bg-gray-100 rounded-lg transition-colors">
                                <i class="fas fa-bell text-xl"></i>
                                <span class="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
                            </button>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Main Content Area -->
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">

                <c:if test="${not empty error}">
                    <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg">
                        <div class="flex items-start">
                            <i class="fas fa-exclamation-circle text-red-500 mt-0.5 mr-3 text-xl"></i>
                            <div>
                                <p class="font-bold text-red-800">Erreur</p>
                                <p class="text-sm text-red-700">${error}</p>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Stats Cards -->
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-6 mb-6">
                    <div class="bg-gradient-to-br from-secondary-500 to-secondary-600 rounded-2xl shadow-lg p-6 text-white">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-calendar-check text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">${upcomingCount}</h3>
                        <p class="text-secondary-100">RDV à venir</p>
                    </div>

                    <div class="bg-gradient-to-br from-primary-500 to-primary-600 rounded-2xl shadow-lg p-6 text-white">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-history text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">${pastCount}</h3>
                        <p class="text-primary-100">Consultations passées</p>
                    </div>

                    <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl shadow-lg p-6 text-white">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-clock text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">0</h3>
                        <p class="text-purple-100">En attente</p>
                    </div>
                </div>

                <!-- Appointments List -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                    <div class="p-6 border-b border-gray-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <h3 class="text-xl font-bold text-gray-900">Tous les Rendez-vous</h3>
                                <p class="text-sm text-gray-500 mt-1">Vos consultations planifiées et historique</p>
                            </div>
                            <div class="flex space-x-2">
                                <button class="px-4 py-2 bg-primary-600 text-white rounded-lg font-semibold hover:bg-primary-700 transition-colors">
                                    <i class="fas fa-calendar-alt mr-2"></i>
                                    À venir
                                </button>
                                <button class="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg font-semibold hover:bg-gray-300 transition-colors">
                                    <i class="fas fa-history mr-2"></i>
                                    Passés
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="p-6">
                        <c:choose>
                            <c:when test="${empty appointments}">
                                <div class="text-center py-12">
                                    <div class="bg-gray-100 w-24 h-24 rounded-full flex items-center justify-center mx-auto mb-4">
                                        <i class="fas fa-calendar-times text-gray-400 text-5xl"></i>
                                    </div>
                                    <h3 class="text-xl font-bold text-gray-700 mb-2">Aucun rendez-vous</h3>
                                    <p class="text-gray-500 mb-6">Vous n'avez pas encore de rendez-vous planifiés</p>
                                    <a href="${pageContext.request.contextPath}/patient/book-appointment"
                                       class="inline-flex items-center px-6 py-3 bg-secondary-600 text-white rounded-lg font-semibold hover:bg-secondary-700 transition-colors">
                                        <i class="fas fa-calendar-plus mr-2"></i>
                                        Prendre un Rendez-vous
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="space-y-4">
                                    <c:forEach items="${appointments}" var="appointment">
                                        <div class="flex items-start space-x-4 p-4 bg-gradient-to-r from-secondary-50 to-secondary-100 border-l-4 border-secondary-600 rounded-xl hover:shadow-md transition-shadow">
                                            <div class="w-16 h-16 bg-gradient-to-br from-secondary-500 to-secondary-600 rounded-xl flex flex-col items-center justify-center text-white font-bold flex-shrink-0">
                                                <div class="text-2xl">${appointment.day}</div>
                                                <div class="text-xs">${appointment.month}</div>
                                            </div>
                                            <div class="flex-1 min-w-0">
                                                <div class="flex items-center justify-between mb-2">
                                                    <p class="font-bold text-gray-900">${appointment.doctorName}</p>
                                                    <span class="text-xs font-semibold bg-secondary-100 text-secondary-700 px-3 py-1 rounded-full">${appointment.status}</span>
                                                </div>
                                                <p class="text-sm text-gray-600 mb-2">${appointment.type}</p>
                                                <div class="flex items-center space-x-4 text-xs text-gray-500">
                                                    <span><i class="far fa-clock mr-1"></i>${appointment.time}</span>
                                                    <span><i class="fas fa-map-marker-alt mr-1"></i>${appointment.location}</span>
                                                </div>
                                            </div>
                                            <div class="flex flex-col space-y-2">
                                                <button class="px-4 py-2 bg-white border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors text-sm font-semibold">
                                                    Détails
                                                </button>
                                                <button class="px-4 py-2 bg-red-50 border border-red-200 text-red-600 rounded-lg hover:bg-red-100 transition-colors text-sm font-semibold">
                                                    Annuler
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

            </main>
        </div>
    </div>
</body>
</html>

