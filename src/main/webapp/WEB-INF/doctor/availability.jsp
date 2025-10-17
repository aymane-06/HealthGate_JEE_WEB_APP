<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes disponibilités - Clinique Digitale</title>

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

        .calendar-day {
            transition: all 0.2s ease-in-out;
        }

        .calendar-day:hover {
            transform: scale(1.05);
        }

        .time-slot {
            transition: all 0.2s ease-in-out;
        }

        .time-slot:hover {
            transform: translateY(-2px);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-fade-in {
            animation: fadeIn 0.3s ease-out;
        }
    </style>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">

    <!-- Sidebar -->
    <aside class="w-64 bg-gradient-to-b from-secondary-900 to-secondary-800 text-white flex-shrink-0 hidden md:flex flex-col shadow-2xl">
        <!-- Logo -->
        <div class="p-6 border-b border-secondary-700">
            <div class="flex items-center space-x-3">
                <i class="fas fa-hospital text-3xl text-secondary-400"></i>
                <div>
                    <h1 class="text-xl font-bold">Clinique</h1>
                    <p class="text-xs text-secondary-200">Espace Médecin</p>
                </div>
            </div>
        </div>

        <!-- User Profile -->
        <div class="p-6 border-b border-secondary-700">
            <div class="flex items-center space-x-3">
                <div class="w-12 h-12 bg-gradient-to-br from-primary-500 to-primary-600 rounded-full flex items-center justify-center text-white font-bold text-lg shadow-lg">
                    DR
                </div>
                <div class="flex-1 min-w-0">
                    <p class="font-semibold truncate">Dr. ${sessionScope.user.firstName} ${sessionScope.user.lastName}</p>
                    <p class="text-xs text-secondary-200 truncate">${sessionScope.user.specialty != null ? sessionScope.user.specialty.name : 'Médecin'}</p>
                </div>
            </div>
        </div>

        <!-- Navigation -->
        <nav class="flex-1 p-4 overflow-y-auto">
            <ul class="space-y-2">
                <li>
                    <a href="${pageContext.request.contextPath}/doctor/dashboard" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-secondary-700/30 transition-colors text-secondary-100 hover:text-white">
                        <i class="fas fa-chart-line w-5"></i>
                        <span class="font-medium">Tableau de bord</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/doctor/appointments" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-secondary-700/30 transition-colors text-secondary-100 hover:text-white">
                        <i class="fas fa-calendar-alt w-5"></i>
                        <span class="font-medium">Mes Rendez-vous</span>
                        <span class="ml-auto bg-red-500 text-white text-xs px-2 py-1 rounded-full">8</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/doctor/patients" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-secondary-700/30 transition-colors text-secondary-100 hover:text-white">
                        <i class="fas fa-hospital-user w-5"></i>
                        <span class="font-medium">Mes Patients</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/doctor/availability" class="flex items-center space-x-3 p-3 rounded-lg bg-secondary-700/50 text-white">
                        <i class="fas fa-clock w-5"></i>
                        <span class="font-medium">Disponibilités</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/doctor/consultations" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-secondary-700/30 transition-colors text-secondary-100 hover:text-white">
                        <i class="fas fa-notes-medical w-5"></i>
                        <span class="font-medium">Consultations</span>
                    </a>
                </li>
            </ul>

            <div class="mt-6 pt-6 border-t border-secondary-700">
                <ul class="space-y-2">
                    <li>
                        <a href="${pageContext.request.contextPath}/profile" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-secondary-700/30 transition-colors text-secondary-100 hover:text-white">
                            <i class="fas fa-user-circle w-5"></i>
                            <span class="font-medium">Mon Profil</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/logout" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-red-600/80 transition-colors text-secondary-100 hover:text-white">
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
                        <h2 class="text-2xl font-bold text-gray-900">Gestion des Disponibilités</h2>
                        <p class="text-sm text-gray-500">Planifiez vos créneaux de consultation</p>
                    </div>
                </div>

                <div class="flex items-center space-x-4">
                    <div class="hidden sm:flex items-center space-x-2 bg-gray-100 rounded-lg px-4 py-2">
                        <i class="fas fa-calendar text-secondary-600"></i>
                        <span class="text-sm font-medium text-gray-700" id="currentDate">Lundi 07 Oct 2024</span>
                    </div>
                    <button onclick="openAddAvailabilityModal()" class="flex items-center space-x-2 bg-secondary-600 hover:bg-secondary-700 text-white rounded-lg px-4 py-2 font-semibold transition-colors shadow-lg shadow-secondary-600/30">
                        <i class="fas fa-plus"></i>
                        <span>Nouvelle Disponibilité</span>
                    </button>
                </div>
            </div>
        </header>

        <!-- Main Content Area -->
        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">

            <!-- Stats Cards -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                <div class="bg-gradient-to-br from-secondary-500 to-secondary-600 rounded-2xl shadow-lg p-6 text-white transform hover:scale-105 transition-transform">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-white/20 p-3 rounded-xl">
                            <i class="fas fa-clock text-2xl"></i>
                        </div>
                    </div>
                    <h3 class="text-4xl font-bold mb-1">12</h3>
                    <p class="text-secondary-100">Créneaux cette semaine</p>
                </div>

                <div class="bg-gradient-to-br from-primary-500 to-primary-600 rounded-2xl shadow-lg p-6 text-white transform hover:scale-105 transition-transform">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-white/20 p-3 rounded-xl">
                            <i class="fas fa-calendar-check text-2xl"></i>
                        </div>
                    </div>
                    <h3 class="text-4xl font-bold mb-1">85%</h3>
                    <p class="text-primary-100">Taux de remplissage</p>
                </div>

                <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl shadow-lg p-6 text-white transform hover:scale-105 transition-transform">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-white/20 p-3 rounded-xl">
                            <i class="fas fa-user-md text-2xl"></i>
                        </div>
                    </div>
                    <h3 class="text-4xl font-bold mb-1">4.2h</h3>
                    <p class="text-purple-100">Moyenne quotidienne</p>
                </div>

                <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-2xl shadow-lg p-6 text-white transform hover:scale-105 transition-transform">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-white/20 p-3 rounded-xl">
                            <i class="fas fa-ban text-2xl"></i>
                        </div>
                    </div>
                    <h3 class="text-4xl font-bold mb-1">3</h3>
                    <p class="text-orange-100">Jours de congé</p>
                </div>
            </div>

            <!-- Calendar & Availability Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">
                <!-- Calendar Section -->
                <div class="lg:col-span-2">
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                        <div class="p-6 border-b border-gray-100">
                            <div class="flex items-center justify-between">
                                <h3 class="text-lg font-bold text-gray-900">Disponibilités Hebdomadaires</h3>
                            </div>
                        </div>
                        <div class="p-6">
                            <!-- Weekly availability table -->
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                        <tr>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Jour</th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Heure d'ouverture</th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Heure de fermeture</th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Statut</th>
                                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbody" class="bg-white divide-y divide-gray-100">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions & Recurring Availability -->
                <div class="space-y-6">
                    <!-- Quick Actions -->
                    <div class="bg-gradient-to-br from-primary-600 to-primary-700 rounded-2xl shadow-lg p-6 text-white">
                        <h3 class="text-lg font-bold mb-4">Actions Rapides</h3>
                        <div class="space-y-3">
                            <button onclick="openAddAvailabilityModal()" class="w-full bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl p-3 text-left transition-all">
                                <i class="fas fa-plus-circle mr-3"></i>
                                Ajouter un créneau
                            </button>
                            <button onclick="openRecurringModal()" class="w-full bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl p-3 text-left transition-all">
                                <i class="fas fa-redo mr-3"></i>
                                Disponibilité récurrente
                            </button>
                            <button onclick="openAbsenceModal()" class="w-full bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl p-3 text-left transition-all">
                                <i class="fas fa-ban mr-3"></i>
                                Déclarer une absence
                            </button>
                            <button class="w-full bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl p-3 text-left transition-all">
                                <i class="fas fa-download mr-3"></i>
                                Exporter planning
                            </button>
                        </div>
                    </div>

                    <!-- Today's Availability -->
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                        <h3 class="text-lg font-bold text-gray-900 mb-4">Aujourd'hui</h3>
                        <div class="space-y-3">
                            <div class="time-slot bg-green-50 border border-green-200 rounded-xl p-4 hover:shadow-md transition-all">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <span class="font-semibold text-green-700">08:00 - 10:00</span>
                                        <p class="text-sm text-gray-600">Consultations matin</p>
                                    </div>
                                    <span class="px-2 py-1 bg-green-100 text-green-700 text-xs font-semibold rounded-full">3/4 RDV</span>
                                </div>
                            </div>
                            <div class="time-slot bg-blue-50 border border-blue-200 rounded-xl p-4 hover:shadow-md transition-all">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <span class="font-semibold text-blue-700">14:00 - 16:00</span>
                                        <p class="text-sm text-gray-600">Consultations après-midi</p>
                                    </div>
                                    <span class="px-2 py-1 bg-blue-100 text-blue-700 text-xs font-semibold rounded-full">1/4 RDV</span>
                                </div>
                            </div>
                            <div class="time-slot bg-gray-100 border border-gray-300 rounded-xl p-4">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <span class="font-semibold text-gray-700">16:00 - 17:00</span>
                                        <p class="text-sm text-gray-600">Pause administrative</p>
                                    </div>
                                    <span class="px-2 py-1 bg-gray-200 text-gray-700 text-xs font-semibold rounded-full">Indisponible</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recurring Availability & Absences -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <!-- Recurring Availability -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                    <div class="p-6 border-b border-gray-100">
                        <h3 class="text-lg font-bold text-gray-900">Disponibilités Récurrentes</h3>
                    </div>
                    <div class="p-6 space-y-4">
                        <div class="flex items-center justify-between p-4 bg-primary-50 border border-primary-200 rounded-xl hover:shadow-md transition-all">
                            <div class="flex items-center space-x-4">
                                <div class="w-12 h-12 bg-primary-600 rounded-lg flex items-center justify-center text-white font-bold">
                                    LU
                                </div>
                                <div>
                                    <p class="font-semibold text-gray-900">Lundi</p>
                                    <p class="text-sm text-gray-600">08:00 - 12:00 & 14:00 - 18:00</p>
                                </div>
                            </div>
                            <button class="p-2 text-red-600 hover:bg-red-100 rounded-lg transition-colors">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>

                        <div class="flex items-center justify-between p-4 bg-secondary-50 border border-secondary-200 rounded-xl hover:shadow-md transition-all">
                            <div class="flex items-center space-x-4">
                                <div class="w-12 h-12 bg-secondary-600 rounded-lg flex items-center justify-center text-white font-bold">
                                    ME
                                </div>
                                <div>
                                    <p class="font-semibold text-gray-900">Mercredi</p>
                                    <p class="text-sm text-gray-600">09:00 - 13:00 & 15:00 - 19:00</p>
                                </div>
                            </div>
                            <button class="p-2 text-red-600 hover:bg-red-100 rounded-lg transition-colors">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>

                        <div class="flex items-center justify-between p-4 bg-purple-50 border border-purple-200 rounded-xl hover:shadow-md transition-all">
                            <div class="flex items-center space-x-4">
                                <div class="w-12 h-12 bg-purple-600 rounded-lg flex items-center justify-center text-white font-bold">
                                    VE
                                </div>
                                <div>
                                    <p class="font-semibold text-gray-900">Vendredi</p>
                                    <p class="text-sm text-gray-600">08:30 - 12:30</p>
                                </div>
                            </div>
                            <button class="p-2 text-red-600 hover:bg-red-100 rounded-lg transition-colors">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Absences & Time Off -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                    <div class="p-6 border-b border-gray-100">
                        <div class="flex items-center justify-between">
                            <h3 class="text-lg font-bold text-gray-900">Congés & Absences</h3>
                            <button onclick="openAbsenceModal()" class="px-4 py-2 bg-yellow-500 hover:bg-yellow-600 text-white rounded-lg font-semibold transition-colors">
                                <i class="fas fa-plus mr-2"></i>Ajouter
                            </button>
                        </div>
                    </div>
                    <div class="p-6 space-y-4">
                        <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4 rounded-xl hover:shadow-md transition-all">
                            <div class="flex items-center justify-between mb-2">
                                <span class="font-semibold text-yellow-700">20 - 22 Oct 2024</span>
                                <span class="px-2 py-1 bg-yellow-100 text-yellow-700 text-xs font-semibold rounded-full">Congé</span>
                            </div>
                            <p class="text-sm text-gray-700">Congé annuel</p>
                            <p class="text-xs text-gray-500 mt-1">3 jours</p>
                        </div>

                        <div class="bg-orange-50 border-l-4 border-orange-400 p-4 rounded-xl hover:shadow-md transition-all">
                            <div class="flex items-center justify-between mb-2">
                                <span class="font-semibold text-orange-700">01 - 03 Nov 2024</span>
                                <span class="px-2 py-1 bg-orange-100 text-orange-700 text-xs font-semibold rounded-full">Formation</span>
                            </div>
                            <p class="text-sm text-gray-700">Conférence médicale internationale</p>
                            <p class="text-xs text-gray-500 mt-1">3 jours</p>
                        </div>

                        <div class="bg-red-50 border-l-4 border-red-400 p-4 rounded-xl hover:shadow-md transition-all">
                            <div class="flex items-center justify-between mb-2">
                                <span class="font-semibold text-red-700">15 Déc 2024</span>
                                <span class="px-2 py-1 bg-red-100 text-red-700 text-xs font-semibold rounded-full">Urgence</span>
                            </div>
                            <p class="text-sm text-gray-700">Absence exceptionnelle</p>
                            <p class="text-xs text-gray-500 mt-1">1 jour</p>
                        </div>
                    </div>
                </div>
            </div>

        </main>
    </div>
</div>

<!-- Add Availability Modal -->
<div id="addAvailabilityModal" class="hidden fixed inset-0 z-50 overflow-y-auto">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="fixed inset-0 bg-gray-900/50" onclick="closeAddAvailabilityModal()"></div>

        <div class="relative bg-white rounded-2xl shadow-2xl max-w-md w-full z-10 animate-fade-in">
            <div class="bg-gradient-to-r from-primary-600 to-primary-700 p-6 text-white rounded-t-2xl">
                <div class="flex items-center justify-between">
                    <h3 class="text-xl font-bold">Ajouter une Disponibilité</h3>
                    <button onclick="closeAddAvailabilityModal()" class="text-white hover:text-gray-200 transition-colors">
                        <i class="fas fa-times text-xl"></i>
                    </button>
                </div>
            </div>

            <form class="p-6 space-y-4">
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-2">Date</label>
                    <input type="date" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Heure de début</label>
                        <input type="time" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                    </div>
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Heure de fin</label>
                        <input type="time" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-2">Type de créneau</label>
                    <select class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all">
                        <option value="consultation">Consultation standard</option>
                        <option value="emergency">Urgence</option>
                        <option value="surgery">Chirurgie</option>
                        <option value="followup">Suivi</option>
                    </select>
                </div>

                <div class="flex items-center justify-end space-x-3 pt-4">
                    <button type="button" onclick="closeAddAvailabilityModal()" class="px-6 py-3 border border-gray-300 rounded-lg font-semibold hover:bg-gray-50 transition-colors">
                        Annuler
                    </button>
                    <button type="submit" class="px-6 py-3 bg-primary-600 hover:bg-primary-700 text-white rounded-lg font-semibold transition-colors">
                        <i class="fas fa-save mr-2"></i>Enregistrer
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Day Modal -->
<div id="editDayModal" class="hidden fixed inset-0 z-50 overflow-y-auto">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="fixed inset-0 bg-gray-900/50" onclick="closeEditDayModal()"></div>
        <div class="relative bg-white rounded-2xl shadow-2xl max-w-md w-full z-10 animate-fade-in">
            <div class="bg-gradient-to-r from-primary-600 to-primary-700 p-6 text-white rounded-t-2xl">
                <div class="flex items-center justify-between">
                    <h3 class="text-xl font-bold" id="editDayModalTitle">Éditer la Disponibilité</h3>
                    <button onclick="closeEditDayModal()" class="text-white hover:text-gray-200 transition-colors">
                        <i class="fas fa-times text-xl"></i>
                    </button>
                </div>
            </div>
            <form id="editDayForm" class="p-6 space-y-4">
                <input type="hidden" name="availabilityId" id="availabilityId">
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-2">Jour</label>
                    <input type="text" id="editDayDisplay" class="w-full px-4 py-3 border border-gray-300 rounded-lg bg-gray-100" readonly>
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Heure d'ouverture</label>
                        <input type="time" name="startTime" id="editDayStart" class="w-full px-4 py-3 border border-gray-300 rounded-lg" required>
                    </div>
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">Heure de fermeture</label>
                        <input type="time" name="endTime" id="editDayEnd" class="w-full px-4 py-3 border border-gray-300 rounded-lg" required>
                    </div>
                </div>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-2">Statut</label>
                    <select id="editDayStatus" name="status" class="w-full px-4 py-3 border border-gray-300 rounded-lg">
                        <option value="AVAILABLE">Disponible</option>
                        <option value="ON_LEAVE">En congé</option>
                        <option value="UNAVAILABLE">Indisponible</option>
                    </select>
                </div>
                <div class="flex items-center justify-end space-x-3 pt-4">
                    <button type="button" onclick="closeEditDayModal()" class="px-6 py-3 border border-gray-300 rounded-lg font-semibold hover:bg-gray-50 transition-colors">
                        Annuler
                    </button>
                    <button type="submit" class="px-6 py-3 bg-primary-600 hover:bg-primary-700 text-white rounded-lg font-semibold transition-colors">
                        <i class="fas fa-save mr-2"></i>Enregistrer
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Modal functions
    function openAddAvailabilityModal() {
        document.getElementById('addAvailabilityModal').classList.remove('hidden');
    }

    function closeAddAvailabilityModal() {
        document.getElementById('addAvailabilityModal').classList.add('hidden');
    }

    function openRecurringModal() {
        alert('Modal pour les disponibilités récurrentes à implémenter');
    }

    function openAbsenceModal() {
        alert('Modal pour les absences à implémenter');
    }

    function openEditDayModal(id,day, startTime, endTime, status) {
        document.getElementById('editDayModal').classList.remove('hidden');
        document.getElementById('availabilityId').value = id;
        document.getElementById('editDayDisplay').value = day;
        document.getElementById('editDayStart').value = startTime !== '-' ? startTime : '';
        document.getElementById('editDayEnd').value = endTime !== '-' ? endTime : '';
        document.getElementById('editDayStatus').value = status;
    }
    function closeEditDayModal() {
        document.getElementById('editDayModal').classList.add('hidden');
    }

    function showToast(message, type) {
        // Remove any existing toast
        const oldToast = document.getElementById('customToast');
        if (oldToast) oldToast.remove();

        // Create toast container
        const toast = document.createElement('div');
        toast.id = 'customToast';

        // Determine icon and color based on type
        var icon, color;
        if (type === 'success') {
            icon = 'fa-check-circle';
            color = 'bg-green-600';
        } else if (type === 'error') {
            icon = 'fa-exclamation-circle';
            color = 'bg-red-600';
        } else if (type === 'warning') {
            icon = 'fa-exclamation-triangle';
            color = 'bg-yellow-600';
        } else {
            icon = 'fa-info-circle';
            color = 'bg-blue-600';
        }

        toast.className = 'fixed top-6 right-6 z-[9999] px-6 py-4 rounded-lg shadow-lg text-white font-semibold flex items-center space-x-3 animate-fade-in ' + color;

        toast.innerHTML =
            '<i class="fas ' + icon + ' text-xl"></i>' +
            '<span>' + message + '</span>';

        document.body.appendChild(toast);

        // Auto remove after 3 seconds
        setTimeout(function() {
            toast.classList.add('opacity-0', 'transition-opacity', 'duration-500');
            setTimeout(function() {
                if (toast.parentNode) {
                    toast.remove();
                }
            }, 500);
        }, 3000);
    }

    document.getElementById('editDayForm').addEventListener('submit', async function (e) {
        e.preventDefault();
        let formData = new FormData(this);
        console.log(formData.get('availabilityId'));
        console.log(formData.get('startTime'));
        console.log(formData.get('endTime'));
        console.log(formData.get('status'));

        try{

        let res = await fetch('${pageContext.request.contextPath}/api/doctor/availabilities/' + formData.get('availabilityId'), {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                startTime: formData.get('startTime'),
                endTime: formData.get('endTime'),
                status: formData.get('status')
            })
        });
        let data = await res.json();
            console.log(data);
        if (data.status !== 'success') {
            throw new Error(data.message || 'Erreur lors de la mise à jour');
        }
        getAvailabilities();
        showToast('Disponibilité modifiée avec succès', 'success');
        } catch (error) {
            showToast(error.message, 'error');
            return;
        }

        closeEditDayModal();
        showToast('Disponibilité modifiée avec succès', 'success');
    });

    // Set current date
    document.addEventListener('DOMContentLoaded', function() {
        const now = new Date();
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        document.getElementById('currentDate').textContent = now.toLocaleDateString('fr-FR', options);
    });

    // Mobile menu toggle
    const menuToggle = document.getElementById('menu-toggle');
    if (menuToggle) {
        menuToggle.addEventListener('click', () => {
            alert('Menu mobile à implémenter');
        });
    }
    async function getAvailabilities() {
        let availabilities = [];
        let contexPath= '${pageContext.request.contextPath}';
            console.log(contexPath);
        let userId = '${sessionScope.userID}';
            console.log(userId);
        try {
            let response = await fetch('${pageContext.request.contextPath}/api/doctor/availabilities/${sessionScope.userID}', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            let data = await response.json();
            console.log(data);
            if (data.status === 'success') {
                availabilities = data.data;
                console.log(availabilities);
                renderAvailabilities(availabilities)
            } else {
                throw new Error(data.message || 'Failed to fetch availabilities');
            }
        } catch (error) {
            showToast(error.message, 'error');
            return [];
        }
    }
    getAvailabilities();

    function renderAvailabilities(availabilities) {
        let weekDaysOrder = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
        availabilities.sort((a, b) => {
            return weekDaysOrder.indexOf(a.day) - weekDaysOrder.indexOf(b.day);
        });
        const tbody = document.querySelector('table tbody');
        tbody.innerHTML = ''; // Clear existing rows

        availabilities.forEach(function(avail) {
            const tr = document.createElement('tr');
            tr.className = 'hover:bg-primary-50 transition-all';

            const statusColors = {
                'AVAILABLE': ['bg-green-100', 'text-green-700', 'border-green-200'],
                'ON_LEAVE': ['bg-yellow-100', 'text-yellow-700', 'border-yellow-200'],
                'UNAVAILABLE': ['bg-red-100', 'text-red-700', 'border-red-200']
            };

            // Use enum values from your backend
            const statusText = {
                'AVAILABLE': 'Disponible',
                'ON_LEAVE': 'En congé',
                'UNAVAILABLE': 'Indisponible'
            };

            const statusKey = avail.status || 'UNAVAILABLE';
            const [bgClass, textClass, borderClass] = statusColors[statusKey] || ['bg-gray-100', 'text-gray-700', 'border-gray-200'];
            const displayStatus = statusText[statusKey] || 'Indisponible';

            // Determine dot color
            let dotColor = 'bg-gray-500';
            if (statusKey === 'AVAILABLE') dotColor = 'bg-green-500';
            else if (statusKey === 'ON_LEAVE') dotColor = 'bg-yellow-400';
            else if (statusKey === 'UNAVAILABLE') dotColor = 'bg-red-500';

            const dayName = avail.day;

            // Format times (remove seconds if present)
            const startTime = avail.startTime ? avail.startTime.substring(0, 5) : '-';
            const endTime = avail.endTime ? avail.endTime.substring(0, 5) : '-';

            tr.innerHTML =
                '<td class="px-6 py-4 whitespace-nowrap font-semibold text-gray-800 flex items-center">' +
                '<span class="inline-block w-2 h-2 rounded-full ' + dotColor + ' mr-2"></span>' +
                dayName +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap text-gray-700">' + startTime + '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap text-gray-700">' + endTime + '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap">' +
                '<span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold ' + bgClass + ' ' + textClass + ' ' + borderClass + '">' +
                displayStatus +
                '</span>' +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap">' +
                '<button onclick="openEditDayModal(\'' + avail.id + '\', \'' + avail.day + '\', \'' + avail.startTime + '\', \'' + avail.endTime + '\', \'' + avail.status + '\')" class="p-2 rounded hover:bg-gray-100 transition-colors" title="Éditer">' +
                '<i class="fas fa-pen text-gray-500"></i>' +
                '</button>' +
                '</td>';

            tbody.appendChild(tr);
        });
    }

</script>
</body>
</html>
