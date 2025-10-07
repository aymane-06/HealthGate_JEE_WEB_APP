<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Spécialités - Admin</title>
    
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
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
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
                        <a href="${pageContext.request.contextPath}/admin/specialties" class="flex items-center space-x-3 p-3 rounded-lg bg-primary-700/50 text-white">
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
                        <h2 class="text-2xl font-bold text-gray-900">Gestion des Spécialités Médicales</h2>
                        <p class="text-sm text-gray-500">Gérez les spécialités médicales disponibles dans la clinique</p>
                    </div>
                    <div class="flex items-center space-x-3">
                        <button onclick="toggleView()" id="viewToggle" class="px-4 py-2 border border-gray-300 rounded-lg font-semibold hover:bg-gray-50 transition-colors">
                            <i class="fas fa-th-list mr-2"></i>
                            <span id="viewText">Vue liste</span>
                        </button>
                        <button onclick="openAddSpecialtyModal()" class="flex items-center space-x-2 bg-primary-600 hover:bg-primary-700 text-white rounded-lg px-4 py-2 font-semibold transition-colors shadow-lg shadow-primary-600/30">
                            <i class="fas fa-plus"></i>
                            <span>Ajouter une spécialité</span>
                        </button>
                    </div>
                </div>
            </header>
            
            <!-- Main Content Area -->
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
                
                <!-- Stats -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                    <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl shadow-lg p-6 text-white">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-heartbeat text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">12</h3>
                        <p class="text-blue-100">Total Spécialités</p>
                    </div>
                    
                    <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-2xl shadow-lg p-6 text-white">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-user-md text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">48</h3>
                        <p class="text-green-100">Médecins Actifs</p>
                    </div>
                    
                    <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl shadow-lg p-6 text-white">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-star text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">Cardio</h3>
                        <p class="text-purple-100">Plus populaire</p>
                    </div>
                    
                    <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-2xl shadow-lg p-6 text-white">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-calendar-check text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">342</h3>
                        <p class="text-orange-100">RDV ce mois</p>
                    </div>
                </div>
                
                <!-- Search -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 mb-6">
                    <div class="relative">
                        <input type="text" id="searchSpecialty" placeholder="Rechercher une spécialité..." 
                               class="w-full pl-12 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                        <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    </div>
                </div>
                
                <!-- Card View (Default) -->
                <div id="cardView" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    
                    <!-- Specialty Card 1 -->
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-lg transition-all transform hover:-translate-y-1">
                        <div class="bg-gradient-to-br from-red-500 to-red-600 p-6 text-white">
                            <div class="flex items-center justify-between">
                                <div class="w-16 h-16 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">
                                    <i class="fas fa-heartbeat text-3xl"></i>
                                </div>
                                <div class="text-right">
                                    <p class="text-4xl font-bold">8</p>
                                    <p class="text-red-100 text-sm">Médecins</p>
                                </div>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-xl font-bold text-gray-900 mb-2">Cardiologie</h3>
                            <p class="text-sm text-gray-600 mb-4">Spécialité médicale qui s'intéresse au cœur et aux vaisseaux sanguins.</p>
                            <div class="flex items-center justify-between text-sm text-gray-500 mb-4">
                                <span><i class="fas fa-calendar-alt mr-2 text-primary-600"></i>125 RDV/mois</span>
                                <span><i class="fas fa-star mr-2 text-yellow-500"></i>4.8/5</span>
                            </div>
                            <div class="flex items-center space-x-2">
                                <button onclick="viewSpecialty(1)" class="flex-1 px-4 py-2 bg-primary-50 text-primary-600 rounded-lg font-semibold hover:bg-primary-100 transition-colors">
                                    <i class="fas fa-eye mr-2"></i>Voir
                                </button>
                                <button onclick="editSpecialty(1)" class="px-4 py-2 bg-blue-50 text-blue-600 rounded-lg font-semibold hover:bg-blue-100 transition-colors">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button onclick="deleteSpecialty(1)" class="px-4 py-2 bg-red-50 text-red-600 rounded-lg font-semibold hover:bg-red-100 transition-colors">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Specialty Card 2 -->
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-lg transition-all transform hover:-translate-y-1">
                        <div class="bg-gradient-to-br from-purple-500 to-purple-600 p-6 text-white">
                            <div class="flex items-center justify-between">
                                <div class="w-16 h-16 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">
                                    <i class="fas fa-brain text-3xl"></i>
                                </div>
                                <div class="text-right">
                                    <p class="text-4xl font-bold">5</p>
                                    <p class="text-purple-100 text-sm">Médecins</p>
                                </div>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-xl font-bold text-gray-900 mb-2">Neurologie</h3>
                            <p class="text-sm text-gray-600 mb-4">Spécialité qui traite les maladies du système nerveux.</p>
                            <div class="flex items-center justify-between text-sm text-gray-500 mb-4">
                                <span><i class="fas fa-calendar-alt mr-2 text-primary-600"></i>87 RDV/mois</span>
                                <span><i class="fas fa-star mr-2 text-yellow-500"></i>4.9/5</span>
                            </div>
                            <div class="flex items-center space-x-2">
                                <button onclick="viewSpecialty(2)" class="flex-1 px-4 py-2 bg-primary-50 text-primary-600 rounded-lg font-semibold hover:bg-primary-100 transition-colors">
                                    <i class="fas fa-eye mr-2"></i>Voir
                                </button>
                                <button onclick="editSpecialty(2)" class="px-4 py-2 bg-blue-50 text-blue-600 rounded-lg font-semibold hover:bg-blue-100 transition-colors">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button onclick="deleteSpecialty(2)" class="px-4 py-2 bg-red-50 text-red-600 rounded-lg font-semibold hover:bg-red-100 transition-colors">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Specialty Card 3 -->
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-lg transition-all transform hover:-translate-y-1">
                        <div class="bg-gradient-to-br from-blue-500 to-blue-600 p-6 text-white">
                            <div class="flex items-center justify-between">
                                <div class="w-16 h-16 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">
                                    <i class="fas fa-bone text-3xl"></i>
                                </div>
                                <div class="text-right">
                                    <p class="text-4xl font-bold">6</p>
                                    <p class="text-blue-100 text-sm">Médecins</p>
                                </div>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-xl font-bold text-gray-900 mb-2">Orthopédie</h3>
                            <p class="text-sm text-gray-600 mb-4">Spécialité chirurgicale qui traite les maladies de l'appareil locomoteur.</p>
                            <div class="flex items-center justify-between text-sm text-gray-500 mb-4">
                                <span><i class="fas fa-calendar-alt mr-2 text-primary-600"></i>93 RDV/mois</span>
                                <span><i class="fas fa-star mr-2 text-yellow-500"></i>4.7/5</span>
                            </div>
                            <div class="flex items-center space-x-2">
                                <button onclick="viewSpecialty(3)" class="flex-1 px-4 py-2 bg-primary-50 text-primary-600 rounded-lg font-semibold hover:bg-primary-100 transition-colors">
                                    <i class="fas fa-eye mr-2"></i>Voir
                                </button>
                                <button onclick="editSpecialty(3)" class="px-4 py-2 bg-blue-50 text-blue-600 rounded-lg font-semibold hover:bg-blue-100 transition-colors">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button onclick="deleteSpecialty(3)" class="px-4 py-2 bg-red-50 text-red-600 rounded-lg font-semibold hover:bg-red-100 transition-colors">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Specialty Card 4 -->
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-lg transition-all transform hover:-translate-y-1">
                        <div class="bg-gradient-to-br from-pink-500 to-pink-600 p-6 text-white">
                            <div class="flex items-center justify-between">
                                <div class="w-16 h-16 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">
                                    <i class="fas fa-baby text-3xl"></i>
                                </div>
                                <div class="text-right">
                                    <p class="text-4xl font-bold">7</p>
                                    <p class="text-pink-100 text-sm">Médecins</p>
                                </div>
                            </div>
                        </div>
                        <div class="p-6">
                            <h3 class="text-xl font-bold text-gray-900 mb-2">Pédiatrie</h3>
                            <p class="text-sm text-gray-600 mb-4">Spécialité médicale dédiée aux nourrissons, enfants et adolescents.</p>
                            <div class="flex items-center justify-between text-sm text-gray-500 mb-4">
                                <span><i class="fas fa-calendar-alt mr-2 text-primary-600"></i>110 RDV/mois</span>
                                <span><i class="fas fa-star mr-2 text-yellow-500"></i>4.9/5</span>
                            </div>
                            <div class="flex items-center space-x-2">
                                <button onclick="viewSpecialty(4)" class="flex-1 px-4 py-2 bg-primary-50 text-primary-600 rounded-lg font-semibold hover:bg-primary-100 transition-colors">
                                    <i class="fas fa-eye mr-2"></i>Voir
                                </button>
                                <button onclick="editSpecialty(4)" class="px-4 py-2 bg-blue-50 text-blue-600 rounded-lg font-semibold hover:bg-blue-100 transition-colors">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button onclick="deleteSpecialty(4)" class="px-4 py-2 bg-red-50 text-red-600 rounded-lg font-semibold hover:bg-red-100 transition-colors">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- More specialty cards... -->
                    
                </div>
                
                <!-- List View (Hidden by default) -->
                <div id="listView" class="hidden bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                    <table class="w-full">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Spécialité</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Médecins</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">RDV/Mois</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Satisfaction</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center">
                                        <div class="w-10 h-10 bg-gradient-to-br from-red-500 to-red-600 rounded-lg flex items-center justify-center text-white mr-3">
                                            <i class="fas fa-heartbeat"></i>
                                        </div>
                                        <div>
                                            <div class="font-semibold text-gray-900">Cardiologie</div>
                                            <div class="text-sm text-gray-500">Maladies du cœur</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-3 py-1 text-xs font-bold rounded-full bg-blue-100 text-blue-700">8 médecins</span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">125</td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center">
                                        <i class="fas fa-star text-yellow-500 mr-1"></i>
                                        <span class="font-semibold text-gray-900">4.8/5</span>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm space-x-2">
                                    <button onclick="viewSpecialty(1)" class="text-blue-600 hover:text-blue-700 font-semibold">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button onclick="editSpecialty(1)" class="text-primary-600 hover:text-primary-700 font-semibold">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button onclick="deleteSpecialty(1)" class="text-red-600 hover:text-red-700 font-semibold">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <!-- More rows... -->
                        </tbody>
                    </table>
                </div>
                
            </main>
        </div>
    </div>
    
    <!-- Add/Edit Specialty Modal -->
    <div id="specialtyModal" class="hidden fixed inset-0 z-50 overflow-y-auto modal-backdrop">
        <div class="flex items-center justify-center min-h-screen p-4">
            <div class="fixed inset-0 bg-gray-900/50" onclick="closeSpecialtyModal()"></div>
            
            <div class="relative bg-white rounded-2xl shadow-2xl max-w-2xl w-full z-10">
                <!-- Modal Header -->
                <div class="bg-gradient-to-r from-primary-600 to-primary-700 p-6 text-white">
                    <div class="flex items-center justify-between">
                        <h3 class="text-2xl font-bold" id="modalTitle">Ajouter une spécialité</h3>
                        <button onclick="closeSpecialtyModal()" class="text-white hover:text-gray-200 transition-colors">
                            <i class="fas fa-times text-2xl"></i>
                        </button>
                    </div>
                </div>
                
                <!-- Modal Body -->
                <form id="specialtyForm" class="p-6">
                    <input type="hidden" id="specialtyId" name="specialtyId">
                    
                    <div class="space-y-4">
                        <!-- Icon Selection -->
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-3">
                                <i class="fas fa-icons text-primary-600 mr-2"></i>Icône <span class="text-red-500">*</span>
                            </label>
                            <div class="grid grid-cols-6 gap-3">
                                <label class="cursor-pointer">
                                    <input type="radio" name="icon" value="fa-heartbeat" class="peer hidden" required>
                                    <div class="p-4 border-2 border-gray-300 rounded-xl text-center peer-checked:border-primary-600 peer-checked:bg-primary-50 hover:border-primary-400 transition-all">
                                        <i class="fas fa-heartbeat text-2xl text-red-500"></i>
                                    </div>
                                </label>
                                <label class="cursor-pointer">
                                    <input type="radio" name="icon" value="fa-brain" class="peer hidden">
                                    <div class="p-4 border-2 border-gray-300 rounded-xl text-center peer-checked:border-primary-600 peer-checked:bg-primary-50 hover:border-primary-400 transition-all">
                                        <i class="fas fa-brain text-2xl text-purple-500"></i>
                                    </div>
                                </label>
                                <label class="cursor-pointer">
                                    <input type="radio" name="icon" value="fa-bone" class="peer hidden">
                                    <div class="p-4 border-2 border-gray-300 rounded-xl text-center peer-checked:border-primary-600 peer-checked:bg-primary-50 hover:border-primary-400 transition-all">
                                        <i class="fas fa-bone text-2xl text-blue-500"></i>
                                    </div>
                                </label>
                                <label class="cursor-pointer">
                                    <input type="radio" name="icon" value="fa-baby" class="peer hidden">
                                    <div class="p-4 border-2 border-gray-300 rounded-xl text-center peer-checked:border-primary-600 peer-checked:bg-primary-50 hover:border-primary-400 transition-all">
                                        <i class="fas fa-baby text-2xl text-pink-500"></i>
                                    </div>
                                </label>
                                <label class="cursor-pointer">
                                    <input type="radio" name="icon" value="fa-eye" class="peer hidden">
                                    <div class="p-4 border-2 border-gray-300 rounded-xl text-center peer-checked:border-primary-600 peer-checked:bg-primary-50 hover:border-primary-400 transition-all">
                                        <i class="fas fa-eye text-2xl text-green-500"></i>
                                    </div>
                                </label>
                                <label class="cursor-pointer">
                                    <input type="radio" name="icon" value="fa-tooth" class="peer hidden">
                                    <div class="p-4 border-2 border-gray-300 rounded-xl text-center peer-checked:border-primary-600 peer-checked:bg-primary-50 hover:border-primary-400 transition-all">
                                        <i class="fas fa-tooth text-2xl text-cyan-500"></i>
                                    </div>
                                </label>
                            </div>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                <i class="fas fa-tag text-primary-600 mr-2"></i>Nom de la spécialité <span class="text-red-500">*</span>
                            </label>
                            <input type="text" name="name" required placeholder="Ex: Cardiologie"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                        </div>
                        
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                <i class="fas fa-align-left text-primary-600 mr-2"></i>Description <span class="text-red-500">*</span>
                            </label>
                            <textarea name="description" rows="3" required placeholder="Description de la spécialité..."
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all"></textarea>
                        </div>
                        
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-palette text-primary-600 mr-2"></i>Couleur
                                </label>
                                <select name="color" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                    <option value="red">Rouge</option>
                                    <option value="blue">Bleu</option>
                                    <option value="green">Vert</option>
                                    <option value="purple">Violet</option>
                                    <option value="pink">Rose</option>
                                    <option value="orange">Orange</option>
                                    <option value="cyan">Cyan</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">
                                    <i class="fas fa-toggle-on text-primary-600 mr-2"></i>Statut
                                </label>
                                <select name="active" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                    <option value="true">Active</option>
                                    <option value="false">Inactive</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Modal Footer -->
                    <div class="flex items-center justify-end space-x-3 mt-8 pt-6 border-t border-gray-200">
                        <button type="button" onclick="closeSpecialtyModal()" class="px-6 py-3 border border-gray-300 rounded-lg font-semibold hover:bg-gray-50 transition-colors">
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
        // Toggle view
        function toggleView() {
            const cardView = document.getElementById('cardView');
            const listView = document.getElementById('listView');
            const viewText = document.getElementById('viewText');
            const viewToggle = document.getElementById('viewToggle');
            
            if (cardView.classList.contains('hidden')) {
                cardView.classList.remove('hidden');
                listView.classList.add('hidden');
                viewText.textContent = 'Vue liste';
                viewToggle.innerHTML = '<i class="fas fa-th-list mr-2"></i><span id="viewText">Vue liste</span>';
            } else {
                cardView.classList.add('hidden');
                listView.classList.remove('hidden');
                viewText.textContent = 'Vue cartes';
                viewToggle.innerHTML = '<i class="fas fa-th-large mr-2"></i><span id="viewText">Vue cartes</span>';
            }
        }
        
        // Modal functions
        function openAddSpecialtyModal() {
            document.getElementById('modalTitle').textContent = 'Ajouter une spécialité';
            document.getElementById('specialtyForm').reset();
            document.getElementById('specialtyId').value = '';
            document.getElementById('specialtyModal').classList.remove('hidden');
        }
        
        function closeSpecialtyModal() {
            document.getElementById('specialtyModal').classList.add('hidden');
        }
        
        function editSpecialty(id) {
            document.getElementById('modalTitle').textContent = 'Modifier la spécialité';
            document.getElementById('specialtyId').value = id;
            // Fetch and populate form data here
            document.getElementById('specialtyModal').classList.remove('hidden');
        }
        
        function viewSpecialty(id) {
            window.location.href = '${pageContext.request.contextPath}/admin/specialties/' + id;
        }
        
        function deleteSpecialty(id) {
            if (confirm('Êtes-vous sûr de vouloir supprimer cette spécialité ?')) {
                console.log('Delete specialty:', id);
            }
        }
        
        // Form submission
        document.getElementById('specialtyForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);
            console.log('Saving specialty...');
            closeSpecialtyModal();
        });
        
        // Search
        document.getElementById('searchSpecialty').addEventListener('input', function() {
            console.log('Search:', this.value);
        });
    </script>
</body>
</html>
