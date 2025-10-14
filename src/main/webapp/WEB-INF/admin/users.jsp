<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Utilisateurs - Admin</title>
    
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
        
        /* Modal backdrop */
        .modal-backdrop {
            backdrop-filter: blur(8px);
        }
        
        @keyframes slide-in {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        .animate-slide-in {
            animation: slide-in 0.3s ease-out;
        }
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
                            <c:when test="${not empty sessionScope.user && not empty sessionScope.user.name}">
                                ${fn:substring(sessionScope.user.name, 0, 1)}
                            </c:when>
                            <c:otherwise>AD</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="font-semibold truncate">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    ${sessionScope.user.name}
                                </c:when>
                                <c:otherwise>Administrateur</c:otherwise>
                            </c:choose>
                        </p>
                        <p class="text-xs text-primary-200 truncate">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    ${sessionScope.user.email}
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
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                            <i class="fas fa-chart-line w-5"></i>
                            <span class="font-medium">Tableau de bord</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/users" class="flex items-center space-x-3 p-3 rounded-lg bg-primary-700/50 text-white">
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
        
        <!-- Main Content -->
        <div class="flex-1 flex flex-col overflow-hidden">
            
            <!-- Top Bar -->
            <header class="bg-white shadow-sm border-b border-gray-200">
                <div class="flex items-center justify-between p-4">
                    <div>
                        <h2 class="text-2xl font-bold text-gray-900">Gestion des Utilisateurs</h2>
                        <p class="text-sm text-gray-500">Gérez tous les comptes utilisateurs de la clinique</p>
                    </div>
                    <button onclick="openAddUserModal()" class="flex items-center space-x-2 bg-primary-600 hover:bg-primary-700 text-white rounded-lg px-4 py-2 font-semibold transition-colors shadow-lg shadow-primary-600/30">
                        <i class="fas fa-user-plus"></i>
                        <span>Ajouter un utilisateur</span>
                    </button>
                </div>
            </header>
            
            <!-- Main Content Area -->
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
                
                <!-- Stats Cards -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                    <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl shadow-lg p-6 text-white">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-users text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">1247</h3>
                        <p class="text-blue-100">Total Utilisateurs</p>
                    </div>
                    
                    <div class="bg-gradient-to-br from-secondary-500 to-secondary-600 rounded-2xl shadow-lg p-6 text-white">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-user-md text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">48</h3>
                        <p class="text-secondary-100">Médecins</p>
                    </div>
                    
                    <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl shadow-lg p-6 text-white">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-user-injured text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">892</h3>
                        <p class="text-purple-100">Patients</p>
                    </div>
                    
                    <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-2xl shadow-lg p-6 text-white">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-user-tie text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">15</h3>
                        <p class="text-orange-100">Personnel</p>
                    </div>
                </div>
                
                <!-- Filters & Search -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 mb-6">
                    <div class="grid grid-cols-1 md:grid-cols-5 gap-4">
                        <div class="md:col-span-2">
                            <div class="relative">
                                <input type="text" id="searchInput" placeholder="Rechercher par nom, email, rôle..." 
                                       class="w-full pl-12 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-400"></i>
                            </div>
                        </div>
                        <div>
                            <select id="roleFilter" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                <option value="">Tous les rôles</option>
                                <option value="ADMIN">Admin</option>
                                <option value="DOCTOR">Médecin</option>
                                <option value="PATIENT">Patient</option>
                                <option value="STAFF">Personnel</option>
                            </select>
                        </div>
                        <div>
                            <select id="statusFilter" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                <option value="">Tous les statuts</option>
                                <option value="active">Actif</option>
                                <option value="inactive">Inactif</option>
                            </select>
                        </div>
                        <div>
                            <select id="pageSizeSelector" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                <option value="10">10 par page</option>
                                <option value="25">25 par page</option>
                                <option value="50">50 par page</option>
                                <option value="100">100 par page</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <!-- Users Table -->
                <div id="tableContainer" class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden relative">
                    <!-- Loading Overlay -->
                    <div id="loadingOverlay" class="hidden absolute inset-0 bg-white/90 backdrop-blur-sm z-50 flex items-center justify-center">
                        <div class="text-center">
                            <div class="inline-block animate-spin rounded-full h-16 w-16 border-b-4 border-primary-600 mb-4"></div>
                            <p class="text-gray-600 font-semibold text-lg">Chargement des utilisateurs...</p>
                        </div>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">
                                        <input type="checkbox" id="selectAll" class="w-5 h-5 text-primary-600 rounded">
                                    </th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase cursor-pointer hover:bg-gray-100 transition-colors" onclick="userManager.sortBy('name')">
                                        <div class="flex items-center space-x-2">
                                            <span>Utilisateur</span>
                                            <i class="fas fa-sort text-gray-400"></i>
                                        </div>
                                    </th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase cursor-pointer hover:bg-gray-100 transition-colors" onclick="userManager.sortBy('role')">
                                        <div class="flex items-center space-x-2">
                                            <span>Rôle</span>
                                            <i class="fas fa-sort text-gray-400"></i>
                                        </div>
                                    </th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase cursor-pointer hover:bg-gray-100 transition-colors" onclick="userManager.sortBy('email')">
                                        <div class="flex items-center space-x-2">
                                            <span>Email</span>
                                            <i class="fas fa-sort text-gray-400"></i>
                                        </div>
                                    </th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Téléphone</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase cursor-pointer hover:bg-gray-100 transition-colors" onclick="userManager.sortBy('status')">
                                        <div class="flex items-center space-x-2">
                                            <span>Statut</span>
                                            <i class="fas fa-sort text-gray-400"></i>
                                        </div>
                                    </th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Actions</th>
                                </tr>
                            </thead>
                            <tbody id="usersTableBody" class="divide-y divide-gray-100">
                                <!-- Skeleton Loading (shown initially) -->
                                <tr class="skeleton-row">
                                    <td colspan="7" class="px-6 py-4">
                                        <div class="space-y-3">
                                            <div class="h-4 bg-gray-200 rounded animate-pulse"></div>
                                            <div class="h-4 bg-gray-200 rounded animate-pulse w-5/6"></div>
                                            <div class="h-4 bg-gray-200 rounded animate-pulse w-4/6"></div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Pagination -->
                    <div class="border-t border-gray-100 p-6">
                        <div class="flex flex-col sm:flex-row items-center justify-between gap-4">
                            <div class="text-sm text-gray-600" id="paginationInfo">
                                Affichage de <span class="font-semibold">0</span> à <span class="font-semibold">0</span> sur <span class="font-semibold">0</span> utilisateurs
                            </div>
                            <div id="paginationControls" class="flex items-center space-x-2 flex-wrap justify-center">
                                <!-- Pagination buttons will be generated here -->
                            </div>
                        </div>
                    </div>
                </div>
                
            </main>
        </div>
    </div>
    
    <!-- Add/Edit User Modal -->
    <div id="userModal" class="hidden fixed inset-0 z-50 overflow-y-auto modal-backdrop">
        <div class="flex items-center justify-center min-h-screen p-4">
            <div class="fixed inset-0 bg-gray-900/50" onclick="closeUserModal()"></div>
            
            <div class="relative bg-white rounded-2xl shadow-2xl max-w-3xl w-full z-10 max-h-[90vh] overflow-y-auto">
                <!-- Modal Header -->
                <div class="bg-gradient-to-r from-primary-600 to-primary-700 p-6 text-white sticky top-0 z-10">
                    <div class="flex items-center justify-between">
                        <h3 class="text-2xl font-bold" id="modalTitle">Ajouter un utilisateur</h3>
                        <button onclick="closeUserModal()" class="text-white hover:text-gray-200 transition-colors">
                            <i class="fas fa-times text-2xl"></i>
                        </button>
                    </div>
                </div>
                
                <!-- Modal Body -->
                <form id="userForm" action="${pageContext.request.contextPath}/admin/users" method="POST" class="p-6">
                    <input type="hidden" id="userId" name="userId">

                    <div class="space-y-4">
                        <!-- Role Selection -->
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-3">
                                <i class="fas fa-user-tag text-primary-600 mr-2"></i>Rôle <span class="text-red-500">*</span>
                            </label>
                            <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
                                <label class="cursor-pointer">
                                    <input type="radio" name="role" value="PATIENT" class="peer hidden" required>
                                    <div class="p-4 border-2 border-gray-300 rounded-xl text-center peer-checked:border-blue-600 peer-checked:bg-blue-50 transition-all">
                                        <i class="fas fa-user-injured text-3xl text-blue-600 mb-2"></i>
                                        <p class="font-semibold text-sm">Patient</p>
                                    </div>
                                </label>
                                <label class="cursor-pointer">
                                    <input type="radio" name="role" value="DOCTOR" class="peer hidden">
                                    <div class="p-4 border-2 border-gray-300 rounded-xl text-center peer-checked:border-secondary-600 peer-checked:bg-secondary-50 transition-all">
                                        <i class="fas fa-user-md text-3xl text-secondary-600 mb-2"></i>
                                        <p class="font-semibold text-sm">Médecin</p>
                                    </div>
                                </label>
                                <label class="cursor-pointer">
                                    <input type="radio" name="role" value="STAFF" class="peer hidden">
                                    <div class="p-4 border-2 border-gray-300 rounded-xl text-center peer-checked:border-purple-600 peer-checked:bg-purple-50 transition-all">
                                        <i class="fas fa-user-tie text-3xl text-purple-600 mb-2"></i>
                                        <p class="font-semibold text-sm">Personnel</p>
                                    </div>
                                </label>
                                <label class="cursor-pointer">
                                    <input type="radio" name="role" value="ADMIN" class="peer hidden">
                                    <div class="p-4 border-2 border-gray-300 rounded-xl text-center peer-checked:border-orange-600 peer-checked:bg-orange-50 transition-all">
                                        <i class="fas fa-user-shield text-3xl text-orange-600 mb-2"></i>
                                        <p class="font-semibold text-sm">Admin</p>
                                    </div>
                                </label>
                            </div>
                        </div>
                        
                        <!-- Personal Info -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-user text-primary-600 mr-2"></i>Prénom <span class="text-red-500">*</span>
                                </label>
                                <input type="text" name="firstName" required
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-user text-primary-600 mr-2"></i>Nom <span class="text-red-500">*</span>
                                </label>
                                <input type="text" name="lastName" required
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                            </div>
                        </div>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-envelope text-primary-600 mr-2"></i>Email <span class="text-red-500">*</span>
                                </label>
                                <input type="email" name="email" required
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-phone text-primary-600 mr-2"></i>Téléphone
                                </label>
                                <input type="tel" name="phone"
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                            </div>
                        </div>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-key text-primary-600 mr-2"></i>Mot de passe <span class="text-red-500" id="passwordRequired">*</span>
                                </label>
                                <input type="password" name="password" id="password" minlength="8"
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                <p class="text-xs text-gray-500 mt-1">Minimum 8 caractères</p>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-toggle-on text-primary-600 mr-2"></i>Statut
                                </label>
                                <select name="active" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                    <option value="true">Actif</option>
                                    <option value="false">Inactif</option>
                                </select>
                            </div>
                        </div>

                        <!-- PATIENT SPECIFIC FIELDS -->
                        <div id="patientFields" class="hidden space-y-4 mt-6 p-4 bg-blue-50 rounded-lg border-2 border-blue-200">
                            <h4 class="font-bold text-blue-900 flex items-center">
                                <i class="fas fa-user-injured mr-2"></i>Informations Patient
                            </h4>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-id-card text-blue-600 mr-2"></i>CIN <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" name="cin" id="patientCin"
                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                                </div>
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-tint text-blue-600 mr-2"></i>Groupe Sanguin
                                    </label>
                                    <select name="bloodType" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                                        <option value="">Sélectionner</option>
                                        <option value="A+">A+</option>
                                        <option value="A-">A-</option>
                                        <option value="B+">B+</option>
                                        <option value="B-">B-</option>
                                        <option value="AB+">AB+</option>
                                        <option value="AB-">AB-</option>
                                        <option value="O+">O+</option>
                                        <option value="O-">O-</option>
                                    </select>
                                </div>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-calendar text-blue-600 mr-2"></i>Date de Naissance
                                    </label>
                                    <input type="date" name="birthDate"
                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                                </div>
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-venus-mars text-blue-600 mr-2"></i>Sexe
                                    </label>
                                    <select name="gender" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all">
                                        <option value="">Sélectionner</option>
                                        <option value="MALE">Homme</option>
                                        <option value="FEMALE">Femme</option>
                                    </select>
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-map-marker-alt text-blue-600 mr-2"></i>Adresse
                                </label>
                                <textarea name="address" rows="2"
                                          class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"></textarea>
                            </div>
                        </div>

                        <!-- DOCTOR SPECIFIC FIELDS -->
                        <div id="doctorFields" class="hidden space-y-4 mt-6 p-4 bg-secondary-50 rounded-lg border-2 border-secondary-200">
                            <h4 class="font-bold text-secondary-900 flex items-center">
                                <i class="fas fa-user-md mr-2"></i>Informations Médecin
                            </h4>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-id-badge text-secondary-600 mr-2"></i>Matricule <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" name="matricule" id="doctorMatricule"
                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-secondary-500 focus:border-transparent transition-all"
                                           placeholder="DR-2025-XXX">
                                </div>
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-user-graduate text-secondary-600 mr-2"></i>Titre
                                    </label>
                                    <input type="text" name="title"
                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-secondary-500 focus:border-transparent transition-all"
                                           placeholder="Dr., Pr., etc.">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-stethoscope text-secondary-600 mr-2"></i>Spécialité <span class="text-red-500">*</span>
                                </label>
                                <select name="specialtyId" id="doctorSpecialty" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-secondary-500 focus:border-transparent transition-all">
                                    <option value="">Sélectionner une spécialité</option>
                                    <option value="1">Cardiologie</option>
                                    <option value="2">Neurologie</option>
                                    <option value="3">Pédiatrie</option>
                                    <option value="4">Dermatologie</option>
                                    <option value="5">Orthopédie</option>
                                </select>
                            </div>
                        </div>

                        <!-- STAFF SPECIFIC FIELDS -->
                        <div id="staffFields" class="hidden space-y-4 mt-6 p-4 bg-purple-50 rounded-lg border-2 border-purple-200">
                            <h4 class="font-bold text-purple-900 flex items-center">
                                <i class="fas fa-user-tie mr-2"></i>Informations Personnel
                            </h4>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-briefcase text-purple-600 mr-2"></i>Poste <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" name="position" id="staffPosition"
                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all"
                                           placeholder="Secrétaire, Infirmier, etc.">
                                </div>
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-id-card-alt text-purple-600 mr-2"></i>ID Employé <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" name="employeeId" id="staffEmployeeId"
                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all"
                                           placeholder="EMP-2025-XXX">
                                </div>
                            </div>
                        </div>

                        <!-- ADMIN FIELDS (minimal) -->
                        <div id="adminFields" class="hidden mt-6 p-4 bg-orange-50 rounded-lg border-2 border-orange-200">
                            <h4 class="font-bold text-orange-900 flex items-center">
                                <i class="fas fa-user-shield mr-2"></i>Informations Administrateur
                            </h4>
                            <p class="text-sm text-orange-700 mt-2">
                                <i class="fas fa-info-circle mr-1"></i>
                                L'administrateur aura un accès complet au système
                            </p>
                        </div>
                    </div>
                    
                    <!-- Modal Footer -->
                    <div class="flex items-center justify-end space-x-3 mt-8 pt-6 border-t border-gray-200">
                        <button type="button" onclick="closeUserModal()" class="px-6 py-3 border border-gray-300 rounded-lg font-semibold hover:bg-gray-50 transition-colors">
                            Annuler
                        </button>
                        <button type="submit" class="px-6 py-3 bg-primary-600 hover:bg-primary-700 text-white rounded-lg font-semibold transition-colors shadow-lg shadow-primary-600/30">
                            <i class="fas fa-save mr-2"></i>Enregistrer
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        // Modal functions (for the add user modal if it exists)
        function openAddUserModal() {
            const modal = document.getElementById('userModal');
            if (modal) {
                document.getElementById('modalTitle').textContent = 'Ajouter un utilisateur';
                const form = document.getElementById('userForm');
                if (form) form.reset();
                const userId = document.getElementById('userId');
                if (userId) userId.value = '';
                const password = document.getElementById('password');
                if (password) password.required = true;
                const passwordRequired = document.getElementById('passwordRequired');
                if (passwordRequired) passwordRequired.classList.remove('hidden');
                modal.classList.remove('hidden');
            }
        }
        
        function closeUserModal() {
            const modal = document.getElementById('userModal');
            if (modal) modal.classList.add('hidden');
        }
        
        // Global functions that can be called from dynamically generated HTML
        function editUser(userId) {
            if (typeof userManager !== 'undefined') {
                userManager.editUser(userId);
            } else {
                console.log('Edit user:', userId);
            }
        }
        
        function viewUser(userId) {
            if (typeof userManager !== 'undefined') {
                userManager.viewUser(userId);
            } else {
                window.location.href = '${pageContext.request.contextPath}/admin/users/' + userId;
            }
        }

        // ============================================
        // User Management System
        // ============================================
        const userManager = {
            state: {
                currentPage: 1,
                pageSize: 10,
                searchTerm: '',
                roleFilter: '',
                statusFilter: '',
                sortField: '',
                sortOrder: 'asc',
                totalElements: 0,
                totalPages: 0,
                loading: false,
                abortController: null,
                contextPath: '',
                usersCache: [] // Store fetched users here
            },

            init(contextPath) {
                this.state.contextPath = contextPath || '';
                this.bindEventListeners();
                this.loadUsers();
            },

            bindEventListeners() {
                const searchInput = document.getElementById('searchInput');
                if (searchInput) {
                    let searchTimeout;
                    searchInput.addEventListener('input', (e) => {
                        clearTimeout(searchTimeout);
                        searchTimeout = setTimeout(() => {
                            this.state.searchTerm = e.target.value;
                            this.state.currentPage = 1;
                            this.loadUsers();
                        }, 500);
                    });
                }

                const roleFilter = document.getElementById('roleFilter');
                if (roleFilter) {
                    roleFilter.addEventListener('change', (e) => {
                        this.state.roleFilter = e.target.value;
                        this.state.currentPage = 1;
                        this.loadUsers();
                    });
                }

                const statusFilter = document.getElementById('statusFilter');
                if (statusFilter) {
                    statusFilter.addEventListener('change', (e) => {
                        this.state.statusFilter = e.target.value;
                        this.state.currentPage = 1;
                        this.loadUsers();
                    });
                }

                const pageSizeSelector = document.getElementById('pageSizeSelector');
                if (pageSizeSelector) {
                    pageSizeSelector.addEventListener('change', (e) => {
                        this.state.pageSize = parseInt(e.target.value);
                        this.state.currentPage = 1;
                        this.loadUsers();
                    });
                }

                const selectAll = document.getElementById('selectAll');
                if (selectAll) {
                    selectAll.addEventListener('change', (e) => {
                        const checkboxes = document.querySelectorAll('#usersTableBody input[type="checkbox"]');
                        checkboxes.forEach(cb => cb.checked = e.target.checked);
                    });
                }
            },

            async loadUsers() {
                if (this.state.loading && this.state.abortController) {
                    this.state.abortController.abort();
                }

                this.state.loading = true;
                this.state.abortController = new AbortController();
                this.showLoading(true);

                try {
                    const params = new URLSearchParams({
                        page: this.state.currentPage,
                        size: this.state.pageSize
                    });

                    if (this.state.searchTerm) params.append('search', this.state.searchTerm);
                    if (this.state.roleFilter) params.append('role', this.state.roleFilter);
                    if (this.state.statusFilter) params.append('status', this.state.statusFilter);
                    if (this.state.sortField) {
                        params.append('sort', this.state.sortField);
                        params.append('order', this.state.sortOrder);
                    }

                    const url = this.state.contextPath + '/api/admin/users?' + params.toString();
                    const response = await fetch(url, { signal: this.state.abortController.signal });

                    if (!response.ok) throw new Error('Failed to fetch users');

                    const data = await response.json();
                    if (data.status === 'success') {
                        this.state.totalElements = data.data.pagination.totalElements;
                        this.state.totalPages = data.data.pagination.totalPages;
                        this.state.usersCache = data.data.users; // Store users in cache
                        this.renderUsers(data.data.users);
                        this.renderPagination();
                        this.showToast('Utilisateurs chargés avec succès', 'success');
                    } else {
                        throw new Error(data.message || 'Unknown error');
                    }
                } catch (error) {
                    if (error.name === 'AbortError') return;
                    console.error('Error loading users:', error);
                    this.showEmptyState('error', 'Erreur de chargement', 'Impossible de charger les utilisateurs.');
                } finally {
                    this.state.loading = false;
                    this.showLoading(false);
                }
            },

            renderUsers(users) {
                const tbody = document.getElementById('usersTableBody');
                if (!users || users.length === 0) {
                    this.showEmptyState('empty', 'Aucun utilisateur trouvé', 'Aucun utilisateur ne correspond à vos critères.');
                    return;
                }

                tbody.innerHTML = users.map(user => {
                    const userId = this.escapeHtml(user.id);
                    const userName = this.escapeHtml(user.name);
                    const userEmail = this.escapeHtml(user.email);
                    const userPhone = user.phone ? this.escapeHtml(user.phone) : 'N/A';
                    const userInitial = user.name ? this.escapeHtml(user.name.substring(0, 1).toUpperCase()) : 'U';
                    const userIdShort = this.escapeHtml(user.id.substring(0, 8));
                    const statusClass = user.active ? 'bg-green-100 text-green-700 hover:bg-green-200' : 'bg-red-100 text-red-700 hover:bg-red-200';
                    const statusIcon = user.active ? 'fa-check-circle' : 'fa-times-circle';
                    const statusText = user.active ? 'Actif' : 'Inactif';
                    const roleBadge = this.getRoleBadge(user.role);
                    
                    return '<tr class="hover:bg-gray-50 transition-colors">' +
                        '<td class="px-6 py-4"><input type="checkbox" class="w-5 h-5 text-primary-600 rounded" value="' + userId + '"></td>' +
                        '<td class="px-6 py-4 whitespace-nowrap">' +
                            '<div class="flex items-center">' +
                                '<div class="w-10 h-10 bg-gradient-to-br from-primary-500 to-primary-600 rounded-full flex items-center justify-center text-white font-bold text-sm mr-3">' + userInitial + '</div>' +
                                '<div><div class="font-semibold text-gray-900">' + userName + '</div><div class="text-sm text-gray-500">ID: ' + userIdShort + '...</div></div>' +
                            '</div>' +
                        '</td>' +
                        '<td class="px-6 py-4 whitespace-nowrap">' + roleBadge + '</td>' +
                        '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600"><i class="fas fa-envelope text-gray-400 mr-2"></i>' + userEmail + '</td>' +
                        '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600"><i class="fas fa-phone text-gray-400 mr-2"></i>' + userPhone + '</td>' +
                        '<td class="px-6 py-4 whitespace-nowrap">' +
                            '<button data-user-id="' + userId + '" data-user-status="' + user.active + '" class="toggle-status-btn px-3 py-1 text-xs font-bold rounded-full transition-all ' + statusClass + '"><i class="fas ' + statusIcon + ' mr-1"></i>' + statusText + '</button>' +
                        '</td>' +
                        '<td class="px-6 py-4 whitespace-nowrap text-sm space-x-2">' +
                            '<button data-user-id="' + userId + '" class="view-user-btn text-blue-600 hover:text-blue-700 font-semibold transition-colors" title="Voir"><i class="fas fa-eye"></i></button>' +
                            '<button data-user-id="' + userId + '" class="edit-user-btn text-primary-600 hover:text-primary-700 font-semibold transition-colors" title="Modifier"><i class="fas fa-edit"></i></button>' +
                            '<button data-user-id="' + userId + '" data-user-name="' + userName + '" class="delete-user-btn text-red-600 hover:text-red-700 font-semibold transition-colors" title="Supprimer"><i class="fas fa-trash"></i></button>' +
                        '</td></tr>';
                }).join('');

                this.attachRowEventListeners();
            },

            attachRowEventListeners() {
                document.querySelectorAll('.toggle-status-btn').forEach(btn => {
                    btn.addEventListener('click', (e) => {
                        const userId = e.currentTarget.dataset.userId;
                        const currentStatus = e.currentTarget.dataset.userStatus === 'true';
                        this.toggleStatus(userId, currentStatus);
                    });
                });

                document.querySelectorAll('.view-user-btn').forEach(btn => {
                    btn.addEventListener('click', (e) => {
                        this.viewUser(e.currentTarget.dataset.userId);
                    });
                });

                document.querySelectorAll('.edit-user-btn').forEach(btn => {
                    btn.addEventListener('click', (e) => {
                        this.editUser(e.currentTarget.dataset.userId);
                    });
                });

                document.querySelectorAll('.delete-user-btn').forEach(btn => {
                    btn.addEventListener('click', (e) => {
                        this.confirmDelete(e.currentTarget.dataset.userId, e.currentTarget.dataset.userName);
                    });
                });
            },

            renderPagination() {
                const currentPage = this.state.currentPage;
                const pageSize = this.state.pageSize;
                const totalPages = this.state.totalPages;
                const totalElements = this.state.totalElements;
                
                const startIndex = totalElements === 0 ? 0 : (currentPage - 1) * pageSize + 1;
                const endIndex = Math.min(currentPage * pageSize, totalElements);
                
                const paginationInfo = document.getElementById('paginationInfo');
                if (paginationInfo) {
                    paginationInfo.innerHTML = 'Affichage de <span class="font-semibold">' + startIndex + '</span> à <span class="font-semibold">' + endIndex + '</span> sur <span class="font-semibold">' + totalElements + '</span> utilisateurs';
                }

                const controls = document.getElementById('paginationControls');
                if (!controls) return;

                let html = '';
                const firstDisabled = currentPage === 1;
                const lastDisabled = currentPage === totalPages;

                html += '<button data-page="1" class="pagination-btn px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors ' + (firstDisabled ? 'opacity-50 cursor-not-allowed' : '') + '" ' + (firstDisabled ? 'disabled' : '') + '><i class="fas fa-angle-double-left"></i></button>';
                html += '<button data-page="' + (currentPage - 1) + '" class="pagination-btn px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors ' + (firstDisabled ? 'opacity-50 cursor-not-allowed' : '') + '" ' + (firstDisabled ? 'disabled' : '') + '><i class="fas fa-chevron-left"></i></button>';

                const maxButtons = 5;
                let startPage = Math.max(1, currentPage - Math.floor(maxButtons / 2));
                let endPage = Math.min(totalPages, startPage + maxButtons - 1);
                if (endPage - startPage + 1 < maxButtons) startPage = Math.max(1, endPage - maxButtons + 1);

                if (startPage > 1) html += '<span class="px-2 text-gray-400">...</span>';

                for (let i = startPage; i <= endPage; i++) {
                    const isActive = i === currentPage;
                    html += '<button data-page="' + i + '" class="pagination-btn px-4 py-2 rounded-lg font-semibold transition-colors ' + (isActive ? 'bg-primary-600 text-white' : 'border border-gray-300 hover:bg-gray-50') + '">' + i + '</button>';
                }

                if (endPage < totalPages) html += '<span class="px-2 text-gray-400">...</span>';

                html += '<button data-page="' + (currentPage + 1) + '" class="pagination-btn px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors ' + (lastDisabled ? 'opacity-50 cursor-not-allowed' : '') + '" ' + (lastDisabled ? 'disabled' : '') + '><i class="fas fa-chevron-right"></i></button>';
                html += '<button data-page="' + totalPages + '" class="pagination-btn px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors ' + (lastDisabled ? 'opacity-50 cursor-not-allowed' : '') + '" ' + (lastDisabled ? 'disabled' : '') + '><i class="fas fa-angle-double-right"></i></button>';

                controls.innerHTML = html;

                document.querySelectorAll('.pagination-btn').forEach(btn => {
                    btn.addEventListener('click', (e) => {
                        if (!e.currentTarget.disabled) {
                            this.goToPage(parseInt(e.currentTarget.dataset.page));
                        }
                    });
                });
            },

            goToPage(page) {
                if (page < 1 || page > this.state.totalPages) return;
                this.state.currentPage = page;
                this.loadUsers();
            },

            sortBy(field) {
                if (this.state.sortField === field) {
                    this.state.sortOrder = this.state.sortOrder === 'asc' ? 'desc' : 'asc';
                } else {
                    this.state.sortField = field;
                    this.state.sortOrder = 'asc';
                }
                this.loadUsers();
            },

            async toggleStatus(userId, currentStatus) {
                try {
                    const newStatus = currentStatus ? 'INACTIVE' : 'ACTIVE';
                    const response = await fetch(this.state.contextPath + '/api/admin/users/' + userId + '/status', {
                        method: 'PUT',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ status: newStatus })
                    });

                    if (response.ok) {
                        this.showToast('Statut mis à jour avec succès', 'success');
                        this.loadUsers();
                    } else {
                        const data = await response.json();
                        throw new Error(data.message || 'Failed to update status');
                    }
                } catch (error) {
                    this.showToast('Erreur: ' + error.message, 'error');
                }
            },

            viewUser(userId) {
                console.log('View user:', userId);
                this.showToast('Fonction de visualisation à implémenter', 'info');
            },

            editUser(userId) {
                // Find user in cache
                const user = this.state.usersCache.find(u => u.id === userId);
                if (!user) {
                    this.showToast('Utilisateur non trouvé', 'error');
                    return;
                }
                
                // Open modal
                const modal = document.getElementById('userModal');
                if (!modal) {
                    this.showToast('Modal non trouvé', 'error');
                    return;
                }
                
                // Set modal title
                document.getElementById('modalTitle').textContent = 'Modifier l\'utilisateur';
                
                // Set userId in hidden field
                document.getElementById('userId').value = user.id;
                
                // Set role
                const roleInputs = document.querySelectorAll('input[name="role"]');
                roleInputs.forEach(input => {
                    if (input.value === user.role) {
                        input.checked = true;
                        // Trigger change event to show role-specific fields
                        input.dispatchEvent(new Event('change'));
                    }
                });
                
                // Split name into first and last name
                const nameParts = user.name ? user.name.split(' ') : ['', ''];
                const firstNameInput = document.querySelector('input[name="firstName"]');
                const lastNameInput = document.querySelector('input[name="lastName"]');
                if (firstNameInput) firstNameInput.value = nameParts[0] || '';
                if (lastNameInput) lastNameInput.value = nameParts.slice(1).join(' ') || '';
                
                // Set common fields
                const emailInput = document.querySelector('input[name="email"]');
                const phoneInput = document.querySelector('input[name="phone"]');
                const activeSelect = document.querySelector('select[name="active"]');
                
                if (emailInput) emailInput.value = user.email || '';
                if (phoneInput) phoneInput.value = user.phone || '';
                if (activeSelect) activeSelect.value = user.active ? 'true' : 'false';
                
                // Password is optional for editing
                const passwordField = document.getElementById('password');
                if (passwordField) {
                    passwordField.required = false;
                    passwordField.value = '';
                    passwordField.placeholder = 'Laisser vide pour ne pas modifier';
                }
                const passwordRequired = document.getElementById('passwordRequired');
                if (passwordRequired) passwordRequired.classList.add('hidden');
                
                // Set role-specific fields based on user role
                if (user.role === 'PATIENT') {
                    const cinInput = document.querySelector('input[name="cin"]');
                    const bloodTypeSelect = document.querySelector('select[name="bloodType"]');
                    const birthDateInput = document.querySelector('input[name="birthDate"]');
                    const genderSelect = document.querySelector('select[name="gender"]');
                    const addressTextarea = document.querySelector('textarea[name="address"]');
                    
                    if (cinInput) cinInput.value = user.cin || '';
                    if (bloodTypeSelect) bloodTypeSelect.value = user.bloodType || '';
                    if (birthDateInput) birthDateInput.value = user.birthDate || '';
                    if (genderSelect) genderSelect.value = user.gender || '';
                    if (addressTextarea) addressTextarea.value = user.address || '';
                } else if (user.role === 'DOCTOR') {
                    const matriculeInput = document.querySelector('input[name="matricule"]');
                    const titleInput = document.querySelector('input[name="title"]');
                    const specialtySelect = document.querySelector('select[name="specialtyId"]');
                    
                    if (matriculeInput) matriculeInput.value = user.matricule || '';
                    if (titleInput) titleInput.value = user.title || '';
                    if (specialtySelect && user.specialtyId) specialtySelect.value = user.specialtyId;
                } else if (user.role === 'STAFF') {
                    const positionInput = document.querySelector('input[name="position"]');
                    const employeeIdInput = document.querySelector('input[name="employeeId"]');
                    
                    if (positionInput) positionInput.value = user.position || '';
                    if (employeeIdInput) employeeIdInput.value = user.employeeId || '';
                }
                
                // Show modal
                modal.classList.remove('hidden');
            },

            confirmDelete(userId, userName) {
                if (confirm('Êtes-vous sûr de vouloir supprimer l\'utilisateur "' + userName + '" ? Cette action est irréversible.')) {
                    this.deleteUser(userId);
                }
            },

            async deleteUser(userId) {
                try {
                    const response = await fetch(this.state.contextPath + '/api/admin/users/' + userId, {
                        method: 'DELETE'
                    });

                    if (response.ok) {
                        this.showToast('Utilisateur supprimé avec succès', 'success');
                        this.loadUsers();
                    } else {
                        const data = await response.json();
                        throw new Error(data.message || 'Failed to delete user');
                    }
                } catch (error) {
                    this.showToast('Erreur: ' + error.message, 'error');
                }
            },

            showLoading(show) {
                const overlay = document.getElementById('loadingOverlay');
                if (overlay) {
                    if (show) overlay.classList.remove('hidden');
                    else overlay.classList.add('hidden');
                }
            },

            showEmptyState(type, title, message) {
                const tbody = document.getElementById('usersTableBody');
                if (!tbody) return;

                const icon = type === 'error' ? 'fa-exclamation-triangle' : 'fa-users';
                const color = type === 'error' ? 'text-red-600' : 'text-gray-500';
                const retryButton = type === 'error' ? '<button class="retry-load-btn mt-4 px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors">Réessayer</button>' : '';
                
                tbody.innerHTML = '<tr><td colspan="7" class="px-6 py-12 text-center">' +
                    '<div class="flex flex-col items-center space-y-3">' +
                        '<i class="fas ' + icon + ' text-5xl ' + color + '"></i>' +
                        '<h3 class="text-xl font-bold text-gray-900">' + this.escapeHtml(title) + '</h3>' +
                        '<p class="text-gray-600">' + this.escapeHtml(message) + '</p>' +
                        retryButton +
                    '</div></td></tr>';

                const retryBtn = tbody.querySelector('.retry-load-btn');
                if (retryBtn) retryBtn.addEventListener('click', () => this.loadUsers());
            },

            showToast(message, type) {
                if (!type) type = 'success';
                const existing = document.getElementById('toast');
                if (existing) existing.remove();

                const toast = document.createElement('div');
                toast.id = 'toast';
                const colors = { success: 'bg-green-600', error: 'bg-red-600', info: 'bg-blue-600', warning: 'bg-orange-600' };
                const icons = { success: 'fa-check-circle', error: 'fa-times-circle', info: 'fa-info-circle', warning: 'fa-exclamation-triangle' };

                toast.className = 'fixed bottom-6 right-6 z-50 px-6 py-4 rounded-lg shadow-2xl text-white font-semibold flex items-center space-x-3 animate-slide-in ' + colors[type];
                toast.innerHTML = '<i class="fas ' + icons[type] + ' text-xl"></i><span>' + this.escapeHtml(message) + '</span>';

                document.body.appendChild(toast);

                setTimeout(() => {
                    toast.classList.add('opacity-0', 'translate-x-full', 'transition-all');
                    setTimeout(() => toast.remove(), 300);
                }, 3000);
            },

            getRoleBadge(role) {
                const configs = {
                    'ADMIN': { label: 'Admin', icon: 'fa-user-shield', bg: 'bg-orange-100', text: 'text-orange-700' },
                    'DOCTOR': { label: 'Médecin', icon: 'fa-user-md', bg: 'bg-secondary-100', text: 'text-secondary-700' },
                    'PATIENT': { label: 'Patient', icon: 'fa-user-injured', bg: 'bg-blue-100', text: 'text-blue-700' },
                    'STAFF': { label: 'Personnel', icon: 'fa-user-tie', bg: 'bg-purple-100', text: 'text-purple-700' }
                };
                const config = configs[role] || configs['PATIENT'];
                return '<span class="px-3 py-1 text-xs font-bold rounded-full ' + config.bg + ' ' + config.text + '"><i class="fas ' + config.icon + ' mr-1"></i>' + config.label + '</span>';
            },

            escapeHtml(text) {
                const div = document.createElement('div');
                div.textContent = text || '';
                return div.innerHTML;
            }
        };

        // Form submission handler (if form exists)
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('userForm');
            if (form) {
                form.addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    const formData = new FormData(this);
                    
                    fetch("${pageContext.request.contextPath}/admin/users", {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => response.json())
                    .then(data => {
                        console.log('Success:', data);
                        closeUserModal();
                        // Reload users if userManager exists
                        if (typeof userManager !== 'undefined') {
                            userManager.loadUsers();
                        }
                    })
                    .catch((error) => {
                        console.error('Error:', error);
                    });
                });
            }

            // Show/hide specific fields based on role selection (if form exists)
            document.querySelectorAll('input[name="role"]').forEach(function(el) {
                el.addEventListener('change', function() {
                    const role = this.value;
                    const patientFields = document.getElementById('patientFields');
                    const doctorFields = document.getElementById('doctorFields');
                    const staffFields = document.getElementById('staffFields');
                    const adminFields = document.getElementById('adminFields');

                    // Hide all specific fields
                    if (patientFields) patientFields.classList.add('hidden');
                    if (doctorFields) doctorFields.classList.add('hidden');
                    if (staffFields) staffFields.classList.add('hidden');
                    if (adminFields) adminFields.classList.add('hidden');

                    // Show specific fields based on selected role
                    if (role === 'PATIENT' && patientFields) {
                        patientFields.classList.remove('hidden');
                    } else if (role === 'DOCTOR' && doctorFields) {
                        doctorFields.classList.remove('hidden');
                    } else if (role === 'STAFF' && staffFields) {
                        staffFields.classList.remove('hidden');
                    } else if (role === 'ADMIN' && adminFields) {
                        adminFields.classList.remove('hidden');
                    }
                });
            });

            // Initialize user manager
            if (typeof userManager !== 'undefined') {
                userManager.init('${pageContext.request.contextPath}');
            }
        });
    </script>
</body>
</html>

