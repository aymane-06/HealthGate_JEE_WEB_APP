<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <style>
        /* TomSelect custom theme to match Tailwind form */
        .ts-wrapper {
            border-radius: 0.5rem !important;
            border: 1px solid #d1d5db !important; /* border-gray-300 */
            background: #fff !important;
            box-shadow: none !important;
            padding: 0 !important;
        }
        .ts-control {
            min-height: 4.5rem !important; /* increased height */
            padding: 0.5rem 1rem !important; /* px-4 py-3 */
            border: none !important;
            background: transparent !important;
            color: #374151 !important; /* text-gray-700 */
            font-size: 1rem !important;
            border-radius: 0.5rem !important;
            box-shadow: none !important;
        }
        .ts-control input {
            color: #374151 !important;
        }
        .ts-dropdown {
            border-radius: 0.5rem !important;
            border: 1px solid #d1d5db !important;
            box-shadow: 0 4px 24px 0 rgba(0,0,0,0.08);
            background: #fff !important;
            color: #374151 !important;
            font-size: 1rem !important;
        }
        .ts-dropdown .option {
            padding: 0.5rem 1rem !important;
            border-radius: 0.375rem !important;
            transition: background 0.2s;
        }
        .ts-dropdown .option.active,
        .ts-dropdown .option.selected,
        .ts-dropdown .option:hover {
            background: #f1f5f9 !important; /* bg-gray-100 */
            color: #2563eb !important; /* text-primary-600 */
        }
        .ts-control .item {
            background: #f1f5f9 !important; /* bg-gray-100 */
            color: #2563eb !important; /* text-primary-600 */
            border-radius: 0.375rem !important;
            margin-right: 0.25rem;
            padding: 0.25rem 0.75rem;
            font-weight: 500;
        }
        .ts-wrapper.focus .ts-control {
            box-shadow: 0 0 0 2px #2563eb33 !important; /* focus:ring-primary-500 */
            border-color: #2563eb !important;
        }
        .ts-control .remove {
            color: #ef4444 !important; /* text-red-500 */
            margin-left: 0.5rem;
        }
        .ts-dropdown .no-results {
            color: #9ca3af !important; /* text-gray-400 */
            padding: 0.5rem 1rem;
        }
        /* Increase height of specialties container */
        #specialtiesContainer {
            min-height: 90px;
        }
    </style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Départements - Admin</title>

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- TomSelect CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/css/tom-select.bootstrap5.min.css" rel="stylesheet">

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

    <!-- TomSelect JS -->
    <script src="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/js/tom-select.complete.min.js"></script>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <style>
        * { font-family: 'Inter', sans-serif; }

        .modal-backdrop {
            backdrop-filter: blur(8px);
        }

        .skeleton-loader {
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 200% 100%;
            animation: loading 1.5s infinite;
        }

        @keyframes loading {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
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
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/specialties" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-primary-700/30 transition-colors text-primary-100 hover:text-white">
                        <i class="fas fa-stethoscope w-5"></i>
                        <span class="font-medium">Spécialités</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/departments" class="flex items-center space-x-3 p-3 rounded-lg bg-primary-700/50 text-white">
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
                    <h2 class="text-2xl font-bold text-gray-900">Gestion des Départements</h2>
                    <p class="text-sm text-gray-500">Organisez et gérez les départements de la clinique</p>
                </div>
                <div class="flex items-center space-x-3">
                    <button onclick="departmentManager.toggleView()" id="viewToggle" class="px-4 py-2 border border-gray-300 rounded-lg font-semibold hover:bg-gray-50 transition-colors">
                        <i class="fas fa-th-list mr-2"></i>
                        <span id="viewText">Vue liste</span>
                    </button>
                    <button onclick="departmentManager.openAddModal()" class="flex items-center space-x-2 bg-primary-600 hover:bg-primary-700 text-white rounded-lg px-4 py-2 font-semibold transition-colors shadow-lg shadow-primary-600/30">
                        <i class="fas fa-plus"></i>
                        <span>Nouveau Département</span>
                    </button>
                </div>
            </div>
        </header>

        <!-- Main Content Area -->
        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">

            <!-- Stats Cards -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl shadow-lg p-6 text-white">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-white/20 p-3 rounded-xl">
                            <i class="fas fa-building text-2xl"></i>
                        </div>
                    </div>
                    <h3 class="text-4xl font-bold mb-1" id="totalDepartments">-</h3>
                    <p class="text-blue-100">Total Départements</p>
                </div>

                <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-2xl shadow-lg p-6 text-white">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-white/20 p-3 rounded-xl">
                            <i class="fas fa-user-md text-2xl"></i>
                        </div>
                    </div>
                    <h3 class="text-4xl font-bold mb-1" id="totalStaff">-</h3>
                    <p class="text-green-100">Personnel Total</p>
                </div>

                <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl shadow-lg p-6 text-white">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-white/20 p-3 rounded-xl">
                            <i class="fas fa-calendar-check text-2xl"></i>
                        </div>
                    </div>
                    <h3 class="text-4xl font-bold mb-1" id="monthlyAppointments">-</h3>
                    <p class="text-purple-100">RDV ce mois</p>
                </div>

                <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-2xl shadow-lg p-6 text-white">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-white/20 p-3 rounded-xl">
                            <i class="fas fa-star text-2xl"></i>
                        </div>
                    </div>
                    <h3 class="text-4xl font-bold mb-1" id="avgRating">-</h3>
                    <p class="text-orange-100">Satisfaction moyenne</p>
                </div>
            </div>

            <!-- Search and Filters -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 mb-6">
                <div class="flex flex-col lg:flex-row gap-4">
                    <div class="flex-1 relative">
                        <input type="text" id="searchDepartment" placeholder="Rechercher un département..."
                               class="w-full pl-12 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                        <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    </div>
                    <div class="flex gap-2">
                        <select id="statusFilter" class="px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                            <option value="">Tous les statuts</option>
                            <option value="ACTIVE">Actif</option>
                            <option value="INACTIVE">Inactif</option>
                        </select>
                        <select id="sortBy" class="px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                            <option value="name">Trier par nom</option>
                            <option value="staffCount">Trier par personnel</option>
                            <option value="createdAt">Trier par date</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Loading Skeleton -->
            <div id="loadingSkeleton" class="hidden">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                        <div class="p-6">
                            <div class="skeleton-loader h-6 w-3/4 rounded mb-4"></div>
                            <div class="skeleton-loader h-4 w-full rounded mb-2"></div>
                            <div class="skeleton-loader h-4 w-2/3 rounded mb-4"></div>
                            <div class="flex justify-between">
                                <div class="skeleton-loader h-8 w-20 rounded"></div>
                                <div class="skeleton-loader h-8 w-20 rounded"></div>
                            </div>
                        </div>
                    </div>
                    <!-- Repeat skeleton cards -->
                </div>
            </div>

            <!-- Card View -->
            <div id="cardView" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <!-- Departments will be loaded here dynamically -->
            </div>

            <!-- List View -->
            <div id="listView" class="hidden bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <table class="w-full">
                    <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Département</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Responsable</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Personnel</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Spécialités</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Statut</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Actions</th>
                    </tr>
                    </thead>
                    <tbody id="listViewBody" class="divide-y divide-gray-100">
                    <!-- List items will be loaded here dynamically -->
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div id="pagination" class="flex items-center justify-between mt-6 px-4">
                <div class="text-sm text-gray-600" id="paginationInfo">
                    Chargement...
                </div>
                <div class="flex space-x-2" id="paginationControls">
                    <!-- Pagination buttons will be loaded here -->
                </div>
            </div>

        </main>
    </div>
</div>

<!-- Add/Edit Department Modal -->
<div id="departmentModal" class="hidden fixed inset-0 z-50 overflow-y-auto modal-backdrop">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="fixed inset-0 bg-gray-900/50" onclick="departmentManager.closeModal()"></div>

        <div class="relative bg-white rounded-2xl shadow-2xl max-w-4xl w-full z-10">
            <!-- Modal Header -->
            <div class="bg-gradient-to-r from-primary-600 to-primary-700 p-6 text-white">
                <div class="flex items-center justify-between">
                    <h3 class="text-2xl font-bold" id="modalTitle">Nouveau Département</h3>
                    <button onclick="departmentManager.closeModal()" class="text-white hover:text-gray-200 transition-colors">
                        <i class="fas fa-times text-2xl"></i>
                    </button>
                </div>
            </div>

            <!-- Modal Body -->
            <form id="departmentForm" class="p-6">
                <input type="hidden" id="departmentId" name="departmentId">

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <!-- Left Column -->
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                <i class="fas fa-code text-primary-600 mr-2"></i>Code Département <span class="text-red-500">*</span>
                            </label>
                            <input type="text" name="code" required placeholder="Ex: CARDIO"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                <i class="fas fa-tag text-primary-600 mr-2"></i>Nom du Département <span class="text-red-500">*</span>
                            </label>
                            <input type="text" name="name" required placeholder="Ex: Cardiologie"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                <i class="fas fa-user-md text-primary-600 mr-2"></i>Responsable
                            </label>
                            <select name="headDoctorId" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                <option value="">Sélectionner un responsable</option>
                                <!-- Doctors will be populated dynamically -->
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                <i class="fas fa-phone text-primary-600 mr-2"></i>Téléphone
                            </label>
                            <input type="tel" name="phone" placeholder="Ex: +212 600-000000"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                        </div>
                    </div>

                    <!-- Right Column -->
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                <i class="fas fa-map-marker-alt text-primary-600 mr-2"></i>Localisation
                            </label>
                            <input type="text" name="location" placeholder="Ex: Bâtiment A, 2ème étage"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                <i class="fas fa-palette text-primary-600 mr-2"></i>Couleur
                            </label>
                            <select name="color" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                <option value="blue">Bleu</option>
                                <option value="green">Vert</option>
                                <option value="red">Rouge</option>
                                <option value="purple">Violet</option>
                                <option value="orange">Orange</option>
                                <option value="pink">Rose</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                <i class="fas fa-toggle-on text-primary-600 mr-2"></i>Statut
                            </label>
                            <select name="status" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                                <option value="ACTIVE">Actif</option>
                                <option value="INACTIVE">Inactif</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                <i class="fas fa-stethoscope text-primary-600 mr-2"></i>Spécialités
                            </label>
                            <div id="specialtiesContainer" class="max-h-32 overflow-y-auto border border-gray-300 rounded-lg p-2">
                                <!-- Specialties checkboxes will be populated here -->
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-4">
                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                        <i class="fas fa-align-left text-primary-600 mr-2"></i>Description
                    </label>
                    <textarea name="description" rows="3" placeholder="Description du département..."
                              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all"></textarea>
                </div>

                <!-- Modal Footer -->
                <div class="flex items-center justify-end space-x-3 mt-8 pt-6 border-t border-gray-200">
                    <button type="button" onclick="departmentManager.closeModal()" class="px-6 py-3 border border-gray-300 rounded-lg font-semibold hover:bg-gray-50 transition-colors">
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
    // ============================================
    // Department Management System
    // ============================================
    const departmentManager = {
        state: {
            currentPage: 1,
            pageSize: 9,
            searchTerm: '',
            statusFilter: '',
            sortBy: 'name',
            sortOrder: 'asc',
            totalElements: 0,
            totalPages: 0,
            loading: false,
            abortController: null,
            contextPath: '',
            departmentsCache: [],
            isCardView: true,
            doctors: [],
            specialties: []
        },

        init(contextPath) {
            this.state.contextPath = contextPath || '';
            this.bindEventListeners();
            this.loadInitialData();
            this.loadDepartments();
        },

        bindEventListeners() {
            // Search with debounce
            const searchInput = document.getElementById('searchDepartment');
            if (searchInput) {
                let searchTimeout;
                searchInput.addEventListener('input', function(e) {
                    clearTimeout(searchTimeout);
                    searchTimeout = setTimeout(function() {
                        departmentManager.state.searchTerm = e.target.value;
                        departmentManager.state.currentPage = 1;
                        departmentManager.loadDepartments();
                    }, 500);
                });
            }

            // Filters
            const statusFilter = document.getElementById('statusFilter');
            const sortBy = document.getElementById('sortBy');

            if (statusFilter) {
                statusFilter.addEventListener('change', function(e) {
                    departmentManager.state.statusFilter = e.target.value;
                    departmentManager.state.currentPage = 1;
                    departmentManager.loadDepartments();
                });
            }

            if (sortBy) {
                sortBy.addEventListener('change', function(e) {
                    departmentManager.state.sortBy = e.target.value;
                    departmentManager.loadDepartments();
                });
            }

            // Form submission
            const form = document.getElementById('departmentForm');
            if (form) {
                form.addEventListener('submit', function(e) {
                    departmentManager.handleFormSubmit(e);
                });
            }
        },

        async loadInitialData() {
            try {
                // Load doctors for head doctor selection
                const doctorsResponse = await fetch(this.state.contextPath + '/api/admin/doctors');
                if (doctorsResponse.ok) {
                    const doctorsData = await doctorsResponse.json();
                    console.log(doctorsData);
                    this.state.doctors = doctorsData.data || [];
                }

                // Load specialties for checkboxes
                const specialtiesResponse = await fetch(this.state.contextPath + '/api/admin/specialties');
                if (specialtiesResponse.ok) {
                    const specialtiesData = await specialtiesResponse.json();
                    console.log(specialtiesData)
                    this.state.specialties = specialtiesData.data?.specialties || [];
                }

                this.populateFormSelects();
            } catch (error) {
                console.error('Error loading initial data:', error);
            }
        },

        populateFormSelects() {
            // Populate head doctors dropdown with TomSelect
            const headDoctorSelect = document.querySelector('select[name="headDoctorId"]');
            if (headDoctorSelect) {
                headDoctorSelect.innerHTML = '<option value="">Sélectionner un responsable</option>';
                if (this.state.doctors.length > 0) {
                    for (var i = 0; i < this.state.doctors.length; i++) {
                        var doctor = this.state.doctors[i];
                        headDoctorSelect.innerHTML += '<option value="' + doctor.id + '">' +
                            this.escapeHtml(doctor.title) + '. ' + this.escapeHtml(doctor.Name) +
                            '</option>';
                    }
                }
                if (headDoctorSelect.tomselect) headDoctorSelect.tomselect.destroy();
                new TomSelect(headDoctorSelect, {
                    create: false,
                    sortField: { field: 'text', direction: 'asc' },
                    placeholder: "Sélectionner un responsable"
                });
            }

            // Populate specialties multi-select with TomSelect
            let specialtiesSelect = document.querySelector('select[name="specialties"]');
            const specialtiesContainer = document.getElementById('specialtiesContainer');
            if (!specialtiesSelect) {
                // If not present, create and insert it
                specialtiesSelect = document.createElement('select');
                specialtiesSelect.name = 'specialties';
                specialtiesSelect.multiple = true;
                specialtiesSelect.className = 'w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all';
                specialtiesSelect.style.minHeight = '40px';
                if (specialtiesContainer) {
                    specialtiesContainer.innerHTML = '';
                    specialtiesContainer.appendChild(specialtiesSelect);
                }
            } else {
                specialtiesSelect.innerHTML = '';
            }
            if (this.state.specialties.length > 0) {
                for (var i = 0; i < this.state.specialties.length; i++) {
                    var specialty = this.state.specialties[i];
                    var option = document.createElement('option');
                    option.value = specialty.id;
                    option.textContent = specialty.name;
                    specialtiesSelect.appendChild(option);
                }
            }
            if (specialtiesSelect.tomselect) specialtiesSelect.tomselect.destroy();
            new TomSelect(specialtiesSelect, {
                plugins: ['remove_button'],
                placeholder: "Sélectionner les spécialités",
                create: false,
                maxOptions: 1000,
                closeAfterSelect: false,
                hideSelected: true
            });
        },

        async loadDepartments() {
            if (this.state.loading && this.state.abortController) {
                this.state.abortController.abort();
            }

            this.state.loading = true;
            this.state.abortController = new AbortController();
            this.showLoading(true);

            try {
                const params = new URLSearchParams({
                    page: this.state.currentPage,
                    size: this.state.pageSize,
                    sort: this.state.sortBy,
                    order: this.state.sortOrder
                });

                if (this.state.searchTerm) params.append('search', this.state.searchTerm);
                if (this.state.statusFilter) params.append('status', this.state.statusFilter);

                const url = this.state.contextPath + '/api/admin/departments?' + params.toString();
                console.log(url);
                const response = await fetch(url, {
                    signal: this.state.abortController.signal
                });

                if (!response.ok) throw new Error('Failed to fetch departments');

                const data = await response.json();
                if (data.status === 'OK') {
                    this.state.totalElements = data.data.pagination.totalElements;
                    this.state.totalPages = data.data.pagination.totalPages;
                    this.state.departmentsCache = data.data.departments;

                    this.renderDepartments(data.departments);
                    this.updateStats(data.data.stats);
                    this.renderPagination();
                    this.showToast('Départements chargés avec succès', 'success');
                } else {
                    throw new Error(data.message || 'Unknown error');
                }
            } catch (error) {
                if (error.name === 'AbortError') return;
                console.error('Error loading departments:', error);
                this.showToast('Erreur de chargement des départements', 'error');
            } finally {
                this.state.loading = false;
                this.showLoading(false);
            }
        },

        renderDepartments(departments) {

            const cardView = document.getElementById('cardView');
            const listViewBody = document.getElementById('listViewBody');

            if (!departments || departments.length === 0) {
                const emptyMessage = '<div class="col-span-full text-center py-12">' +
                    '<i class="fas fa-building text-5xl text-gray-400 mb-4"></i>' +
                    '<p class="text-gray-600">Aucun département trouvé</p>' +
                    '<button onclick="departmentManager.openAddModal()" class="mt-4 px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors">' +
                    '<i class="fas fa-plus mr-2"></i>Ajouter un département' +
                    '</button>' +
                    '</div>';
                cardView.innerHTML = emptyMessage;
                listViewBody.innerHTML = '<tr><td colspan="6" class="px-6 py-8 text-center text-gray-500">Aucun département trouvé</td></tr>';
                return;
            }

            // Render card view
            var cardHtml = '';
            for (var i = 0; i < departments.length; i++) {
                cardHtml += this.createDepartmentCard(departments[i]);
            }
            cardView.innerHTML = cardHtml;

            // Render list view
            var listHtml = '';
            for (var i = 0; i < departments.length; i++) {
                listHtml += this.createDepartmentRow(departments[i]);
            }
            listViewBody.innerHTML = listHtml;

            this.attachEventListeners();
        },

        createDepartmentCard(department) {
            const colorClass = this.getColorClass(department.color);
            const statusClass = department.status === 'ACTIVE'
                ? 'bg-green-100 text-green-800'
                : 'bg-red-100 text-red-800';
            const statusText = department.status === 'ACTIVE' ? 'Actif' : 'Inactif';
            const staffCount = department.staffCount || 0;
            const specialtiesCount = department.specialtiesCount || 0;
            const phone = department.phone || 'N/A';
            const location = department.location || 'Non spécifiée';
            const description = department.description || 'Aucune description';

            return '<div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-lg transition-all transform hover:-translate-y-1">' +
                '<div class="bg-gradient-to-br ' + colorClass + ' p-6 text-white">' +
                '<div class="flex items-center justify-between">' +
                '<div class="w-16 h-16 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">' +
                '<i class="fas fa-building text-3xl"></i>' +
                '</div>' +
                '<div class="text-right">' +
                '<p class="text-4xl font-bold">' + staffCount + '</p>' +
                '<p class="text-white/80 text-sm">Personnel</p>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '<div class="p-6">' +
                '<div class="flex items-start justify-between mb-2">' +
                '<h3 class="text-xl font-bold text-gray-900">' + this.escapeHtml(department.name) + '</h3>' +
                '<span class="px-3 py-1 text-xs font-bold rounded-full ' + statusClass + '">' + statusText + '</span>' +
                '</div>' +
                '<p class="text-sm text-gray-600 mb-2"><strong>Code:</strong> ' + this.escapeHtml(department.code) + '</p>' +
                '<p class="text-sm text-gray-600 mb-2"><strong>Localisation:</strong> ' + this.escapeHtml(location) + '</p>' +
                '<p class="text-sm text-gray-600 mb-4">' + this.escapeHtml(description) + '</p>' +
                '<div class="flex items-center justify-between text-sm text-gray-500 mb-4">' +
                '<span><i class="fas fa-user-md mr-2 text-primary-600"></i>' + specialtiesCount + ' spécialités</span>' +
                '<span><i class="fas fa-phone mr-2 text-primary-600"></i>' + phone + '</span>' +
                '</div>' +
                '<div class="flex items-center space-x-2">' +
                '<button data-dept-id="' + department.id + '" class="view-dept-btn flex-1 px-4 py-2 bg-primary-50 text-primary-600 rounded-lg font-semibold hover:bg-primary-100 transition-colors">' +
                '<i class="fas fa-eye mr-2"></i>Voir' +
                '</button>' +
                '<button data-dept-id="' + department.id + '" class="edit-dept-btn px-4 py-2 bg-blue-50 text-blue-600 rounded-lg font-semibold hover:bg-blue-100 transition-colors">' +
                '<i class="fas fa-edit"></i>' +
                '</button>' +
                '<button data-dept-id="' + department.id + '" data-dept-name="' + this.escapeHtml(department.name) + '" class="delete-dept-btn px-4 py-2 bg-red-50 text-red-600 rounded-lg font-semibold hover:bg-red-100 transition-colors">' +
                '<i class="fas fa-trash"></i>' +
                '</button>' +
                '</div>' +
                '</div>' +
                '</div>';
        },

        createDepartmentRow(department) {
            const statusClass = department.status === 'ACTIVE'
                ? 'bg-green-100 text-green-800'
                : 'bg-red-100 text-red-800';
            const statusText = department.status === 'ACTIVE' ? 'Actif' : 'Inactif';
            const staffCount = department.staffCount || 0;
            const specialtiesCount = department.specialtiesCount || 0;

            var headDoctorName = 'Non assigné';
            if (department.headDoctor) {
                headDoctorName = 'Dr. ' + this.escapeHtml(department.headDoctor.firstName) + ' ' + this.escapeHtml(department.headDoctor.lastName);
            }

            return '<tr class="hover:bg-gray-50 transition-colors">' +
                '<td class="px-6 py-4 whitespace-nowrap">' +
                '<div class="flex items-center">' +
                '<div class="w-10 h-10 bg-gradient-to-br from-primary-500 to-primary-600 rounded-lg flex items-center justify-center text-white mr-3">' +
                '<i class="fas fa-building"></i>' +
                '</div>' +
                '<div>' +
                '<div class="font-semibold text-gray-900">' + this.escapeHtml(department.name) + '</div>' +
                '<div class="text-sm text-gray-500">' + this.escapeHtml(department.code) + '</div>' +
                '</div>' +
                '</div>' +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">' +
                headDoctorName +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap">' +
                '<span class="px-3 py-1 text-xs font-bold rounded-full bg-blue-100 text-blue-700">' +
                staffCount + ' personnes' +
                '</span>' +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">' +
                specialtiesCount + ' spécialités' +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap">' +
                '<span class="px-3 py-1 text-xs font-bold rounded-full ' + statusClass + '">' + statusText + '</span>' +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap text-sm space-x-2">' +
                '<button data-dept-id="' + department.id + '" class="view-dept-btn text-blue-600 hover:text-blue-700 font-semibold">' +
                '<i class="fas fa-eye"></i>' +
                '</button>' +
                '<button data-dept-id="' + department.id + '" class="edit-dept-btn text-primary-600 hover:text-primary-700 font-semibold">' +
                '<i class="fas fa-edit"></i>' +
                '</button>' +
                '<button data-dept-id="' + department.id + '" data-dept-name="' + this.escapeHtml(department.name) + '" class="delete-dept-btn text-red-600 hover:text-red-700 font-semibold">' +
                '<i class="fas fa-trash"></i>' +
                '</button>' +
                '</td>' +
                '</tr>';
        },

        attachEventListeners() {
            // Edit buttons
            var editButtons = document.querySelectorAll('.edit-dept-btn');
            for (var i = 0; i < editButtons.length; i++) {
                editButtons[i].addEventListener('click', function(e) {
                    departmentManager.editDepartment(e.currentTarget.dataset.deptId);
                });
            }

            // Delete buttons
            var deleteButtons = document.querySelectorAll('.delete-dept-btn');
            for (var i = 0; i < deleteButtons.length; i++) {
                deleteButtons[i].addEventListener('click', function(e) {
                    departmentManager.confirmDelete(e.currentTarget.dataset.deptId, e.currentTarget.dataset.deptName);
                });
            }

            // View buttons
            var viewButtons = document.querySelectorAll('.view-dept-btn');
            for (var i = 0; i < viewButtons.length; i++) {
                viewButtons[i].addEventListener('click', function(e) {
                    departmentManager.viewDepartment(e.currentTarget.dataset.deptId);
                });
            }
        },

        async editDepartment(departmentId) {
            const department = this.state.departmentsCache.find(function(d) { return d.id === departmentId; });
            if (!department) {
                this.showToast('Département non trouvé', 'error');
                return;
            }

            this.openModal('Modifier le Département');

            // Populate form
            document.getElementById('departmentId').value = department.id;
            document.querySelector('input[name="code"]').value = department.code || '';
            document.querySelector('input[name="name"]').value = department.name || '';
            document.querySelector('select[name="headDoctorId"]').value = department.headDoctorId || '';
            document.querySelector('input[name="phone"]').value = department.phone || '';
            document.querySelector('input[name="location"]').value = department.location || '';
            document.querySelector('select[name="color"]').value = department.color || 'blue';
            document.querySelector('select[name="status"]').value = department.status || 'ACTIVE';
            document.querySelector('textarea[name="description"]').value = department.description || '';

            // Set specialties in TomSelect multi-select
            if (department.specialties) {
                const specialtiesSelect = document.querySelector('select[name="specialties"]');
                if (specialtiesSelect && specialtiesSelect.tomselect) {
                    const selectedIds = department.specialties.map(function(s) { return String(s.id); });
                    specialtiesSelect.tomselect.setValue(selectedIds);
                }
            }
        },

        viewDepartment(departmentId) {
            const department = this.state.departmentsCache.find(function(d) { return d.id === departmentId; });
            if (department) {
                // You can implement a detailed view modal here
                this.showToast('Vue détaillée de ' + department.name, 'info');
            }
        },

        confirmDelete(departmentId, departmentName) {
            if (confirm('Êtes-vous sûr de vouloir supprimer le département "' + departmentName + '" ? Cette action est irréversible.')) {
                this.deleteDepartment(departmentId);
            }
        },

        async deleteDepartment(departmentId) {
            try {
                const response = await fetch(this.state.contextPath + '/api/admin/departments/' + departmentId, {
                    method: 'DELETE'
                });

                if (response.ok) {
                    this.showToast('Département supprimé avec succès', 'success');
                    this.loadDepartments();
                } else {
                    const data = await response.json();
                    throw new Error(data.message || 'Failed to delete department');
                }
            } catch (error) {
                this.showToast('Erreur: ' + error.message, 'error');
            }
        },

        async handleFormSubmit(e) {
            e.preventDefault();
            const formData = new FormData(e.target);
            const departmentId = document.getElementById('departmentId').value;

            const method = departmentId ? 'PUT' : 'POST';
            const url = departmentId
                ? this.state.contextPath + '/api/admin/departments/' + departmentId
                : this.state.contextPath + '/api/admin/departments';

            // Convert form data to JSON
            const data = {
                code: formData.get('code'),
                name: formData.get('name'),
                headDoctorId: formData.get('headDoctorId') || null,
                phone: formData.get('phone'),
                location: formData.get('location'),
                color: formData.get('color'),
                status: formData.get('status'),
                description: formData.get('description'),
                specialties: Array.from(formData.getAll('specialties')).map(function(id) { return { id: id }; })
            };

            try {
                const response = await fetch(url, {
                    method: method,
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(data)
                });

                const result = await response.json();

                if (response.ok && result.status === 'success') {
                    this.showToast(result.message, 'success');
                    this.closeModal();
                    this.loadDepartments();
                } else {
                    throw new Error(result.message || 'Failed to save department');
                }
            } catch (error) {
                this.showToast('Erreur: ' + error.message, 'error');
            }
        },

        openModal(title) {
            if (!title) title = 'Nouveau Département';
            document.getElementById('modalTitle').textContent = title;
            document.getElementById('departmentModal').classList.remove('hidden');
        },

        closeModal() {
            document.getElementById('departmentModal').classList.add('hidden');
            document.getElementById('departmentForm').reset();
            document.getElementById('departmentId').value = '';
        },

        openAddModal() {
            this.openModal('Nouveau Département');
        },

        toggleView() {
            this.state.isCardView = !this.state.isCardView;

            const cardView = document.getElementById('cardView');
            const listView = document.getElementById('listView');
            const viewText = document.getElementById('viewText');
            const viewToggle = document.getElementById('viewToggle');

            if (this.state.isCardView) {
                cardView.classList.remove('hidden');
                listView.classList.add('hidden');
                viewText.textContent = 'Vue liste';
                viewToggle.innerHTML = '<i class="fas fa-th-list mr-2"></i>Vue liste';
            } else {
                cardView.classList.add('hidden');
                listView.classList.remove('hidden');
                viewText.textContent = 'Vue carte';
                viewToggle.innerHTML = '<i class="fas fa-th-large mr-2"></i>Vue carte';
            }
        },

        updateStats(stats) {
            if (stats) {
                document.getElementById('totalDepartments').textContent = stats.totalDepartments || 0;
                document.getElementById('totalStaff').textContent = stats.totalStaff || 0;
                document.getElementById('monthlyAppointments').textContent = stats.monthlyAppointments || 0;
                var avgRating = stats.avgRating ? stats.avgRating.toFixed(1) : '0.0';
                document.getElementById('avgRating').textContent = avgRating;
            }
        },

        renderPagination() {
            const paginationInfo = document.getElementById('paginationInfo');
            const paginationControls = document.getElementById('paginationControls');

            if (!paginationInfo || !paginationControls) return;

            const startItem = (this.state.currentPage - 1) * this.state.pageSize + 1;
            const endItem = Math.min(this.state.currentPage * this.state.pageSize, this.state.totalElements);

            paginationInfo.textContent = 'Affichage de ' + startItem + ' à ' + endItem + ' sur ' + this.state.totalElements + ' départements';

            var buttons = '';

            // Previous button
            var prevDisabled = this.state.currentPage === 1 ? 'disabled' : '';
            var prevClass = this.state.currentPage === 1 ? 'bg-gray-100 text-gray-400' : 'hover:bg-gray-50';
            buttons += '<button onclick="departmentManager.changePage(' + (this.state.currentPage - 1) + ')" ' + prevDisabled + ' class="px-3 py-2 border border-gray-300 rounded-lg ' + prevClass + '">' +
                '<i class="fas fa-chevron-left"></i>' +
                '</button>';

            // Page numbers
            const maxVisiblePages = 5;
            var startPage = Math.max(1, this.state.currentPage - Math.floor(maxVisiblePages / 2));
            var endPage = Math.min(this.state.totalPages, startPage + maxVisiblePages - 1);

            if (endPage - startPage + 1 < maxVisiblePages) {
                startPage = Math.max(1, endPage - maxVisiblePages + 1);
            }

            for (var i = startPage; i <= endPage; i++) {
                var pageClass = this.state.currentPage === i ? 'bg-primary-600 text-white' : 'hover:bg-gray-50';
                buttons += '<button onclick="departmentManager.changePage(' + i + ')" class="px-3 py-2 border border-gray-300 rounded-lg ' + pageClass + '">' +
                    i +
                    '</button>';
            }

            // Next button
            var nextDisabled = this.state.currentPage === this.state.totalPages ? 'disabled' : '';
            var nextClass = this.state.currentPage === this.state.totalPages ? 'bg-gray-100 text-gray-400' : 'hover:bg-gray-50';
            buttons += '<button onclick="departmentManager.changePage(' + (this.state.currentPage + 1) + ')" ' + nextDisabled + ' class="px-3 py-2 border border-gray-300 rounded-lg ' + nextClass + '">' +
                '<i class="fas fa-chevron-right"></i>' +
                '</button>';

            paginationControls.innerHTML = buttons;
        },

        changePage(page) {
            if (page >= 1 && page <= this.state.totalPages && page !== this.state.currentPage) {
                this.state.currentPage = page;
                this.loadDepartments();
            }
        },

        showLoading(show) {
            const loadingSkeleton = document.getElementById('loadingSkeleton');
            const cardView = document.getElementById('cardView');
            const listView = document.getElementById('listView');

            if (show) {
                loadingSkeleton.classList.remove('hidden');
                cardView.classList.add('hidden');
                listView.classList.add('hidden');
            } else {
                loadingSkeleton.classList.add('hidden');
                if (this.state.isCardView) {
                    cardView.classList.remove('hidden');
                } else {
                    listView.classList.remove('hidden');
                }
            }
        },

        showToast(message, type) {
            if (!type) type = 'success';
            const existing = document.getElementById('toast');
            if (existing) existing.remove();

            var colors = {
                success: 'bg-green-600',
                error: 'bg-red-600',
                info: 'bg-blue-600',
                warning: 'bg-orange-600'
            };
            var icons = {
                success: 'fa-check-circle',
                error: 'fa-times-circle',
                info: 'fa-info-circle',
                warning: 'fa-exclamation-triangle'
            };

            const toast = document.createElement('div');
            toast.id = 'toast';
            toast.className = 'fixed bottom-6 right-6 z-50 px-6 py-4 rounded-lg shadow-2xl text-white font-semibold flex items-center space-x-3 ' + colors[type];
            toast.innerHTML = '<i class="fas ' + icons[type] + ' text-xl"></i><span>' + this.escapeHtml(message) + '</span>';

            document.body.appendChild(toast);

            setTimeout(function() {
                toast.classList.add('opacity-0', 'translate-x-full', 'transition-all');
                setTimeout(function() { toast.remove(); }, 300);
            }, 3000);
        },

        getColorClass(color) {
            var colorMap = {
                blue: 'from-blue-500 to-blue-600',
                green: 'from-green-500 to-green-600',
                red: 'from-red-500 to-red-600',
                purple: 'from-purple-500 to-purple-600',
                orange: 'from-orange-500 to-orange-600',
                pink: 'from-pink-500 to-pink-600'
            };
            return colorMap[color] || 'from-primary-500 to-primary-600';
        },

        escapeHtml(text) {
            if (text == null) return '';
            var div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }
    };

    // Initialize department manager when DOM is loaded
    document.addEventListener('DOMContentLoaded', function() {
        departmentManager.init('<%= request.getContextPath() %>');
    });
</script>
</body>
</html>