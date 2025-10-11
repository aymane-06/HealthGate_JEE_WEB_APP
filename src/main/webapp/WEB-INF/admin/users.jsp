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
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                        <div class="md:col-span-2">
                            <div class="relative">
                                <input type="text" id="search" placeholder="Rechercher par nom, email..." 
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
                    </div>
                </div>
                
                <!-- Users Table -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">
                                        <input type="checkbox" class="w-5 h-5 text-primary-600 rounded">
                                    </th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Utilisateur</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Rôle</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Email</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Téléphone</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Statut</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Créé le</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach items="${users}" var="user">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-6 py-4">
                                        <input type="checkbox" class="w-5 h-5 text-primary-600 rounded">
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="w-10 h-10 bg-gradient-to-br from-primary-500 to-primary-600 rounded-full flex items-center justify-center text-white font-bold text-sm mr-3">
                                                <c:choose>
                                                    <c:when test="${not empty user.name && fn:length(user.name) > 0}">
                                                        ${fn:substring(user.name, 0, 1)}
                                                    </c:when>
                                                    <c:otherwise>U</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <div class="font-semibold text-gray-900">${user.name}</div>
                                                <div class="text-sm text-gray-500">ID: ${user.id}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <c:choose>
                                            <c:when test="${user.role == 'ADMIN'}">
                                                <span class="px-3 py-1 text-xs font-bold rounded-full bg-orange-100 text-orange-700">
                                                    <i class="fas fa-user-shield mr-1"></i>Admin
                                                </span>
                                            </c:when>
                                            <c:when test="${user.role == 'DOCTOR'}">
                                                <span class="px-3 py-1 text-xs font-bold rounded-full bg-secondary-100 text-secondary-700">
                                                    <i class="fas fa-user-md mr-1"></i>Médecin
                                                </span>
                                            </c:when>
                                            <c:when test="${user.role == 'PATIENT'}">
                                                <span class="px-3 py-1 text-xs font-bold rounded-full bg-blue-100 text-blue-700">
                                                    <i class="fas fa-user-injured mr-1"></i>Patient
                                                </span>
                                            </c:when>
                                            <c:when test="${user.role == 'STAFF'}">
                                                <span class="px-3 py-1 text-xs font-bold rounded-full bg-purple-100 text-purple-700">
                                                    <i class="fas fa-user-tie mr-1"></i>Personnel
                                                </span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                        <i class="fas fa-envelope text-gray-400 mr-2"></i>${user.email}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                        <i class="fas fa-phone text-gray-400 mr-2"></i>
                                        <c:choose>
                                            <c:when test="${user.role == 'PATIENT'}">
                                                ${user.phone}
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <c:choose>
                                            <c:when test="${user.active}">
                                                <span class="px-3 py-1 text-xs font-bold rounded-full bg-green-100 text-green-700">
                                                    <i class="fas fa-check-circle mr-1"></i>Actif
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-3 py-1 text-xs font-bold rounded-full bg-red-100 text-red-700">
                                                    <i class="fas fa-times-circle mr-1"></i>Inactif
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                        N/A
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm space-x-2">
                                        <button onclick="viewUser(${user.id})" class="text-blue-600 hover:text-blue-700 font-semibold" title="Voir">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button onclick="editUser(${user.id})" class="text-primary-600 hover:text-primary-700 font-semibold" title="Modifier">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button onclick="toggleUserStatus(${user.id})" class="text-orange-600 hover:text-orange-700 font-semibold" title="Activer/Désactiver">
                                            <i class="fas fa-toggle-on"></i>
                                        </button>
                                        <button onclick="deleteUser(${user.id})" class="text-red-600 hover:text-red-700 font-semibold" title="Supprimer">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Pagination -->
                    <div class="flex items-center justify-between p-6 border-t border-gray-100">
                        <div class="text-sm text-gray-600">
                            Affichage de <span class="font-semibold">1</span> à <span class="font-semibold">20</span> sur <span class="font-semibold">1247</span> utilisateurs
                        </div>
                        <div class="flex items-center space-x-2">
                            <button class="px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors disabled:opacity-50" disabled>
                                <i class="fas fa-chevron-left"></i>
                            </button>
                            <button class="px-4 py-2 bg-primary-600 text-white rounded-lg font-semibold">1</button>
                            <button class="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">2</button>
                            <button class="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">3</button>
                            <span class="px-2">...</span>
                            <button class="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">63</button>
                            <button class="px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">
                                <i class="fas fa-chevron-right"></i>
                            </button>
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
        // Modal functions
        function openAddUserModal() {
            document.getElementById('modalTitle').textContent = 'Ajouter un utilisateur';
            document.getElementById('userForm').reset();
            document.getElementById('userId').value = '';
            document.getElementById('password').required = true;
            document.getElementById('passwordRequired').classList.remove('hidden');
            document.getElementById('userModal').classList.remove('hidden');
        }
        
        function closeUserModal() {
            document.getElementById('userModal').classList.add('hidden');
        }
        
        function editUser(userId) {
            document.getElementById('modalTitle').textContent = 'Modifier l\'utilisateur';
            document.getElementById('userId').value = userId;
            document.getElementById('password').required = false;
            document.getElementById('passwordRequired').classList.add('hidden');
            
            // Fetch user data and populate form (AJAX call here)
            // For demo purposes:
            document.getElementById('userModal').classList.remove('hidden');
        }
        
        function viewUser(userId) {
            window.location.href = '${pageContext.request.contextPath}/admin/users/' + userId;
        }
        
        function toggleUserStatus(userId) {
            if (confirm('Êtes-vous sûr de vouloir changer le statut de cet utilisateur ?')) {
                // AJAX call to toggle status
                console.log('Toggle status for user:', userId);
            }
        }
        
        function deleteUser(userId) {
            if (confirm('Êtes-vous sûr de vouloir supprimer cet utilisateur ? Cette action est irréversible.')) {
                // AJAX call to delete user
                console.log('Delete user:', userId);
            }
        }
        
            let form= document.getElementById('userForm');
        // Form submission
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            showSnackbar("Enregistrement de l'utilisateur...", 'info', true);

            // Create FormData object
            const formData = new FormData(this);

            // Debug: Log what we're sending
            console.log('Form data being sent:');
            for (let pair of formData.entries()) {
                console.log(pair[0] + ': ' + pair[1]);
            }


            fetch("${pageContext.request.contextPath}/admin/users", {
                method: 'POST',
                body: formData
            })
            .then(response => {
                console.log('Response status:', response.status);
                return response.json();
            })
            .then(data => {

                showSnackbar(data.message, 'success');
                console.log('Success:', data);
                closeUserModal();
            })
            .catch((error) => {
                showSnackbar("Erreur lors de l'enregistrement de l'utilisateur.", 'error');
                console.error('Error:', error);
            });
        });

        // Snackbar with loading animation
        function showSnackbar(message, type = 'success', loading = false) {
            const existing = document.getElementById('snackbar');
            if (existing) existing.remove();

            const snackbar = document.createElement('div');
            snackbar.id = 'snackbar';

            // Use string concatenation instead of template literals to avoid JSP EL parsing issues
            let bgColor = 'bg-gray-800';
            if (type === 'success') bgColor = 'bg-green-600';
            else if (type === 'error') bgColor = 'bg-red-600';

            snackbar.className = 'fixed bottom-6 right-6 z-50 px-6 py-4 rounded-lg shadow-lg text-white font-semibold flex items-center space-x-3 transition-all ' + bgColor;

            if (loading) {
                snackbar.innerHTML = '<span class="loader mr-3"></span><span>' + message + '</span>';
            } else {
                let iconClass = 'fa-info-circle';
                if (type === 'success') iconClass = 'fa-check-circle';
                else if (type === 'error') iconClass = 'fa-times-circle';

                snackbar.innerHTML = '<i class="fas ' + iconClass + ' text-xl"></i><span>' + message + '</span>';
            }

            document.body.appendChild(snackbar);

            if (!loading) {
                setTimeout(() => {
                    snackbar.classList.add('opacity-0', 'pointer-events-none');
                    setTimeout(() => snackbar.remove(), 500);
                }, 3000);
            }
        }

        // Loader CSS
        const style = document.createElement('style');
        style.innerHTML = `
.loader {
  border: 3px solid #fff3;
  border-top: 3px solid #fff;
  border-radius: 50%;
  width: 22px;
  height: 22px;
  animation: spin 1s linear infinite;
  display: inline-block;
}
@keyframes spin {
  0% { transform: rotate(0deg);}
  100% { transform: rotate(360deg);}
}
`;
        document.head.appendChild(style);

        // Search and filters
        document.getElementById('search').addEventListener('input', function() {
            // Implement search logic
            console.log('Search:', this.value);
        });
        
        document.getElementById('roleFilter').addEventListener('change', function() {
            // Implement role filter logic
            console.log('Filter by role:', this.value);
        });
        
        document.getElementById('statusFilter').addEventListener('change', function() {
            // Implement status filter logic
            console.log('Filter by status:', this.value);
        });

        // Show/hide specific fields based on role selection
        document.querySelectorAll('input[name="role"]').forEach(function(el) {
            el.addEventListener('change', function() {
                const role = this.value;

                // Hide all specific fields
                document.getElementById('patientFields').classList.add('hidden');
                document.getElementById('doctorFields').classList.add('hidden');
                document.getElementById('staffFields').classList.add('hidden');
                document.getElementById('adminFields').classList.add('hidden');

                // Show specific fields based on selected role
                if (role === 'PATIENT') {
                    document.getElementById('patientFields').classList.remove('hidden');
                } else if (role === 'DOCTOR') {
                    document.getElementById('doctorFields').classList.remove('hidden');
                } else if (role === 'STAFF') {
                    document.getElementById('staffFields').classList.remove('hidden');
                } else if (role === 'ADMIN') {
                    document.getElementById('adminFields').classList.remove('hidden');
                }
            });
        });
    </script>
</body>
</html>
