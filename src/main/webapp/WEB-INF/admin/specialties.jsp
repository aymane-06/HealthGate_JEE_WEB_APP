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
                                <i class="fas fa-code text-primary-600 mr-2"></i>Code de la spécialité <span class="text-red-500">*</span>
                            </label>
                            <input type="text" name="code" required placeholder="Ex: CARDIO"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
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
                                <select name="isActive" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        // ============================================
        // Specialty Management System
        // ============================================
        const specialtyManager = {
            state: {
                currentPage: 1,
                pageSize: 10,
                searchTerm: '',
                sortField: '',
                sortOrder: 'asc',
                totalElements: 0,
                totalPages: 0,
                loading: false,
                abortController: null,
                contextPath: '',
                specialtiesCache: [] // Store fetched specialties here
            },

            init(contextPath) {
                this.state.contextPath = contextPath || '';
                this.bindEventListeners();
                this.loadSpecialties();
            },

            bindEventListeners() {
                const searchInput = document.getElementById('searchSpecialty');
                if (searchInput) {
                    let searchTimeout;
                    searchInput.addEventListener('input', (e) => {
                        clearTimeout(searchTimeout);
                        searchTimeout = setTimeout(() => {
                            this.state.searchTerm = e.target.value;
                            this.state.currentPage = 1;
                            this.loadSpecialties();
                        }, 500);
                    });
                }
            },

            async loadSpecialties() {
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
                    if (this.state.sortField) {
                        params.append('sort', this.state.sortField);
                        params.append('order', this.state.sortOrder);
                    }

                    const url = this.state.contextPath + '/api/admin/specialties?' + params.toString();
                    const response = await fetch(url, { signal: this.state.abortController.signal });

                    if (!response.ok) throw new Error('Failed to fetch specialties');

                    const data = await response.json();
                    if (data.status === 'success') {
                        console.log(data);
                        this.state.totalElements = data.data.pagination.totalElements;
                        this.state.totalPages = data.data.pagination.totalPages;
                        this.state.specialtiesCache = data.data.specialties; // Store specialties in cache
                        this.renderSpecialties(data.data.specialties);
                        this.showToast('Spécialités chargées avec succès', 'success');
                    } else {
                        throw new Error(data.message || 'Unknown error');
                    }
                } catch (error) {
                    if (error.name === 'AbortError') return;
                    console.error('Error loading specialties:', error);
                    this.showToast('Erreur de chargement', 'error');
                } finally {
                    this.state.loading = false;
                    this.showLoading(false);
                }
            },

            renderSpecialties(specialties) {

                const cardView = document.getElementById('cardView');
                if (!specialties || specialties.length === 0) {
                    cardView.innerHTML = '<div class="col-span-full text-center py-12"><i class="fas fa-inbox text-5xl text-gray-400 mb-4"></i><p class="text-gray-600">Aucune spécialité trouvée</p></div>';
                    return;
                }

                cardView.innerHTML = specialties.map(function(specialty) {
                    var specialtyId = specialtyManager.escapeHtml(specialty.id);
                    var specialtyName = specialtyManager.escapeHtml(specialty.name);
                    var specialtyCode = specialtyManager.escapeHtml(specialty.code);
                    var specialtyDesc = specialtyManager.escapeHtml(specialty.description || 'Aucune description');
                    var doctorsCount = specialty.doctorsCount || 0;
                    var color = specialty.color || 'primary';
                    var icon = specialty.icon || 'fa-stethoscope';
                    var colorFrom = 'from-' + color + '-500';
                    var colorTo = 'to-' + color + '-600';

                    return '<div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-lg transition-all transform hover:-translate-y-1">' +
                        '<div class="bg-gradient-to-br ' + colorFrom + ' ' + colorTo + ' p-6 text-white">' +
                        '<div class="flex items-center justify-between">' +
                        '<div class="w-16 h-16 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">' +
                        '<i class="fas ' + icon + ' text-3xl"></i>' +
                        '</div>' +
                        '<div class="text-right">' +
                        '<p class="text-4xl font-bold">' + doctorsCount + '</p>' +
                        '<p class="text-primary-100 text-sm">Médecins</p>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '<div class="p-6">' +
                        '<h3 class="text-xl font-bold text-gray-900 mb-2">' + specialtyName + '</h3>' +
                        '<p class="text-sm text-gray-600 mb-2"><strong>Code:</strong> ' + specialtyCode + '</p>' +
                        '<p class="text-sm text-gray-600 mb-4">' + specialtyDesc + '</p>' +
                        '<div class="flex items-center space-x-2">' +
                        '<button data-specialty-id="' + specialtyId + '" class="edit-specialty-btn flex-1 px-4 py-2 bg-blue-50 text-blue-600 rounded-lg font-semibold hover:bg-blue-100 transition-colors">' +
                        '<i class="fas fa-edit mr-2"></i>Modifier' +
                        '</button>' +
                        '<button data-specialty-id="' + specialtyId + '" data-specialty-name="' + specialtyName + '" class="delete-specialty-btn px-4 py-2 bg-red-50 text-red-600 rounded-lg font-semibold hover:bg-red-100 transition-colors">' +
                        '<i class="fas fa-trash"></i>' +
                        '</button>' +
                        '</div>' +
                        '</div>' +
                        '</div>';

                }).join('');

                this.attachEventListeners();
            },

            renderListView(specialties) {
                const listView = document.getElementById('listView');
                const tbody = listView.querySelector('tbody');
                if (!specialties || specialties.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="6" class="text-center py-8 text-gray-500">Aucune spécialité trouvée</td></tr>';
                    return;
                }
                tbody.innerHTML = specialties.map(specialty => {
                    var specialtyId = this.escapeHtml(specialty.id);
                    var specialtyName = this.escapeHtml(specialty.name);
                    var specialtyCode = this.escapeHtml(specialty.code);
                    var specialtyDesc = this.escapeHtml(specialty.description || '');
                    var doctorsCount = specialty.doctorsCount || 0;
                    var icon = specialty.icon || 'fa-stethoscope';
                    var color = specialty.color || 'primary';
                    var colorClass = 'text-' + color + '-500';
                    var satisfaction = specialty.satisfaction ? specialty.satisfaction : 'N/A';
                    var rdv = specialty.rdv ? specialty.rdv : 'N/A';
                    return '<tr class="hover:bg-gray-50 transition-colors">' +
                        '<td class="px-6 py-4 whitespace-nowrap">' +
                            '<div class="flex items-center">' +
                                '<div class="w-10 h-10 bg-gradient-to-br from-' + color + '-500 to-' + color + '-600 rounded-lg flex items-center justify-center text-white mr-3">' +
                                    '<i class="fas ' + icon + '"></i>' +
                                '</div>' +
                                '<div>' +
                                    '<div class="font-semibold text-gray-900">' + specialtyName + '</div>' +
                                    '<div class="text-sm text-gray-500">' + specialtyDesc + '</div>' +
                                '</div>' +
                            '</div>' +
                        '</td>' +
                        '<td class="px-6 py-4 whitespace-nowrap">' +
                            '<span class="px-3 py-1 text-xs font-bold rounded-full bg-' + color + '-100 text-' + color + '-700">' + doctorsCount + ' médecins</span>' +
                        '</td>' +
                        '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">' + (specialty.rdvPerMonth || 'N/A') + '</td>' +
                        '<td class="px-6 py-4 whitespace-nowrap">' +
                            '<div class="flex items-center">' +
                                '<i class="fas fa-star text-yellow-500 mr-1"></i>' +
                                '<span class="font-semibold text-gray-900">' + (specialty.satisfaction || 'N/A') + '</span>' +
                            '</div>' +
                        '</td>' +
                        '<td class="px-6 py-4 whitespace-nowrap text-sm space-x-2">' +
                            '<button data-specialty-id="' + specialtyId + '" class="edit-specialty-btn text-primary-600 hover:text-primary-700 font-semibold"><i class="fas fa-edit"></i></button>' +
                            '<button data-specialty-id="' + specialtyId + '" data-specialty-name="' + specialtyName + '" class="delete-specialty-btn text-red-600 hover:text-red-700 font-semibold"><i class="fas fa-trash"></i></button>' +
                        '</td>' +
                    '</tr>';
                }).join('');
                this.attachEventListeners();
            },

            attachEventListeners() {
                document.querySelectorAll('.edit-specialty-btn').forEach(btn => {
                    btn.addEventListener('click', (e) => {
                        this.editSpecialty(e.currentTarget.dataset.specialtyId);
                    });
                });

                document.querySelectorAll('.delete-specialty-btn').forEach(btn => {
                    btn.addEventListener('click', (e) => {
                        this.confirmDelete(e.currentTarget.dataset.specialtyId, e.currentTarget.dataset.specialtyName);
                    });
                });
            },

            editSpecialty(specialtyId) {
                // Find specialty in cache
                const specialty = this.state.specialtiesCache.find(s => s.id === specialtyId);
                if (!specialty) {
                    this.showToast('Spécialité non trouvée', 'error');
                    return;
                }
                
                // Open modal
                const modal = document.getElementById('specialtyModal');
                if (!modal) {
                    this.showToast('Modal non trouvé', 'error');
                    return;
                }
                
                // Set modal title
                document.getElementById('modalTitle').textContent = 'Modifier la spécialité';
                
                // Set specialtyId in hidden field
                document.getElementById('specialtyId').value = specialty.id;
                
                // Set form fields
                const codeInput = document.querySelector('input[name="code"]');
                const nameInput = document.querySelector('input[name="name"]');
                const descTextarea = document.querySelector('textarea[name="description"]');
                
                if (codeInput) codeInput.value = specialty.code || '';
                if (nameInput) nameInput.value = specialty.name || '';
                if (descTextarea) descTextarea.value = specialty.description || '';
                
                // Show modal
                modal.classList.remove('hidden');
            },

            confirmDelete(specialtyId, specialtyName) {
                Swal.fire({
                    title: 'Êtes-vous sûr ?',
                    text: 'Voulez-vous supprimer la spécialité "' + specialtyName + '" ? Cette action est irréversible.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Oui, supprimer',
                    cancelButtonText: 'Annuler'
                }).then((result) => {
                    if (result.isConfirmed) {
                        this.deleteSpecialty(specialtyId);
                    }
                });
            },


            async deleteSpecialty(specialtyId) {
                try {
                    const response = await fetch(this.state.contextPath + '/api/admin/specialties/' + specialtyId, {
                        method: 'DELETE'
                    });

                    if (response.ok) {
                        this.showToast('Spécialité supprimée avec succès', 'success');
                        this.loadSpecialties();
                    } else {
                        const data = await response.json();
                        throw new Error(data.message || 'Failed to delete specialty');
                    }
                } catch (error) {
                    this.showToast('Erreur: ' + error.message, 'error');
                }
            },

            showLoading(show) {
                // Add loading indicator if needed
            },

            showToast(message, type) {
                if (!type) type = 'success';
                const existing = document.getElementById('toast');
                if (existing) existing.remove();

                const toast = document.createElement('div');
                toast.id = 'toast';
                const colors = { success: 'bg-green-600', error: 'bg-red-600', info: 'bg-blue-600', warning: 'bg-orange-600' };
                const icons = { success: 'fa-check-circle', error: 'fa-times-circle', info: 'fa-info-circle', warning: 'fa-exclamation-triangle' };

                toast.className = 'fixed bottom-6 right-6 z-50 px-6 py-4 rounded-lg shadow-2xl text-white font-semibold flex items-center space-x-3 ' + colors[type];
                toast.innerHTML = '<i class="fas ' + icons[type] + ' text-xl"></i><span>' + this.escapeHtml(message) + '</span>';

                document.body.appendChild(toast);

                setTimeout(() => {
                    toast.classList.add('opacity-0', 'translate-x-full', 'transition-all');
                    setTimeout(() => toast.remove(), 300);
                }, 3000);
            },

            escapeHtml(text) {
                const div = document.createElement('div');
                div.textContent = text || '';
                return div.innerHTML;
            }
        };

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
        
        // Toggle view function
        function toggleView() {
            const cardView = document.getElementById('cardView');
            const listView = document.getElementById('listView');
            const viewText = document.getElementById('viewText');
            if (cardView.classList.contains('hidden')) {
                cardView.classList.remove('hidden');
                listView.classList.add('hidden');
                if (viewText) viewText.textContent = 'Vue liste';
            } else {
                cardView.classList.add('hidden');
                listView.classList.remove('hidden');
                if (viewText) viewText.textContent = 'Vue cartes';
                // Populate list view when shown
                specialtyManager.renderListView(specialtyManager.state.specialtiesCache);
            }
        }

        // Form submission handler
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('specialtyForm');
            if (form) {
                form.addEventListener('submit', function(e) {
                    e.preventDefault();
                    let fomeData = new FormData(form);
                    let specialtyId = document.getElementById('specialtyId').value;
                    let url = '${pageContext.request.contextPath}/admin/specialties';

                    
                    let data={
                        code: fomeData.get('code'),
                        name: fomeData.get('name'),
                        description: fomeData.get('description'),
                        icon: fomeData.get('icon'),
                        color: fomeData.get('color'),
                        isActive: fomeData.get('isActive')
                    }
                    console.log(data)

                    
                    fetch(url, {
                        method: 'POST',
                        body: fomeData
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.status === 'success') {
                            specialtyManager.showToast(data.message, 'success');
                            closeSpecialtyModal();
                            specialtyManager.loadSpecialties();
                        } else {
                            specialtyManager.showToast(data.message, 'error');
                        }
                    })
                    .catch((error) => {
                        console.error('Error:', error);
                        specialtyManager.showToast('Erreur lors de la sauvegarde', 'error');
                    });
                });
            }

            // Initialize specialty manager
            if (typeof specialtyManager !== 'undefined') {
                specialtyManager.init('${pageContext.request.contextPath}');
            }
        });
    </script>
</body>
</html>
