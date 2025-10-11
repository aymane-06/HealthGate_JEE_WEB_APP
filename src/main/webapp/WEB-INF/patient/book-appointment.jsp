<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prendre Rendez-vous - Clinique Digitale</title>

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
        .doctor-card { transition: all 0.3s; }
        .doctor-card:hover { transform: translateY(-5px); box-shadow: 0 20px 40px rgba(0,0,0,0.1); }
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
                        <a href="${pageContext.request.contextPath}/patient/book-appointment" class="flex items-center space-x-3 p-3 rounded-lg bg-primary-700/50 text-white">
                            <i class="fas fa-calendar-plus w-5"></i>
                            <span class="font-medium">Prendre RDV</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/patient/appointments" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                            <i class="fas fa-calendar-alt w-5"></i>
                            <span class="font-medium">Mes Rendez-vous</span>
                            <span class="ml-auto bg-secondary-500 text-white text-xs px-2 py-1 rounded-full">2</span>
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
                            <h2 class="text-2xl font-bold text-gray-900">Prendre un Rendez-vous 📅</h2>
                            <p class="text-sm text-gray-500">Sélectionnez un docteur pour planifier votre consultation</p>
                        </div>
                    </div>

                    <div class="flex items-center space-x-4">
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

                <!-- Search and Filter Section -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 mb-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-2">
                                <i class="fas fa-filter text-primary-600 mr-2"></i>Filtrer par spécialité
                            </label>
                            <select class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none"
                                    id="specialtyFilter" onchange="filterDoctors()">
                                <option value="">Toutes les spécialités</option>
                                <c:forEach items="${specialties}" var="specialty">
                                    <option value="${specialty.id}">${specialty.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-2">
                                <i class="fas fa-search text-primary-600 mr-2"></i>Rechercher un docteur
                            </label>
                            <input type="text"
                                   class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none"
                                   id="doctorSearch"
                                   placeholder="Nom du docteur..."
                                   onkeyup="filterDoctors()">
                        </div>
                    </div>
                </div>

                <!-- Doctors List -->
                <div id="doctorsContainer">
                    <c:choose>
                        <c:when test="${empty doctors}">
                            <div class="bg-gradient-to-br from-yellow-50 to-yellow-100 border-2 border-yellow-200 rounded-2xl p-8 text-center">
                                <div class="bg-yellow-200 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="fas fa-info-circle text-yellow-600 text-4xl"></i>
                                </div>
                                <h3 class="text-xl font-bold text-yellow-900 mb-2">Aucun docteur disponible</h3>
                                <p class="text-yellow-700">Veuillez réessayer plus tard ou contacter l'administration</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="doctorsList">
                                <c:forEach items="${doctors}" var="doctor">
                                    <div class="doctor-card bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden"
                                         data-specialty="${doctor.specialty != null ? doctor.specialty.id : ''}"
                                         data-name="${doctor.name}">
                                        <div class="p-6">
                                            <div class="flex items-start mb-4">
                                                <div class="w-16 h-16 bg-gradient-to-br from-primary-500 to-primary-600 rounded-xl flex items-center justify-center text-white font-bold text-2xl shadow-lg mr-4 flex-shrink-0">
                                                    ${doctor.name.substring(0,1).toUpperCase()}
                                                </div>
                                                <div class="flex-1 min-w-0">
                                                    <h3 class="text-lg font-bold text-gray-900 mb-1 truncate">
                                                        <c:if test="${doctor.title != null}">${doctor.title} </c:if>
                                                        ${doctor.name}
                                                    </h3>
                                                    <c:choose>
                                                        <c:when test="${doctor.specialty != null}">
                                                            <div class="inline-flex items-center px-3 py-1 bg-primary-50 text-primary-700 rounded-full text-sm font-semibold">
                                                                <i class="fas fa-stethoscope mr-1"></i>
                                                                ${doctor.specialty.name}
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="inline-flex items-center px-3 py-1 bg-gray-100 text-gray-600 rounded-full text-sm font-semibold">
                                                                <i class="fas fa-user-md mr-1"></i>
                                                                Généraliste
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <div class="space-y-2 mb-4 text-sm text-gray-600">
                                                <div class="flex items-center">
                                                    <i class="fas fa-graduation-cap w-5 text-gray-400"></i>
                                                    <span class="ml-2">15 ans d'expérience</span>
                                                </div>
                                                <div class="flex items-center">
                                                    <i class="fas fa-map-marker-alt w-5 text-gray-400"></i>
                                                    <span class="ml-2">Cabinet principal</span>
                                                </div>
                                                <div class="flex items-center">
                                                    <i class="fas fa-star w-5 text-yellow-400"></i>
                                                    <span class="ml-2 font-semibold">4.8/5 (124 avis)</span>
                                                </div>
                                            </div>

                                            <div class="border-t pt-4">
                                                <a href="${pageContext.request.contextPath}/patient/appointments/new?doctorId=${doctor.id}"
                                                   class="block w-full bg-gradient-to-r from-secondary-500 to-secondary-600 hover:from-secondary-600 hover:to-secondary-700 text-white text-center py-3 rounded-xl font-bold transition-all shadow-md hover:shadow-lg transform hover:scale-105">
                                                    <i class="fas fa-calendar-plus mr-2"></i>
                                                    Prendre Rendez-vous
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Empty state for filtered results -->
                <div id="noResultsMessage" class="hidden bg-white rounded-2xl border-2 border-dashed border-gray-300 p-12 text-center">
                    <div class="bg-gray-100 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4">
                        <i class="fas fa-search text-gray-400 text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-700 mb-2">Aucun docteur trouvé</h3>
                    <p class="text-gray-500">Essayez de modifier vos critères de recherche</p>
                </div>

            </main>
        </div>
    </div>

    <script>
        function filterDoctors() {
            const specialtyId = document.getElementById('specialtyFilter').value;
            const search = document.getElementById('doctorSearch').value.toLowerCase();
            const doctorCards = document.querySelectorAll('.doctor-card');
            let visibleCount = 0;

            doctorCards.forEach(card => {
                const matchesSpecialty = !specialtyId || card.dataset.specialty === specialtyId;
                const matchesSearch = !search || card.dataset.name.toLowerCase().includes(search);
                const isVisible = matchesSpecialty && matchesSearch;

                card.style.display = isVisible ? 'block' : 'none';
                if (isVisible) visibleCount++;
            });

            // Show/hide no results message
            const noResults = document.getElementById('noResultsMessage');
            const doctorsList = document.getElementById('doctorsList');

            if (visibleCount === 0 && doctorCards.length > 0) {
                noResults.classList.remove('hidden');
                if (doctorsList) doctorsList.style.display = 'none';
            } else {
                noResults.classList.add('hidden');
                if (doctorsList) doctorsList.style.display = 'grid';
            }
        }
    </script>
</body>
</html>
