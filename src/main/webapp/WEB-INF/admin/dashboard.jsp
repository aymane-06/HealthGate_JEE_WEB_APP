<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord Admin - Clinique Digitale</title>
    
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
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        * { font-family: 'Inter', sans-serif; }
        @keyframes slideIn {
            from { transform: translateX(-100%); }
            to { transform: translateX(0); }
        }
        .sidebar-animate { animation: slideIn 0.3s ease-out; }
    </style>
</head>
<body class="bg-gray-50">
    <div class="flex h-screen overflow-hidden">
        
        <!-- Sidebar -->
        <aside id="sidebar" class="w-64 bg-gradient-to-b from-primary-900 to-primary-800 text-white flex-shrink-0 hidden md:flex flex-col shadow-2xl">
            <!-- Logo -->
            <div class="p-6 border-b border-primary-700">
                <div class="flex items-center space-x-3">
                    <i class="fas fa-hospital text-3xl text-secondary-400"></i>
                    <div>
                        <h1 class="text-xl font-bold">Clinique</h1>
                        <p class="text-xs text-primary-200">Administration</p>
                    </div>
                </div>
            </div>
            
            <!-- User Profile -->
            <div class="p-6 border-b border-primary-700">
                <div class="flex items-center space-x-3">
                    <div class="w-12 h-12 bg-gradient-to-br from-secondary-500 to-secondary-600 rounded-full flex items-center justify-center text-white font-bold text-lg shadow-lg">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                ${sessionScope.user.firstName.substring(0,1)}${sessionScope.user.lastName.substring(0,1)}
                            </c:when>
                            <c:otherwise>AD</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="font-semibold truncate">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    ${sessionScope.user.firstName} ${sessionScope.user.lastName}
                                </c:when>
                                <c:otherwise>Administrateur</c:otherwise>
                            </c:choose>
                        </p>
                        <p class="text-xs text-primary-200 truncate">
                            <c:choose>
                                <c:when test="${not empty sessionScope.userEmail}">
                                    ${sessionScope.userEmail}
                                </c:when>
                                <c:otherwise>admin@clinique.com</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
            
            <!-- Navigation -->
            <nav class="flex-1 p-4 overflow-y-auto">
                <ul class="space-y-2">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="flex items-center space-x-3 p-3 rounded-lg bg-primary-700/50 text-white">
                            <i class="fas fa-chart-line w-5"></i>
                            <span class="font-medium">Tableau de bord</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/users" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                            <i class="fas fa-users w-5"></i>
                            <span class="font-medium">Utilisateurs</span>
                            <span class="ml-auto bg-red-500 text-white text-xs px-2 py-1 rounded-full">3</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/specialties" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                            <i class="fas fa-stethoscope w-5"></i>
                            <span class="font-medium">Spécialités</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/departments" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                            <i class="fas fa-building w-5"></i>
                            <span class="font-medium">Départements</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/appointments" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                            <i class="fas fa-calendar-alt w-5"></i>
                            <span class="font-medium">Rendez-vous</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/reports" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                            <i class="fas fa-file-medical w-5"></i>
                            <span class="font-medium">Rapports</span>
                        </a>
                    </li>
                </ul>
                
                <div class="mt-6 pt-6 border-t border-primary-700">
                    <ul class="space-y-2">
                        <li>
                            <a href="${pageContext.request.contextPath}/profile" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                                <i class="fas fa-cog w-5"></i>
                                <span class="font-medium">Paramètres</span>
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
        
        <!-- Mobile Sidebar Overlay -->
        <div id="sidebar-overlay" class="fixed inset-0 bg-black/50 z-40 hidden md:hidden"></div>
        
        <!-- Mobile Sidebar -->
        <aside id="mobile-sidebar" class="fixed inset-y-0 left-0 w-64 bg-gradient-to-b from-primary-900 to-primary-800 text-white z-50 transform -translate-x-full transition-transform duration-300 md:hidden shadow-2xl">
            <!-- Same content as desktop sidebar -->
            <div class="p-6 border-b border-primary-700 flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <i class="fas fa-hospital text-3xl text-secondary-400"></i>
                    <div>
                        <h1 class="text-xl font-bold">Clinique</h1>
                        <p class="text-xs text-primary-200">Administration</p>
                    </div>
                </div>
                <button id="close-sidebar" class="text-white hover:text-gray-200">
                    <i class="fas fa-times text-2xl"></i>
                </button>
            </div>
            
            <div class="p-6 border-b border-primary-700">
                <div class="flex items-center space-x-3">
                    <div class="w-12 h-12 bg-gradient-to-br from-secondary-500 to-secondary-600 rounded-full flex items-center justify-center text-white font-bold text-lg shadow-lg">
                        AD
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="font-semibold truncate">Administrateur</p>
                        <p class="text-xs text-primary-200 truncate">admin@clinique.com</p>
                    </div>
                </div>
            </div>
            
            <nav class="flex-1 p-4 overflow-y-auto">
                <ul class="space-y-2">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="flex items-center space-x-3 p-3 rounded-lg bg-primary-700/50 text-white"><i class="fas fa-chart-line w-5"></i><span>Tableau de bord</span></a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/users" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white"><i class="fas fa-users w-5"></i><span>Utilisateurs</span></a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/specialties" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white"><i class="fas fa-stethoscope w-5"></i><span>Spécialités</span></a></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-red-600/80 transition-colors text-primary-100 hover:text-white"><i class="fas fa-sign-out-alt w-5"></i><span>Déconnexion</span></a></li>
                </ul>
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
                            <h2 class="text-2xl font-bold text-gray-900">Tableau de Bord</h2>
                            <p class="text-sm text-gray-500">Vue d'ensemble de la clinique</p>
                        </div>
                    </div>
                    
                    <div class="flex items-center space-x-4">
                        <!-- Search Bar -->
                        <div class="hidden sm:block relative">
                            <input type="text" placeholder="Rechercher..." class="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none">
                            <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                        </div>
                        
                        <!-- Notifications -->
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
                
                <!-- Stats Grid -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                    <!-- Total Users Card -->
                    <div class="bg-white rounded-2xl shadow-sm hover:shadow-lg transition-shadow p-6 border border-gray-100">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-primary-100 p-3 rounded-xl">
                                <i class="fas fa-users text-2xl text-primary-600"></i>
                            </div>
                            <span class="text-green-500 text-sm font-semibold flex items-center">
                                <i class="fas fa-arrow-up mr-1"></i>12%
                            </span>
                        </div>
                        <h3 class="text-3xl font-bold text-gray-900 mb-1">
                            ${not empty stats ? stats.totalUsers : '1,247'}
                        </h3>
                        <p class="text-gray-500 text-sm">Utilisateurs totaux</p>
                    </div>
                    
                    <!-- Doctors Card -->
                    <div class="bg-white rounded-2xl shadow-sm hover:shadow-lg transition-shadow p-6 border border-gray-100">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-secondary-100 p-3 rounded-xl">
                                <i class="fas fa-user-md text-2xl text-secondary-600"></i>
                            </div>
                            <span class="text-green-500 text-sm font-semibold flex items-center">
                                <i class="fas fa-arrow-up mr-1"></i>8%
                            </span>
                        </div>
                        <h3 class="text-3xl font-bold text-gray-900 mb-1">
                            ${not empty stats ? stats.totalDoctors : '48'}
                        </h3>
                        <p class="text-gray-500 text-sm">Médecins actifs</p>
                    </div>
                    
                    <!-- Patients Card -->
                    <div class="bg-white rounded-2xl shadow-sm hover:shadow-lg transition-shadow p-6 border border-gray-100">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-purple-100 p-3 rounded-xl">
                                <i class="fas fa-hospital-user text-2xl text-purple-600"></i>
                            </div>
                            <span class="text-green-500 text-sm font-semibold flex items-center">
                                <i class="fas fa-arrow-up mr-1"></i>15%
                            </span>
                        </div>
                        <h3 class="text-3xl font-bold text-gray-900 mb-1">
                            ${not empty stats ? stats.totalPatients : '892'}
                        </h3>
                        <p class="text-gray-500 text-sm">Patients enregistrés</p>
                    </div>
                    
                    <!-- Today Appointments Card -->
                    <div class="bg-white rounded-2xl shadow-sm hover:shadow-lg transition-shadow p-6 border border-gray-100">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-orange-100 p-3 rounded-xl">
                                <i class="fas fa-calendar-check text-2xl text-orange-600"></i>
                            </div>
                            <span class="text-red-500 text-sm font-semibold flex items-center">
                                <i class="fas fa-arrow-down mr-1"></i>3%
                            </span>
                        </div>
                        <h3 class="text-3xl font-bold text-gray-900 mb-1">
                            ${not empty stats ? stats.todayAppointments : '23'}
                        </h3>
                        <p class="text-gray-500 text-sm">RDV aujourd'hui</p>
                    </div>
                </div>
                
                <!-- Charts Row -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">
                    <!-- Appointments Chart -->
                    <div class="lg:col-span-2 bg-white rounded-2xl shadow-sm p-6 border border-gray-100">
                        <div class="flex items-center justify-between mb-6">
                            <h3 class="text-lg font-bold text-gray-900">Rendez-vous mensuels</h3>
                            <select class="px-4 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none">
                                <option>Cette année</option>
                                <option>Année dernière</option>
                            </select>
                        </div>
                        <canvas id="appointmentsChart" height="80"></canvas>
                    </div>
                    
                    <!-- Status Distribution -->
                    <div class="bg-white rounded-2xl shadow-sm p-6 border border-gray-100">
                        <h3 class="text-lg font-bold text-gray-900 mb-6">Distribution des statuts</h3>
                        <canvas id="statusChart"></canvas>
                        <div class="mt-6 space-y-3">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center">
                                    <div class="w-3 h-3 bg-green-500 rounded-full mr-2"></div>
                                    <span class="text-sm text-gray-600">Confirmé</span>
                                </div>
                                <span class="text-sm font-semibold text-gray-900">45%</span>
                            </div>
                            <div class="flex items-center justify-between">
                                <div class="flex items-center">
                                    <div class="w-3 h-3 bg-yellow-500 rounded-full mr-2"></div>
                                    <span class="text-sm text-gray-600">En attente</span>
                                </div>
                                <span class="text-sm font-semibold text-gray-900">30%</span>
                            </div>
                            <div class="flex items-center justify-between">
                                <div class="flex items-center">
                                    <div class="w-3 h-3 bg-red-500 rounded-full mr-2"></div>
                                    <span class="text-sm text-gray-600">Annulé</span>
                                </div>
                                <span class="text-sm font-semibold text-gray-900">25%</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Activity -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <!-- Recent Users -->
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                        <div class="p-6 border-b border-gray-100">
                            <h3 class="text-lg font-bold text-gray-900">Nouveaux utilisateurs</h3>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Utilisateur</th>
                                        <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Rôle</th>
                                        <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Date</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-100">
                                    <c:choose>
                                        <c:when test="${not empty recentUsers}">
                                            <c:forEach items="${recentUsers}" var="user">
                                                <tr class="hover:bg-gray-50 transition-colors">
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="flex items-center">
                                                            <div class="w-10 h-10 bg-gradient-to-br from-primary-500 to-primary-600 rounded-full flex items-center justify-center text-white font-bold mr-3">
                                                                ${user.firstName.substring(0,1)}${user.lastName.substring(0,1)}
                                                            </div>
                                                            <div>
                                                                <div class="font-medium text-gray-900">${user.firstName} ${user.lastName}</div>
                                                                <div class="text-sm text-gray-500">${user.email}</div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span class="px-3 py-1 text-xs font-semibold rounded-full bg-primary-100 text-primary-700">${user.role}</span>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${user.createdAt}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr class="hover:bg-gray-50 transition-colors">
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <div class="flex items-center">
                                                        <div class="w-10 h-10 bg-gradient-to-br from-primary-500 to-primary-600 rounded-full flex items-center justify-center text-white font-bold mr-3">SM</div>
                                                        <div>
                                                            <div class="font-medium text-gray-900">Sarah Martin</div>
                                                            <div class="text-sm text-gray-500">sarah.m@email.com</div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <span class="px-3 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-700">PATIENT</span>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Il y a 2h</td>
                                            </tr>
                                            <tr class="hover:bg-gray-50 transition-colors">
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <div class="flex items-center">
                                                        <div class="w-10 h-10 bg-gradient-to-br from-secondary-500 to-secondary-600 rounded-full flex items-center justify-center text-white font-bold mr-3">DR</div>
                                                        <div>
                                                            <div class="font-medium text-gray-900">Dr. Robert</div>
                                                            <div class="text-sm text-gray-500">dr.robert@email.com</div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <span class="px-3 py-1 text-xs font-semibold rounded-full bg-purple-100 text-purple-700">DOCTOR</span>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Il y a 5h</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <!-- Recent Appointments -->
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                        <div class="p-6 border-b border-gray-100">
                            <h3 class="text-lg font-bold text-gray-900">Derniers rendez-vous</h3>
                        </div>
                        <div class="p-6 space-y-4">
                            <div class="flex items-start space-x-4 p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition-colors">
                                <div class="w-12 h-12 bg-gradient-to-br from-green-500 to-green-600 rounded-full flex items-center justify-center text-white flex-shrink-0">
                                    <i class="fas fa-check"></i>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="font-semibold text-gray-900">Consultation - Dr. Alami</p>
                                    <p class="text-sm text-gray-600">Patient: Marie Dubois</p>
                                    <p class="text-xs text-gray-500 mt-1">Aujourd'hui 14:30</p>
                                </div>
                                <span class="px-3 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-700">Confirmé</span>
                            </div>
                            
                            <div class="flex items-start space-x-4 p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition-colors">
                                <div class="w-12 h-12 bg-gradient-to-br from-yellow-500 to-yellow-600 rounded-full flex items-center justify-center text-white flex-shrink-0">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="font-semibold text-gray-900">Urgence - Dr. Bennani</p>
                                    <p class="text-sm text-gray-600">Patient: Ahmed Khalil</p>
                                    <p class="text-xs text-gray-500 mt-1">Aujourd'hui 16:00</p>
                                </div>
                                <span class="px-3 py-1 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-700">En attente</span>
                            </div>
                            
                            <div class="flex items-start space-x-4 p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition-colors">
                                <div class="w-12 h-12 bg-gradient-to-br from-primary-500 to-primary-600 rounded-full flex items-center justify-center text-white flex-shrink-0">
                                    <i class="fas fa-calendar"></i>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="font-semibold text-gray-900">Contrôle - Dr. Idrissi</p>
                                    <p class="text-sm text-gray-600">Patient: Fatima Zahra</p>
                                    <p class="text-xs text-gray-500 mt-1">Demain 10:00</p>
                                </div>
                                <span class="px-3 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-700">Prévu</span>
                            </div>
                        </div>
                    </div>
                </div>
                
            </main>
        </div>
    </div>
    
    <script>
        // Mobile menu toggle
        const menuToggle = document.getElementById('menu-toggle');
        const mobileSidebar = document.getElementById('mobile-sidebar');
        const sidebarOverlay = document.getElementById('sidebar-overlay');
        const closeSidebar = document.getElementById('close-sidebar');
        
        menuToggle?.addEventListener('click', () => {
            mobileSidebar.classList.remove('-translate-x-full');
            sidebarOverlay.classList.remove('hidden');
        });
        
        closeSidebar?.addEventListener('click', () => {
            mobileSidebar.classList.add('-translate-x-full');
            sidebarOverlay.classList.add('hidden');
        });
        
        sidebarOverlay?.addEventListener('click', () => {
            mobileSidebar.classList.add('-translate-x-full');
            sidebarOverlay.classList.add('hidden');
        });
        
        // Charts
        const appointmentsCtx = document.getElementById('appointmentsChart');
        if (appointmentsCtx) {
            new Chart(appointmentsCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun', 'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'],
                    datasets: [{
                        label: 'Rendez-vous',
                        data: [65, 78, 90, 81, 96, 105, 134, 142, 165, 178, 192, 210],
                        borderColor: '#0066CC',
                        backgroundColor: 'rgba(0, 102, 204, 0.1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    plugins: {
                        legend: { display: false }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { color: 'rgba(0, 0, 0, 0.05)' }
                        },
                        x: {
                            grid: { display: false }
                        }
                    }
                }
            });
        }
        
        const statusCtx = document.getElementById('statusChart');
        if (statusCtx) {
            new Chart(statusCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Confirmé', 'En attente', 'Annulé'],
                    datasets: [{
                        data: [45, 30, 25],
                        backgroundColor: ['#10b981', '#f59e0b', '#ef4444'],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    plugins: {
                        legend: { display: false }
                    }
                }
            });
        }
    </script>
</body>
</html>
