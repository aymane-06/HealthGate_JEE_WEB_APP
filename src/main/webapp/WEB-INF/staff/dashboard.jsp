<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - Personnel Clinique</title>
    
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
                        staff: {
                            50: '#faf5ff', 100: '#f3e8ff', 200: '#e9d5ff',
                            300: '#d8b4fe', 400: '#c084fc', 500: '#a855f7',
                            600: '#9333ea', 700: '#7e22ce', 800: '#6b21a8',
                            900: '#581c87',
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
        <aside class="w-64 bg-gradient-to-b from-staff-900 to-staff-800 text-white flex-shrink-0 hidden md:flex flex-col shadow-2xl">
            <div class="p-6 border-b border-staff-700">
                <div class="flex items-center space-x-3">
                    <i class="fas fa-hospital text-3xl text-staff-400"></i>
                    <div>
                        <h1 class="text-xl font-bold">Clinique</h1>
                        <p class="text-xs text-staff-200">Espace Personnel</p>
                    </div>
                </div>
            </div>
            
            <div class="p-6 border-b border-staff-700">
                <div class="flex items-center space-x-3">
                    <div class="w-12 h-12 bg-gradient-to-br from-staff-500 to-staff-600 rounded-full flex items-center justify-center text-white font-bold text-lg shadow-lg">
                        ${sessionScope.user.firstName.substring(0,1)}${sessionScope.user.lastName.substring(0,1)}
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="font-semibold truncate">${sessionScope.user.firstName} ${sessionScope.user.lastName}</p>
                        <p class="text-xs text-staff-200 truncate">Personnel</p>
                    </div>
                </div>
            </div>
            
            <nav class="flex-1 p-4 overflow-y-auto">
                <ul class="space-y-2">
                    <li>
                        <a href="${pageContext.request.contextPath}/staff/dashboard" class="flex items-center space-x-3 p-3 rounded-lg bg-staff-700/50 text-white">
                            <i class="fas fa-chart-line w-5"></i>
                            <span class="font-medium">Accueil</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/staff/waiting-list" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-staff-700/30 transition-colors text-staff-100 hover:text-white">
                            <i class="fas fa-users w-5"></i>
                            <span class="font-medium">Salle d'attente</span>
                            <span class="ml-auto bg-red-500 text-white text-xs px-2 py-1 rounded-full">5</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/staff/appointments" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-staff-700/30 transition-colors text-staff-100 hover:text-white">
                            <i class="fas fa-calendar-alt w-5"></i>
                            <span class="font-medium">Rendez-vous</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/staff/patients" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-staff-700/30 transition-colors text-staff-100 hover:text-white">
                            <i class="fas fa-user-injured w-5"></i>
                            <span class="font-medium">Patients</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/staff/doctors" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-staff-700/30 transition-colors text-staff-100 hover:text-white">
                            <i class="fas fa-user-md w-5"></i>
                            <span class="font-medium">Médecins</span>
                        </a>
                    </li>
                </ul>
                
                <div class="mt-6 pt-6 border-t border-staff-700">
                    <ul class="space-y-2">
                        <li>
                            <a href="${pageContext.request.contextPath}/profile" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-staff-700/30 transition-colors text-staff-100 hover:text-white">
                                <i class="fas fa-user-circle w-5"></i>
                                <span class="font-medium">Mon Profil</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/logout" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-red-600/80 transition-colors text-staff-100 hover:text-white">
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
                            <h2 class="text-2xl font-bold text-gray-900">Tableau de bord - Accueil</h2>
                            <p class="text-sm text-gray-500">Gestion de la réception et des rendez-vous</p>
                        </div>
                    </div>
                    
                    <div class="flex items-center space-x-4">
                        <div class="text-sm text-gray-600">
                            <i class="far fa-clock mr-2"></i>
                            <span id="current-time" class="font-semibold"></span>
                        </div>
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
                
                <!-- Stats Cards -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                    <div class="bg-gradient-to-br from-staff-500 to-staff-600 rounded-2xl shadow-lg p-6 text-white transform hover:scale-105 transition-transform">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-calendar-check text-2xl"></i>
                            </div>
                            <span class="text-sm font-semibold bg-white/20 px-3 py-1 rounded-full">Aujourd'hui</span>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">23</h3>
                        <p class="text-staff-100">Rendez-vous</p>
                    </div>
                    
                    <div class="bg-gradient-to-br from-red-500 to-red-600 rounded-2xl shadow-lg p-6 text-white transform hover:scale-105 transition-transform">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-users text-2xl"></i>
                            </div>
                            <span class="text-sm font-semibold bg-white/20 px-3 py-1 rounded-full animate-pulse">En attente</span>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">5</h3>
                        <p class="text-red-100">Patients</p>
                    </div>
                    
                    <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-2xl shadow-lg p-6 text-white transform hover:scale-105 transition-transform">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-check-circle text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">15</h3>
                        <p class="text-green-100">Consultations terminées</p>
                    </div>
                    
                    <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl shadow-lg p-6 text-white transform hover:scale-105 transition-transform">
                        <div class="flex items-center justify-between mb-4">
                            <div class="bg-white/20 p-3 rounded-xl">
                                <i class="fas fa-user-md text-2xl"></i>
                            </div>
                        </div>
                        <h3 class="text-4xl font-bold mb-1">8</h3>
                        <p class="text-blue-100">Médecins disponibles</p>
                    </div>
                </div>
                
                <!-- Waiting Room & Today's Appointments -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
                    <!-- Waiting Room -->
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100">
                        <div class="p-6 border-b border-gray-100 flex items-center justify-between">
                            <div>
                                <h3 class="text-lg font-bold text-gray-900">Salle d'attente</h3>
                                <p class="text-sm text-gray-500">5 patients en attente</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/staff/waiting-list" class="text-sm font-semibold text-staff-600 hover:text-staff-700">
                                Gérer <i class="fas fa-arrow-right ml-1"></i>
                            </a>
                        </div>
                        <div class="p-6 space-y-3 max-h-96 overflow-y-auto">
                            <div class="flex items-center space-x-4 p-4 bg-gradient-to-r from-red-50 to-red-100 border-l-4 border-red-500 rounded-xl">
                                <div class="w-12 h-12 bg-gradient-to-br from-red-500 to-red-600 rounded-full flex items-center justify-center text-white font-bold text-lg">
                                    AB
                                </div>
                                <div class="flex-1">
                                    <p class="font-bold text-gray-900">Ahmed Benali</p>
                                    <p class="text-sm text-gray-600">Dr. Alami - 14:30</p>
                                    <p class="text-xs text-red-600 font-semibold mt-1">En attente: 15 min</p>
                                </div>
                                <button class="px-4 py-2 bg-staff-600 text-white rounded-lg hover:bg-staff-700 transition-colors text-sm font-semibold">
                                    Appeler
                                </button>
                            </div>
                            
                            <div class="flex items-center space-x-4 p-4 bg-gradient-to-r from-yellow-50 to-yellow-100 border-l-4 border-yellow-500 rounded-xl">
                                <div class="w-12 h-12 bg-gradient-to-br from-yellow-500 to-yellow-600 rounded-full flex items-center justify-center text-white font-bold text-lg">
                                    FK
                                </div>
                                <div class="flex-1">
                                    <p class="font-bold text-gray-900">Fatima Khalil</p>
                                    <p class="text-sm text-gray-600">Dr. Bennani - 15:00</p>
                                    <p class="text-xs text-yellow-600 font-semibold mt-1">En attente: 8 min</p>
                                </div>
                                <button class="px-4 py-2 bg-staff-600 text-white rounded-lg hover:bg-staff-700 transition-colors text-sm font-semibold">
                                    Appeler
                                </button>
                            </div>
                            
                            <div class="flex items-center space-x-4 p-4 bg-gradient-to-r from-green-50 to-green-100 border-l-4 border-green-500 rounded-xl">
                                <div class="w-12 h-12 bg-gradient-to-br from-green-500 to-green-600 rounded-full flex items-center justify-center text-white font-bold text-lg">
                                    MY
                                </div>
                                <div class="flex-1">
                                    <p class="font-bold text-gray-900">Mohamed Youssef</p>
                                    <p class="text-sm text-gray-600">Dr. Idrissi - 15:15</p>
                                    <p class="text-xs text-green-600 font-semibold mt-1">Vient d'arriver</p>
                                </div>
                                <button class="px-4 py-2 bg-staff-600 text-white rounded-lg hover:bg-staff-700 transition-colors text-sm font-semibold">
                                    Appeler
                                </button>
                            </div>
                        </div>
                        <div class="p-6 border-t border-gray-100">
                            <button class="w-full bg-staff-600 text-white rounded-lg py-3 font-semibold hover:bg-staff-700 transition-colors">
                                <i class="fas fa-user-plus mr-2"></i>Enregistrer un patient
                            </button>
                        </div>
                    </div>
                    
                    <!-- Quick Actions -->
                    <div class="space-y-6">
                        <div class="bg-gradient-to-br from-staff-600 to-staff-700 rounded-2xl shadow-lg p-6 text-white">
                            <h3 class="text-lg font-bold mb-4">Actions rapides</h3>
                            <div class="grid grid-cols-2 gap-3">
                                <button class="bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl p-4 text-center transition-all">
                                    <i class="fas fa-calendar-plus text-2xl mb-2"></i>
                                    <p class="text-sm font-semibold">Nouveau RDV</p>
                                </button>
                                <button class="bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl p-4 text-center transition-all">
                                    <i class="fas fa-user-plus text-2xl mb-2"></i>
                                    <p class="text-sm font-semibold">Ajouter Patient</p>
                                </button>
                                <button class="bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl p-4 text-center transition-all">
                                    <i class="fas fa-phone text-2xl mb-2"></i>
                                    <p class="text-sm font-semibold">Appeler Patient</p>
                                </button>
                                <button class="bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl p-4 text-center transition-all">
                                    <i class="fas fa-file-invoice text-2xl mb-2"></i>
                                    <p class="text-sm font-semibold">Générer Facture</p>
                                </button>
                            </div>
                        </div>
                        
                        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                            <h3 class="text-lg font-bold text-gray-900 mb-4">Disponibilité des médecins</h3>
                            <div class="space-y-3">
                                <div class="flex items-center justify-between p-3 bg-green-50 rounded-lg">
                                    <div class="flex items-center space-x-3">
                                        <div class="w-2 h-2 bg-green-500 rounded-full animate-pulse"></div>
                                        <div>
                                            <p class="font-semibold text-gray-900">Dr. Alami</p>
                                            <p class="text-xs text-gray-500">Cardiologue</p>
                                        </div>
                                    </div>
                                    <span class="text-xs font-semibold text-green-700 bg-green-100 px-3 py-1 rounded-full">Disponible</span>
                                </div>
                                <div class="flex items-center justify-between p-3 bg-orange-50 rounded-lg">
                                    <div class="flex items-center space-x-3">
                                        <div class="w-2 h-2 bg-orange-500 rounded-full animate-pulse"></div>
                                        <div>
                                            <p class="font-semibold text-gray-900">Dr. Bennani</p>
                                            <p class="text-xs text-gray-500">Neurologue</p>
                                        </div>
                                    </div>
                                    <span class="text-xs font-semibold text-orange-700 bg-orange-100 px-3 py-1 rounded-full">En consultation</span>
                                </div>
                                <div class="flex items-center justify-between p-3 bg-green-50 rounded-lg">
                                    <div class="flex items-center space-x-3">
                                        <div class="w-2 h-2 bg-green-500 rounded-full animate-pulse"></div>
                                        <div>
                                            <p class="font-semibold text-gray-900">Dr. Idrissi</p>
                                            <p class="text-xs text-gray-500">Généraliste</p>
                                        </div>
                                    </div>
                                    <span class="text-xs font-semibold text-green-700 bg-green-100 px-3 py-1 rounded-full">Disponible</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Today's Appointments Schedule -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100">
                    <div class="p-6 border-b border-gray-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <h3 class="text-lg font-bold text-gray-900">Planning du jour</h3>
                                <p class="text-sm text-gray-500">Mercredi 12 Octobre 2024</p>
                            </div>
                            <div class="flex items-center space-x-2">
                                <button class="px-4 py-2 border border-gray-300 rounded-lg text-sm font-semibold hover:bg-gray-50 transition-colors">
                                    <i class="fas fa-print mr-2"></i>Imprimer
                                </button>
                                <button class="px-4 py-2 bg-staff-600 text-white rounded-lg text-sm font-semibold hover:bg-staff-700 transition-colors">
                                    <i class="fas fa-filter mr-2"></i>Filtrer
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Heure</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Patient</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Médecin</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Type</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Statut</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-gray-900">09:00</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="w-8 h-8 bg-gradient-to-br from-staff-500 to-staff-600 rounded-full flex items-center justify-center text-white text-xs font-bold mr-3">
                                                SK
                                            </div>
                                            <div>
                                                <div class="font-medium text-gray-900">Sara Khalil</div>
                                                <div class="text-sm text-gray-500">0612345678</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">Dr. Alami</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-3 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-700">Consultation</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-3 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-700">Terminé</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm space-x-2">
                                        <button class="text-staff-600 hover:text-staff-700 font-semibold">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="text-blue-600 hover:text-blue-700 font-semibold">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr class="hover:bg-gray-50 transition-colors bg-yellow-50">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-gray-900">14:30</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="w-8 h-8 bg-gradient-to-br from-red-500 to-red-600 rounded-full flex items-center justify-center text-white text-xs font-bold mr-3">
                                                AB
                                            </div>
                                            <div>
                                                <div class="font-medium text-gray-900">Ahmed Benali</div>
                                                <div class="text-sm text-gray-500">0623456789</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">Dr. Alami</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-3 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-700">Contrôle</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-3 py-1 text-xs font-semibold rounded-full bg-orange-100 text-orange-700 animate-pulse">En cours</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm space-x-2">
                                        <button class="text-staff-600 hover:text-staff-700 font-semibold">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="text-blue-600 hover:text-blue-700 font-semibold">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-gray-900">15:00</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="w-8 h-8 bg-gradient-to-br from-yellow-500 to-yellow-600 rounded-full flex items-center justify-center text-white text-xs font-bold mr-3">
                                                FK
                                            </div>
                                            <div>
                                                <div class="font-medium text-gray-900">Fatima Khalil</div>
                                                <div class="text-sm text-gray-500">0634567890</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">Dr. Bennani</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-3 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-700">Consultation</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-3 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-700">Confirmé</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm space-x-2">
                                        <button class="text-staff-600 hover:text-staff-700 font-semibold">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="text-blue-600 hover:text-blue-700 font-semibold">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
            </main>
        </div>
    </div>
    
    <script>
        // Update current time
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleTimeString('fr-FR', { 
                hour: '2-digit', 
                minute: '2-digit',
                second: '2-digit'
            });
            document.getElementById('current-time').textContent = timeString;
        }
        updateTime();
        setInterval(updateTime, 1000);
    </script>
</body>
</html>
