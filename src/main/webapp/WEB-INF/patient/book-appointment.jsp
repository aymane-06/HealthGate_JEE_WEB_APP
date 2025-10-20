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

        .booking-step {
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .step-complete {
            border-color: #10B981;
            background: #ECFDF5;
        }

        .step-active {
            border-color: #3B82F6;
            background: #EFF6FF;
            transform: scale(1.02);
        }

        .time-slot {
            transition: all 0.3s ease;
        }

        .time-slot:hover {
            transform: translateY(-2px);
        }

        .time-slot.selected {
            background: linear-gradient(135deg, #3B82F6, #1D4ED8);
            color: white;
            transform: scale(1.05);
        }

        .fade-in {
            animation: fadeIn 0.6s ease-in-out;
        }

        .slide-in {
            animation: slideIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from { transform: translateX(30px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        .doctor-card {
            transition: all 0.4s ease;
        }

        .doctor-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            background: #FFD700;
            border-radius: 50%;
            animation: confettiFall 5s linear forwards;
        }

        @keyframes confettiFall {
            0% { transform: translateY(-100px) rotate(0deg); opacity: 1; }
            100% { transform: translateY(100vh) rotate(360deg); opacity: 0; }
        }

        .calendar-day {
            transition: all 0.3s ease;
        }

        .calendar-day:hover {
            transform: scale(1.05);
        }

        .calendar-day.selected {
            background: linear-gradient(135deg, #3B82F6, #1D4ED8);
            color: white;
            transform: scale(1.1);
        }

        .department-card, .speciality-card {
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .department-card:hover, .speciality-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .department-card.selected, .speciality-card.selected {
            border-color: #3B82F6;
            border-width: 3px;
            background: #EFF6FF;
            transform: scale(1.05);
        }
    </style>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">

    <!-- Sidebar -->
    <aside class="w-64 bg-gradient-to-b from-primary-900 to-primary-800 text-white flex-shrink-0 hidden md:flex flex-col shadow-2xl">
        <!-- Logo -->
        <div class="p-6 border-b border-primary-700">
            <div class="flex items-center space-x-3">
                <i class="fas fa-hospital text-3xl text-secondary-400"></i>
                <div>
                    <h1 class="text-xl font-bold">Clinique</h1>
                    <p class="text-xs text-primary-200">Espace Patient</p>
                </div>
            </div>
        </div>

        <!-- User Profile -->
        <div class="p-6 border-b border-primary-700">
            <div class="flex items-center space-x-3">
                <div class="w-12 h-12 bg-gradient-to-br from-secondary-500 to-secondary-600 rounded-full flex items-center justify-center text-white font-bold text-lg shadow-lg">
                    <c:if test="${not empty sessionScope.user}">
                        ${sessionScope.user.firstName.substring(0,1)}${sessionScope.user.lastName.substring(0,1)}
                    </c:if>
                    <c:if test="${empty sessionScope.user}">
                        PT
                    </c:if>
                </div>
                <div class="flex-1 min-w-0">
                    <p class="font-semibold truncate">
                        <c:if test="${not empty sessionScope.user}">
                            ${sessionScope.user.firstName} ${sessionScope.user.lastName}
                        </c:if>
                        <c:if test="${empty sessionScope.user}">
                            Patient Test
                        </c:if>
                    </p>
                    <p class="text-xs text-primary-200 truncate">Patient</p>
                </div>
            </div>
        </div>

        <!-- Navigation -->
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

        <!-- Header -->
        <header class="bg-white shadow-sm border-b border-gray-200">
            <div class="flex items-center justify-between p-4">
                <div class="flex items-center space-x-4">
                    <button id="menu-toggle" class="md:hidden text-gray-600 hover:text-gray-900">
                        <i class="fas fa-bars text-2xl"></i>
                    </button>
                    <div>
                        <h2 class="text-2xl font-bold text-gray-900">Prendre un Rendez-vous</h2>
                        <p class="text-sm text-gray-500">Processus simple et rapide</p>
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

        <!-- Booking Steps Progress -->
        <div class="bg-white border-b border-gray-200">
            <div class="max-w-6xl mx-auto px-6 py-4">
                <div class="flex items-center justify-between">
                    <div class="flex items-center space-x-4">
                        <!-- New Department Step -->
                        <div class="booking-step step-active flex items-center space-x-3 p-3 rounded-lg border-2">
                            <div class="w-8 h-8 bg-blue-600 rounded-full flex items-center justify-center text-white font-bold">1</div>
                            <span class="font-semibold text-blue-700">Département</span>
                        </div>

                        <div class="w-12 h-1 bg-gray-300"></div>

                        <!-- Original Step 1 becomes Step 2 -->
                        <div class="booking-step flex items-center space-x-3 p-3 rounded-lg border-2 border-gray-300">
                            <div class="w-8 h-8 bg-gray-400 rounded-full flex items-center justify-center text-white font-bold">2</div>
                            <span class="font-semibold text-gray-500">Spécialité</span>
                        </div>

                        <div class="w-12 h-1 bg-gray-300"></div>

                        <!-- Original Step 2 becomes Step 3 -->
                        <div class="booking-step flex items-center space-x-3 p-3 rounded-lg border-2 border-gray-300">
                            <div class="w-8 h-8 bg-gray-400 rounded-full flex items-center justify-center text-white font-bold">3</div>
                            <span class="font-semibold text-gray-500">Docteur</span>
                        </div>

                        <div class="w-12 h-1 bg-gray-300"></div>

                        <!-- Original Step 3 becomes Step 4 -->
                        <div class="booking-step flex items-center space-x-3 p-3 rounded-lg border-2 border-gray-300">
                            <div class="w-8 h-8 bg-gray-400 rounded-full flex items-center justify-center text-white font-bold">4</div>
                            <span class="font-semibold text-gray-500">Date & Heure</span>
                        </div>

                        <div class="w-12 h-1 bg-gray-300"></div>

                        <!-- Original Step 4 becomes Step 5 -->
                        <div class="booking-step flex items-center space-x-3 p-3 rounded-lg border-2 border-gray-300">
                            <div class="w-8 h-8 bg-gray-400 rounded-full flex items-center justify-center text-white font-bold">5</div>
                            <span class="font-semibold text-gray-500">Confirmation</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Booking Content -->
        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">

            <!-- Step 1: Choose Department -->
            <div id="step-department" class="max-w-6xl mx-auto">
                <div class="text-center mb-8 fade-in">
                    <h3 class="text-3xl font-bold text-gray-900 mb-4">Choisissez votre Département 🏥</h3>
                    <p class="text-gray-600 text-lg">Sélectionnez le département médical correspondant à vos besoins</p>
                </div>

                <!-- Loading Spinner -->
                <div id="departments-loading" style="display:none;" class="flex justify-center items-center py-8">
                    <div class="animate-spin rounded-full h-12 w-12 border-t-4 border-b-4 border-blue-500"></div>
                </div>

                <!-- Departments Grid -->
                <div id="departments-container" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">

                </div>

                <!-- Next Step Preview -->
                <div class="mt-12 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-2xl p-8 border border-blue-200 slide-in">
                    <div class="text-center">
                        <h4 class="text-2xl font-bold text-gray-900 mb-4">Prochaine étape : Choisir la spécialité</h4>
                        <p class="text-gray-600 mb-6">Une fois votre département sélectionné, vous pourrez choisir parmi les spécialités disponibles</p>
                    </div>
                </div>
            </div>

            <!-- Step 2: Choose Speciality -->
            <div id="step-speciality" class="max-w-6xl mx-auto hidden">
                <div class="text-center mb-8 fade-in">
                    <h3 class="text-3xl font-bold text-gray-900 mb-4">Choisissez votre Spécialité 🩺</h3>
                    <p class="text-gray-600 text-lg">Sélectionnez la spécialité médicale pour votre consultation</p>
                </div>

                <!-- Selected Department Info -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 mb-8 slide-in">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-4">
                            <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-purple-600 rounded-xl flex items-center justify-center text-white font-bold text-xl shadow-lg" id="selected-department-avatar">
                                <i class="fas fa-user-md text-2xl"></i>
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-900 text-xl" id="selected-department-name">Médecine Générale</h4>
                                <span class="text-blue-600 font-semibold">Département sélectionné</span>
                            </div>
                        </div>
                        <button class="text-primary-600 hover:text-primary-800 font-semibold flex items-center" id="change-department-btn">
                            <i class="fas fa-undo-alt mr-2"></i> Changer de département
                        </button>
                    </div>
                </div>

                <!-- Loading Spinner for Specialities -->
                <div id="specialities-loading" style="display:none;" class="flex justify-center items-center py-8">
                    <div class="animate-spin rounded-full h-12 w-12 border-t-4 border-b-4 border-purple-500"></div>
                </div>

                <!-- Specialities Grid -->
                <div id="specialties-list" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                    <!-- Speciality Card 1 -->
                    <div class="speciality-card bg-white rounded-2xl shadow-sm border-2 border-gray-100 overflow-hidden fade-in" data-speciality-id="cardio" data-speciality-name="Cardiologie">
                        <div class="p-6">
                            <div class="flex items-center justify-between mb-4">
                                <div class="flex items-center space-x-4">
                                    <div class="w-16 h-16 bg-gradient-to-br from-red-500 to-orange-600 rounded-xl flex items-center justify-center text-white">
                                        <i class="fas fa-heart text-2xl"></i>
                                    </div>
                                    <div>
                                        <h4 class="font-bold text-gray-900">Cardiologie</h4>
                                        <span class="text-sm text-red-600 font-semibold">Soins cardiaques</span>
                                    </div>
                                </div>
                            </div>
                            <div class="space-y-2 mb-4 text-sm text-gray-600">
                                <div class="flex items-center">
                                    <i class="fas fa-user-md text-blue-500 w-5"></i>
                                    <span class="ml-2">6 cardiologues disponibles</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-clock text-green-500 w-5"></i>
                                    <span class="ml-2">Délai moyen: 3 jours</span>
                                </div>
                            </div>
                            <div class="text-center">
                                <span class="text-primary-600 font-semibold">Sélectionner</span>
                            </div>
                        </div>
                    </div>

                    <!-- Speciality Card 2 -->
                    <div class="speciality-card bg-white rounded-2xl shadow-sm border-2 border-gray-100 overflow-hidden fade-in" data-speciality-id="dermato" data-speciality-name="Dermatologie" style="animation-delay: 0.1s">
                        <div class="p-6">
                            <div class="flex items-center justify-between mb-4">
                                <div class="flex items-center space-x-4">
                                    <div class="w-16 h-16 bg-gradient-to-br from-teal-500 to-cyan-600 rounded-xl flex items-center justify-center text-white">
                                        <i class="fas fa-allergies text-2xl"></i>
                                    </div>
                                    <div>
                                        <h4 class="font-bold text-gray-900">Dermatologie</h4>
                                        <span class="text-sm text-teal-600 font-semibold">Soins de la peau</span>
                                    </div>
                                </div>
                            </div>
                            <div class="space-y-2 mb-4 text-sm text-gray-600">
                                <div class="flex items-center">
                                    <i class="fas fa-user-md text-blue-500 w-5"></i>
                                    <span class="ml-2">5 dermatologues disponibles</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-clock text-green-500 w-5"></i>
                                    <span class="ml-2">Délai moyen: 2 jours</span>
                                </div>
                            </div>
                            <div class="text-center">
                                <span class="text-primary-600 font-semibold">Sélectionner</span>
                            </div>
                        </div>
                    </div>

                    <!-- Speciality Card 3 -->
                    <div class="speciality-card bg-white rounded-2xl shadow-sm border-2 border-gray-100 overflow-hidden fade-in" data-speciality-id="pediatrie" data-speciality-name="Pédiatrie" style="animation-delay: 0.2s">
                        <div class="p-6">
                            <div class="flex items-center justify-between mb-4">
                                <div class="flex items-center space-x-4">
                                    <div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-pink-600 rounded-xl flex items-center justify-center text-white">
                                        <i class="fas fa-baby text-2xl"></i>
                                    </div>
                                    <div>
                                        <h4 class="font-bold text-gray-900">Pédiatrie</h4>
                                        <span class="text-sm text-purple-600 font-semibold">Soins pour enfants</span>
                                    </div>
                                </div>
                            </div>
                            <div class="space-y-2 mb-4 text-sm text-gray-600">
                                <div class="flex items-center">
                                    <i class="fas fa-user-md text-blue-500 w-5"></i>
                                    <span class="ml-2">8 pédiatres disponibles</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-clock text-green-500 w-5"></i>
                                    <span class="ml-2">Délai moyen: 1 jour</span>
                                </div>
                            </div>
                            <div class="text-center">
                                <span class="text-primary-600 font-semibold">Sélectionner</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Next Step Preview -->
                <div class="mt-12 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-2xl p-8 border border-blue-200 slide-in">
                    <div class="text-center">
                        <h4 class="text-2xl font-bold text-gray-900 mb-4">Prochaine étape : Choisir votre docteur</h4>
                        <p class="text-gray-600 mb-6">Une fois votre spécialité sélectionnée, vous pourrez choisir parmi nos médecins experts</p>
                    </div>
                </div>
            </div>

            <!-- Step 3: Choose Doctor -->
            <div id="step-doctor" class="max-w-6xl mx-auto hidden">
                <div class="text-center mb-8 fade-in">
                    <h3 class="text-3xl font-bold text-gray-900 mb-4">Choisissez votre Docteur 👨‍⚕️</h3>
                    <p class="text-gray-600 text-lg">Sélectionnez un professionnel de santé pour votre consultation</p>
                </div>

                <!-- Selected Speciality Info -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 mb-8 slide-in">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-4">
                            <div class="w-16 h-16 bg-gradient-to-br from-red-500 to-orange-600 rounded-xl flex items-center justify-center text-white font-bold text-xl shadow-lg" id="selected-speciality-avatar">
                                <i class="fas fa-heart text-2xl"></i>
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-900 text-xl" id="selected-speciality-name">Cardiologie</h4>
                                <span class="text-red-600 font-semibold">Spécialité sélectionnée</span>
                            </div>
                        </div>
                        <button class="text-primary-600 hover:text-primary-800 font-semibold flex items-center" id="change-speciality-btn">
                            <i class="fas fa-undo-alt mr-2"></i> Changer de spécialité
                        </button>
                    </div>
                </div>

                <!-- Doctors Grid -->
                <div id="doctors-list" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

                    <!-- Doctor Card 1 -->
                    <div class="doctor-card bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden fade-in">
                        <div class="p-6">
                            <div class="flex items-start justify-between mb-4">
                                <div class="flex items-center space-x-4">
                                    <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-purple-600 rounded-xl flex items-center justify-center text-white font-bold text-xl shadow-lg">
                                        DR
                                    </div>
                                    <div>
                                        <h4 class="font-bold text-gray-900">Dr. Sophie Martin</h4>
                                        <span class="text-sm text-blue-600 font-semibold">Cardiologue</span>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <div class="flex items-center text-yellow-400">
                                        <i class="fas fa-star"></i>
                                        <span class="text-gray-700 font-bold ml-1">4.9</span>
                                    </div>
                                </div>
                            </div>

                            <div class="space-y-2 mb-4 text-sm text-gray-600">
                                <div class="flex items-center">
                                    <i class="fas fa-clock text-green-500 w-5"></i>
                                    <span class="ml-2">Disponible aujourd'hui</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-map-marker-alt text-blue-500 w-5"></i>
                                    <span class="ml-2">Cabinet Central</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-user-md text-purple-500 w-5"></i>
                                    <span class="ml-2">12 ans d'expérience</span>
                                </div>
                            </div>

                            <button class="w-full bg-gradient-to-r from-green-500 to-green-600 hover:from-green-600 hover:to-green-700 text-white py-3 rounded-xl font-semibold transition-all transform hover:scale-105 shadow-md select-doctor" data-doctor-id="1" data-doctor-name="Dr. Sophie Martin">
                                Choisir ce docteur
                            </button>
                        </div>
                    </div>

                    <!-- Doctor Card 2 -->
                    <div class="doctor-card bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden fade-in" style="animation-delay: 0.1s">
                        <div class="p-6">
                            <div class="flex items-start justify-between mb-4">
                                <div class="flex items-center space-x-4">
                                    <div class="w-16 h-16 bg-gradient-to-br from-green-500 to-teal-600 rounded-xl flex items-center justify-center text-white font-bold text-xl shadow-lg">
                                        DA
                                    </div>
                                    <div>
                                        <h4 class="font-bold text-gray-900">Dr. Ahmed Benali</h4>
                                        <span class="text-sm text-green-600 font-semibold">Cardiologue</span>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <div class="flex items-center text-yellow-400">
                                        <i class="fas fa-star"></i>
                                        <span class="text-gray-700 font-bold ml-1">4.7</span>
                                    </div>
                                </div>
                            </div>

                            <div class="space-y-2 mb-4 text-sm text-gray-600">
                                <div class="flex items-center">
                                    <i class="fas fa-clock text-green-500 w-5"></i>
                                    <span class="ml-2">Disponible demain</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-map-marker-alt text-blue-500 w-5"></i>
                                    <span class="ml-2">Clinique Sud</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-user-md text-purple-500 w-5"></i>
                                    <span class="ml-2">8 ans d'expérience</span>
                                </div>
                            </div>

                            <button class="w-full bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white py-3 rounded-xl font-semibold transition-all transform hover:scale-105 shadow-md select-doctor" data-doctor-id="2" data-doctor-name="Dr. Ahmed Benali">
                                Choisir ce docteur
                            </button>
                        </div>
                    </div>

                    <!-- Doctor Card 3 -->
                    <div class="doctor-card bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden fade-in" style="animation-delay: 0.2s">
                        <div class="p-6">
                            <div class="flex items-start justify-between mb-4">
                                <div class="flex items-center space-x-4">
                                    <div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-pink-600 rounded-xl flex items-center justify-center text-white font-bold text-xl shadow-lg">
                                        DL
                                    </div>
                                    <div>
                                        <h4 class="font-bold text-gray-900">Dr. Laura Dubois</h4>
                                        <span class="text-sm text-purple-600 font-semibold">Cardiologue</span>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <div class="flex items-center text-yellow-400">
                                        <i class="fas fa-star"></i>
                                        <span class="text-gray-700 font-bold ml-1">4.8</span>
                                    </div>
                                </div>
                            </div>

                            <div class="space-y-2 mb-4 text-sm text-gray-600">
                                <div class="flex items-center">
                                    <i class="fas fa-clock text-green-500 w-5"></i>
                                    <span class="ml-2">Disponible cette semaine</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-map-marker-alt text-blue-500 w-5"></i>
                                    <span class="ml-2">Centre Médical Est</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-user-md text-purple-500 w-5"></i>
                                    <span class="ml-2">15 ans d'expérience</span>
                                </div>
                            </div>

                            <button class="w-full bg-gradient-to-r from-purple-500 to-purple-600 hover:from-purple-600 hover:to-purple-700 text-white py-3 rounded-xl font-semibold transition-all transform hover:scale-105 shadow-md select-doctor" data-doctor-id="3" data-doctor-name="Dr. Laura Dubois">
                                Choisir ce docteur
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Next Step Preview -->
                <div class="mt-12 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-2xl p-8 border border-blue-200 slide-in">
                    <div class="text-center">
                        <h4 class="text-2xl font-bold text-gray-900 mb-4">Prochaine étape : Choisir la date et l'heure</h4>
                        <p class="text-gray-600 mb-6">Une fois votre docteur sélectionné, vous pourrez choisir parmi ses disponibilités</p>
                    </div>
                </div>
            </div>

            <!-- Step 4: Date & Time Selection -->
            <div id="step-datetime" class="max-w-6xl mx-auto hidden">
                <div class="text-center mb-8 fade-in">
                    <h3 class="text-3xl font-bold text-gray-900 mb-4">Choisissez la date et l'heure 📅</h3>
                    <p class="text-gray-600 text-lg">Sélectionnez un créneau disponible pour votre consultation</p>
                </div>

                <!-- Selected Doctor Info -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 mb-8 slide-in">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-4">
                            <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-purple-600 rounded-xl flex items-center justify-center text-white font-bold text-xl shadow-lg" id="selected-doctor-avatar">
                                DR
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-900 text-xl" id="selected-doctor-name">Dr. Sophie Martin</h4>
                                <span class="text-blue-600 font-semibold" id="selected-doctor-specialty">Cardiologue</span>
                            </div>
                        </div>
                        <button class="text-primary-600 hover:text-primary-800 font-semibold flex items-center" id="change-doctor-btn">
                            <i class="fas fa-undo-alt mr-2"></i> Changer de docteur
                        </button>
                    </div>
                </div>

                <!-- Calendar and Time Slots -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Calendar -->
                    <div class="lg:col-span-2 bg-white rounded-2xl shadow-sm border border-gray-100 p-6 slide-in">
                        <div class="flex items-center justify-between mb-6">
                            <h4 class="text-lg font-bold text-gray-900">Calendrier des disponibilités</h4>
                            <div class="flex items-center space-x-2">
                                <button class="p-2 rounded-lg hover:bg-gray-100 transition-colors" id="prev-month">
                                    <i class="fas fa-chevron-left text-gray-600"></i>
                                </button>
                                <span class="font-semibold text-gray-700" id="current-month">Octobre 2023</span>
                                <button class="p-2 rounded-lg hover:bg-gray-100 transition-colors" id="next-month">
                                    <i class="fas fa-chevron-right text-gray-600"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Calendar Grid -->
                        <div class="grid grid-cols-7 gap-2 mb-4">
                            <div class="text-center text-sm font-semibold text-gray-500 py-2">Lun</div>
                            <div class="text-center text-sm font-semibold text-gray-500 py-2">Mar</div>
                            <div class="text-center text-sm font-semibold text-gray-500 py-2">Mer</div>
                            <div class="text-center text-sm font-semibold text-gray-500 py-2">Jeu</div>
                            <div class="text-center text-sm font-semibold text-gray-500 py-2">Ven</div>
                            <div class="text-center text-sm font-semibold text-gray-500 py-2">Sam</div>
                            <div class="text-center text-sm font-semibold text-gray-500 py-2">Dim</div>

                            <!-- Calendar days will be populated by JavaScript -->
                            <div id="calendar-days" class="col-span-7 grid grid-cols-7 gap-2">
                                <!-- Calendar days will be generated here -->
                            </div>
                        </div>

                        <!-- Legend -->
                        <div class="flex items-center justify-center space-x-6 text-sm">
                            <div class="flex items-center">
                                <div class="w-3 h-3 bg-gray-200 rounded-full mr-2"></div>
                                <span class="text-gray-500">Indisponible</span>
                            </div>
                            <div class="flex items-center">
                                <div class="w-3 h-3 bg-blue-100 rounded-full mr-2"></div>
                                <span class="text-gray-500">Disponible</span>
                            </div>
                            <div class="flex items-center">
                                <div class="w-3 h-3 bg-blue-500 rounded-full mr-2"></div>
                                <span class="text-gray-500">Sélectionné</span>
                            </div>
                        </div>
                    </div>

                    <!-- Time Slots -->
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 slide-in" style="animation-delay: 0.2s">
                        <h4 class="text-lg font-bold text-gray-900 mb-4">Créneaux disponibles</h4>
                        <p class="text-gray-500 text-sm mb-6" id="selected-date-text">Sélectionnez une date pour voir les horaires disponibles</p>

                        <div class="space-y-3" id="time-slots-container">
                            <!-- Time slots will be populated by JavaScript -->
                        </div>

                        <!-- Selected Time Summary -->
                        <div class="mt-8 p-4 bg-blue-50 rounded-xl border border-blue-200 hidden" id="selected-time-summary">
                            <h5 class="font-semibold text-blue-800 mb-2">Résumé de votre sélection</h5>
                            <div class="flex justify-between items-center">
                                <div>
                                    <p class="text-blue-700 font-medium" id="summary-date">Lundi 16 Octobre</p>
                                    <p class="text-blue-600 text-sm" id="summary-time">09:00 - 09:30</p>
                                </div>
                                <button class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg font-semibold transition-colors" id="confirm-time-btn">
                                    Confirmer
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Step 5: Confirmation -->
            <div id="step-confirmation" class="max-w-4xl mx-auto hidden">
                <div class="text-center mb-8 fade-in">
                    <h3 class="text-3xl font-bold text-gray-900 mb-4">Confirmez votre Rendez-vous ✅</h3>
                    <p class="text-gray-600 text-lg">Vérifiez les détails de votre consultation avant confirmation</p>
                </div>

                <!-- Appointment Summary -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-8 mb-8 slide-in">
                    <div class="flex items-center justify-center mb-6">
                        <div class="w-20 h-20 bg-gradient-to-br from-green-500 to-teal-600 rounded-full flex items-center justify-center text-white font-bold text-2xl shadow-lg mr-6">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div>
                            <h4 class="text-2xl font-bold text-gray-900">Rendez-vous programmé</h4>
                            <p class="text-gray-600">Votre consultation a été réservée avec succès</p>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                        <div class="bg-gray-50 rounded-xl p-4">
                            <h5 class="font-semibold text-gray-700 mb-2">Informations du docteur</h5>
                            <div class="flex items-center space-x-3">
                                <div class="w-12 h-12 bg-gradient-to-br from-blue-500 to-purple-600 rounded-xl flex items-center justify-center text-white font-bold text-lg" id="confirm-doctor-avatar">
                                    DR
                                </div>
                                <div>
                                    <p class="font-bold text-gray-900" id="confirm-doctor-name">Dr. Sophie Martin</p>
                                    <p class="text-sm text-blue-600" id="confirm-doctor-specialty">Cardiologue</p>
                                </div>
                            </div>
                        </div>

                        <div class="bg-gray-50 rounded-xl p-4">
                            <h5 class="font-semibold text-gray-700 mb-2">Date et heure</h5>
                            <div class="flex items-center space-x-3">
                                <div class="w-12 h-12 bg-gradient-to-br from-green-500 to-teal-600 rounded-xl flex items-center justify-center text-white">
                                    <i class="fas fa-clock text-xl"></i>
                                </div>
                                <div>
                                    <p class="font-bold text-gray-900" id="confirm-date">Lundi 16 Octobre 2023</p>
                                    <p class="text-sm text-green-600" id="confirm-time">09:00 - 09:30</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Information -->
                    <div class="border-t pt-6">
                        <h5 class="font-semibold text-gray-700 mb-4">Informations supplémentaires</h5>
                        <div class="space-y-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Raison de la consultation</label>
                                <textarea class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-primary-500 focus:ring-4 focus:ring-primary-100 transition-all outline-none" rows="3" placeholder="Décrivez brièvement la raison de votre visite..."></textarea>
                            </div>
                            <div>
                                <label class="flex items-center">
                                    <input type="checkbox" class="rounded border-gray-300 text-primary-600 focus:ring-primary-500 mr-2">
                                    <span class="text-sm text-gray-700">Je souhaite recevoir un rappel par SMS 24h avant le rendez-vous</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex justify-between items-center slide-in" style="animation-delay: 0.3s">
                    <button class="text-primary-600 hover:text-primary-800 font-semibold flex items-center" id="back-to-datetime-btn">
                        <i class="fas fa-arrow-left mr-2"></i> Retour à la sélection d'horaire
                    </button>
                    <button class="bg-gradient-to-r from-green-500 to-green-600 hover:from-green-600 hover:to-green-700 text-white px-8 py-4 rounded-xl font-bold text-lg transition-all shadow-lg hover:shadow-xl transform hover:scale-105" id="final-confirm-btn">
                        <i class="fas fa-check-circle mr-2"></i> Confirmer le rendez-vous
                    </button>
                </div>
            </div>

            <!-- Success Step -->
            <div id="step-success" class="max-w-2xl mx-auto hidden">
                <div class="text-center mb-8 fade-in">
                    <div class="w-24 h-24 bg-gradient-to-br from-green-500 to-teal-600 rounded-full flex items-center justify-center text-white mx-auto mb-6">
                        <i class="fas fa-check text-4xl"></i>
                    </div>
                    <h3 class="text-3xl font-bold text-gray-900 mb-4">Rendez-vous Confirmé! 🎉</h3>
                    <p class="text-gray-600 text-lg">Votre consultation a été réservée avec succès</p>
                </div>

                <!-- Success Details -->
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-8 mb-8 slide-in">
                    <div class="text-center mb-6">
                        <h4 class="text-xl font-bold text-gray-900 mb-2" id="success-doctor-name">Dr. Sophie Martin</h4>
                        <p class="text-blue-600 font-semibold" id="success-doctor-specialty">Cardiologue</p>
                    </div>

                    <div class="flex items-center justify-center mb-6">
                        <div class="text-center px-6 border-r border-gray-200">
                            <p class="text-2xl font-bold text-gray-900" id="success-date">16 Oct</p>
                            <p class="text-gray-500 text-sm" id="success-day">Lundi</p>
                        </div>
                        <div class="text-center px-6">
                            <p class="text-2xl font-bold text-gray-900" id="success-time">09:00</p>
                            <p class="text-gray-500 text-sm">Durée: 30min</p>
                        </div>
                    </div>

                    <div class="bg-blue-50 rounded-xl p-4 mb-6">
                        <div class="flex items-start">
                            <i class="fas fa-info-circle text-blue-500 mt-1 mr-3"></i>
                            <div>
                                <p class="font-semibold text-blue-800">Votre rendez-vous est confirmé</p>
                                <p class="text-sm text-blue-700 mt-1">Vous recevrez un email de confirmation et un rappel 24h avant votre consultation.</p>
                            </div>
                        </div>
                    </div>

                    <div class="space-y-4">
                        <div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                            <span class="text-gray-700">Numéro de confirmation</span>
                            <span class="font-mono font-bold text-gray-900">RDV-2023-2847</span>
                        </div>
                        <div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                            <span class="text-gray-700">Lieu</span>
                            <span class="font-semibold text-gray-900">Cabinet Central</span>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex flex-col sm:flex-row gap-4 justify-center slide-in" style="animation-delay: 0.3s">
                    <a href="${pageContext.request.contextPath}/patient/dashboard" class="bg-primary-600 hover:bg-primary-700 text-white px-6 py-3 rounded-xl font-semibold transition-colors text-center">
                        <i class="fas fa-home mr-2"></i> Retour au tableau de bord
                    </a>
                    <a href="${pageContext.request.contextPath}/patient/appointments" class="bg-white hover:bg-gray-50 text-primary-600 border-2 border-primary-600 px-6 py-3 rounded-xl font-semibold transition-colors text-center">
                        <i class="fas fa-calendar-alt mr-2"></i> Voir mes rendez-vous
                    </a>
                </div>
            </div>

        </main>
    </div>
</div>

<script>
    // Global variables to store booking data
    let bookingData = {
        departmentId: null,
        departmentName: null,
        departmentLocation: null,
        specialityId: null,
        specialityName: null,
        doctorId: null,
        doctorName: null,
        doctorSpecialty: null,
        date: null,
        time: null
    };

    async function loadDepartments() {
        try {
            // Show loading spinner
            document.getElementById('departments-loading').style.display = 'flex';

            const response = await fetch('${pageContext.request.contextPath}/api/patient/departments');
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const data = await response.json();
            const departments= data.departments;
            renderdepartment(departments)

            // Hide loading spinner
            document.getElementById('departments-loading').style.display = 'none';

        } catch (error) {
            console.error('There was a problem with the fetch operation:', error);
            // Hide loading spinner in case of error
            document.getElementById('departments-loading').style.display = 'none';
        }
    }

    function renderdepartment(departments) {
        console.log(departments);
        const container = document.getElementById('departments-container');
        container.innerHTML = '';

        departments.forEach(department => {
            const card = document.createElement('div');
            card.className = `department-card bg-white rounded-2xl shadow-sm border-2 border-gray-100 overflow-hidden fade-in`;
            card.setAttribute('data-department-id', department.id);
            card.setAttribute('data-department-name', department.name);
            card.setAttribute('data-department-location', department.location || '');

            // Specialties count display
            let specialtiesHtml = '<span class="ml-2 text-xs text-gray-500">' +
                (department.specialties ? department.specialties.length : 0) +
                ' spécialité' + (department.specialties && department.specialties.length > 1 ? 's' : '') + '</span>';

            card.innerHTML =
                '<div class="p-6">' +
                    '<div class="flex items-center justify-between mb-4">' +
                        '<div class="flex items-center space-x-4">' +
                            '<div class="w-16 h-16 rounded-xl flex items-center justify-center text-white" style="background:' + (department.color || '#4F46E5') + ';">' +
                                '<i class="fas fa-hospital-symbol text-2xl"></i>' +
                            '</div>' +
                            '<div>' +
                                '<h4 class="font-bold text-gray-900">' + department.name + '</h4>' +
                                '<span class="text-sm text-blue-600 font-semibold">' + department.description + '</span>' +
                                '<div class="text-xs text-gray-500 mt-1">Code: ' + department.code + '</div>' +
                            '</div>' +
                        '</div>' +
                        '<div>' +
                            '<span class="px-2 py-1 rounded text-xs font-bold ' + (department.isActive ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700') + '">' +
                                (department.isActive ? 'Actif' : 'Inactif') +
                            '</span>' +
                        '</div>' +
                    '</div>' +
                    '<div class="space-y-2 mb-4 text-sm text-gray-600">' +
                        '<div class="flex items-center">' +
                            '<i class="fas fa-user-md text-blue-500 w-5"></i>' +
                            '<span class="ml-2">' + department.doctorCount + ' médecins disponibles</span>' +
                        '</div>' +
                        '<div class="flex items-center">' +
                            '<i class="fas fa-clock text-green-500 w-5"></i>' +
                            '<span class="ml-2">Délai moyen: ' + (department.averageWaitTime || '-') + ' jours</span>' +
                        '</div>' +
                        '<div class="flex items-center">' +
                            '<i class="fas fa-map-marker-alt text-red-500 w-5"></i>' +
                            '<span class="ml-2">' + (department.location || 'Non spécifié') + '</span>' +
                        '</div>' +
                        '<div class="flex items-center">' +
                            '<i class="fas fa-envelope text-purple-500 w-5"></i>' +
                            '<span class="ml-2">' + (department.contactInfo || 'Non spécifié') + '</span>' +
                        '</div>' +
                        '<div class="flex items-center">' +
                            '<i class="fas fa-list text-gray-500 w-5"></i>' +
                            '<span class="ml-2">Nombre de spécialités:</span>' +
                            specialtiesHtml +
                        '</div>' +
                    '</div>' +
                    '<div class="text-center">' +
                        '<span class="text-primary-600 font-semibold">Sélectionner</span>' +
                    '</div>' +
                '</div>';
            container.appendChild(card);
        });
    }

    async function loadSpecialities(departmentId) {
        console.log(departmentId);
        try {
            // Show loading spinner
            document.getElementById('specialities-loading').style.display = 'flex';

            const response = await fetch('${pageContext.request.contextPath}/api/patient/departments/' + departmentId + '/specialties');
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const data = await response.json();
            const specialities= data.specialties;
            console.log(specialities);
            renderspecialities(specialities);

            // Hide loading spinner
            document.getElementById('specialities-loading').style.display = 'none';

        } catch (error) {
            console.error('There was a problem with the fetch operation:', error);
            // Hide loading spinner in case of error
            document.getElementById('specialities-loading').style.display = 'none';
        }
    }

    function renderspecialities(specialities) {
        const container = document.getElementById('specialties-list');
        if (!container) return;
        container.innerHTML = '';
        if (!Array.isArray(specialities) || specialities.length === 0) {
            container.innerHTML = '<p>Aucune spécialité trouvée.</p>';
            return;
        }
        const cardsWrapper = document.createElement('div');
        cardsWrapper.className = 'flex flex-wrap gap-6';
        specialities.forEach(function(spec, idx) {
            var card = document.createElement('div');
            card.className = 'speciality-card bg-white rounded-2xl shadow-sm border-2 border-gray-100 overflow-hidden fade-in';
            card.setAttribute('data-speciality-id', spec.id || '');
            card.setAttribute('data-speciality-name', spec.name || '');
            card.style.animationDelay = (0.2 + idx * 0.1) + 's';
            card.innerHTML =
                '<div class="p-6">' +
                '<div class="flex items-center justify-between mb-4">' +
                '<div class="flex items-center space-x-4">' +
                '<div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-pink-600 rounded-xl flex items-center justify-center text-white">' +
                '<i class=" fas ' + spec.icon + ' text-2xl"></i>' +
                '</div>' +
                '<div>' +
                '<h4 class="font-bold text-gray-900">' + spec.name + '</h4>' +
                '<span class="text-sm text-purple-600 font-semibold">' + (spec.description || '') + '</span>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '<div class="space-y-2 mb-4 text-sm text-gray-600">' +
                '<div class="flex items-center">' +
                '<i class="fas fa-user-md text-blue-500 w-5"></i>' +
                '<span class="ml-2">' + (spec.doctorsCount ? spec.doctorsCount + ' médecins disponibles' : 'Médecins disponibles') + '</span>' +
                '</div>' +
                '<div class="flex items-center">' +
                '<i class="fas fa-clock text-green-500 w-5"></i>' +
                '<span class="ml-2">Délai moyen: ' + (spec.avgDelay ? spec.avgDelay : 'N/A') + '</span>' +
                '</div>' +
                '</div>' +
                '<div class="text-center">' +
                '<span class="text-primary-600 font-semibold">Sélectionner</span>' +
                '</div>' +
                '</div>';
            cardsWrapper.appendChild(card);
        });
        container.appendChild(cardsWrapper);

        // Speciality selection
        const specialityCards = document.querySelectorAll('.speciality-card');
        specialityCards.forEach(function(card) {
            card.addEventListener('click', function() {
                const specialityId = this.getAttribute('data-speciality-id');
                const specialityName = this.getAttribute('data-speciality-name');

                // Store speciality data
                bookingData.specialityId = specialityId;
                bookingData.specialityName = specialityName;

                // Remove selection from all cards
                specialityCards.forEach(function(c) {
                    c.classList.remove('selected');
                    c.style.borderColor = '#e5e7eb';
                });

                // Add selection to clicked card
                this.classList.add('selected');
                this.style.borderColor = '#3B82F6';

                loadDoctors(specialityId);
                // Update selected speciality info in next step
                document.getElementById('selected-speciality-name').textContent = specialityName;


                // Move to next step after a short delay for better UX
                setTimeout(function() {
                    goToStep('doctor');
                }, 500);
            });
        });
    }

    async function loadDoctors(specialityId) {
        if (!specialityId) return;
        console.log(specialityId);
        const container = document.getElementById('doctors-list');
        if (container) {
            container.innerHTML = '<div class="doctor-loading-spinner" style="display:flex;justify-content:center;align-items:center;height:80px;">' +
                '<div class="spinner-border" style="width:2rem;height:2rem;border:4px solid #ccc;border-top:4px solid #6c63ff;border-radius:50%;animation:spin 1s linear infinite;"></div>' +
                '</div>' +
                '<style>@keyframes spin{0%{transform:rotate(0deg);}100%{transform:rotate(360deg);}}</style>';
        }
        try {
            const response = await fetch('${pageContext.request.contextPath}/api/patient/departments/' + specialityId + '/doctors');
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const data = await response.json();
            const doctors= data.doctors;
            console.log(doctors);
            renderDoctors(doctors);
        } catch (err) {
            console.error('Error fetching doctors:', err);
            return;
        }
    }

    function renderDoctors(doctors) {
        let container = document.getElementById('doctors-list');
        if (!container) return;
        container.innerHTML = '';
        if (!Array.isArray(doctors) || doctors.length === 0) {
            container.innerHTML = '<p class="text-center text-gray-500 py-8">Aucun médecin trouvé pour cette spécialité.</p>';
            return;
        }

        doctors.forEach(function(doc, idx) {
            let specialty = doc.specialty || {};
            let iconClass = specialty.icon || '';
            let specialtyName = specialty.name || doc.title || '';
            let specialtyColor = specialty.color || '#3b82f6';

            // Icon or fallback
            let iconHtml = '';
            if (iconClass && iconClass.indexOf('fa') !== -1) {
                if (!iconClass.includes('fa ')) iconClass = 'fas ' + iconClass;
                iconHtml = '<i class="' + iconClass + ' text-2xl"></i>';
            } else {
                let fallbackChar = specialtyName ? specialtyName.charAt(0).toUpperCase() : '?';
                iconHtml = '<span class="text-2xl font-bold">' + fallbackChar + '</span>';
            }

            // Calculate avg availability (in hours per week)
            let avgHours = 0;
            if (Array.isArray(doc.availabilities) && doc.availabilities.length > 0) {
                avgHours = doc.availabilities.reduce(function(sum, av) {
                    if(av.status==="UNAVAILABLE") return sum;
                    let start = av.startTime ? parseInt(av.startTime.split(':')[0], 10) : 0;
                    let end = av.endTime ? parseInt(av.endTime.split(':')[0], 10) : 0;
                    return sum + Math.max(0, end - start);
                }, 0);
            }

            // Get location from global selectedDepartment if available
            let location = bookingData.departmentLocation || "Non spécifié";

            // Doctor card with combined styling
            let card = document.createElement('div');
            card.className = 'doctor-card bg-white rounded-2xl shadow-sm border-2 border-gray-100 overflow-hidden fade-in';
            card.setAttribute('data-doctor-id', doc.id);
            card.setAttribute('data-doctor-name', doc.name || '');
            card.setAttribute('data-doctor-specialty', specialtyName);

            card.innerHTML =
                '<div class="p-6">' +
                '<div class="flex items-start justify-between mb-4">' +
                '<div class="flex items-center space-x-4">' +
                '<div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-purple-600 rounded-xl flex items-center justify-center text-white font-bold text-xl shadow-lg">' +
                iconHtml +
                '</div>' +
                '<div>' +
                '<h4 class="font-bold text-gray-900">' + (doc.name || '') + '</h4>' +
                '<span class="text-sm text-blue-600 font-semibold">' + specialtyName + '</span>' +
                '<div class="text-xs text-gray-500 mt-1">' + (doc.email || '') + '</div>' +
                '</div>' +
                '</div>' +
                '<div class="text-right">' +
                '<div class="flex items-center text-yellow-400">' +
                '<i class="fas fa-star"></i>' +
                '<span class="text-gray-700 font-bold ml-1">' + (doc.rating || '4.9') + '</span>' +
                '</div>' +
                '</div>' +
                '</div>' +

                '<div class="space-y-2 mb-4 text-sm text-gray-600">' +
                '<div class="flex items-center">' +
                '<i class="fas fa-user-md text-blue-500 w-5"></i>' +
                '<span class="ml-2">' + (doc.experience || 'N/A') + ' ans d\'expérience</span>' +
                '</div>' +
                '<div class="flex items-center">' +
                '<i class="fas fa-clock text-green-500 w-5"></i>' +
                '<span class="ml-2">Disponibilité: ' + avgHours + 'h/semaine</span>' +
                '</div>' +
                '<div class="flex items-center">' +
                '<i class="fas fa-map-marker-alt text-red-500 w-5"></i>' +
                '<span class="ml-2">' + location + '</span>' +
                '</div>' +
                '<div class="flex items-center">' +
                '<i class="fas fa-envelope text-purple-500 w-5"></i>' +
                '<span class="ml-2">' + (doc.email || 'Non spécifié') + '</span>' +
                '</div>' +
                '</div>' +

                '<button class="w-full bg-gradient-to-r from-green-500 to-green-600 hover:from-green-600 hover:to-green-700 text-white py-3 rounded-xl font-semibold transition-all transform hover:scale-105 shadow-md select-doctor" data-doctor-id="' + doc.id + '" data-doctor-name="' + (doc.name || '') + '">' +
                'Choisir ce docteur' +
                '</button>' +
                '</div>';

            container.appendChild(card);
        });
        // Doctor selection
        const doctorCards = document.querySelectorAll('.select-doctor');
        doctorCards.forEach(function(card) {
            card.addEventListener('click', function() {
                const doctorId = this.getAttribute('data-doctor-id');
                const doctorName = this.getAttribute('data-doctor-name');

                let SlectedDoctor=doctors.filter(doc=>doc.id==doctorId)[0];
                // Store doctor data
                bookingData.doctorId = doctorId;
                bookingData.doctorName = doctorName;

                // Extract specialty from card
                const cardElement = this.closest('.doctor-card');
                const specialtyElement = cardElement.querySelector('span.text-blue-600, span.text-green-600, span.text-purple-600');
                bookingData.doctorSpecialty = specialtyElement ? specialtyElement.textContent : 'Médecin';

                // Update selected doctor info in next step
                document.getElementById('selected-doctor-name').textContent = doctorName;
                document.getElementById('selected-doctor-specialty').textContent = bookingData.doctorSpecialty;
                document.getElementById('selected-doctor-avatar').textContent = doctorName.substring(0, 2);

                // Update confirmation step
                document.getElementById('confirm-doctor-name').textContent = doctorName;
                document.getElementById('confirm-doctor-specialty').textContent = bookingData.doctorSpecialty;
                document.getElementById('confirm-doctor-avatar').textContent = doctorName.substring(0, 2);

                // Update success step
                document.getElementById('success-doctor-name').textContent = doctorName;
                document.getElementById('success-doctor-specialty').textContent = bookingData.doctorSpecialty;

                // Initialize calendar for date/time selection
                initializeCalendar(SlectedDoctor.availabilities);

                // Move to next step
                goToStep('datetime');
            });
        });
    }





    // Smooth animations and interactions
    document.addEventListener('DOMContentLoaded', async function() {

       await loadDepartments();

        // Department selection
        const departmentCards = document.querySelectorAll('.department-card');
        console.log(departmentCards);
        departmentCards.forEach(function(card) {
            card.addEventListener('click', function() {
                const departmentId = this.getAttribute('data-department-id');
                const departmentName = this.getAttribute('data-department-name');
                const departmentLocation = this.getAttribute('data-department-location');

                // Store department data
                bookingData.departmentId = departmentId;
                bookingData.departmentName = departmentName;
                bookingData.departmentLocation = departmentLocation;

                // Remove selection from all cards
                departmentCards.forEach(function(c) {
                    c.classList.remove('selected');
                    c.style.borderColor = '#e5e7eb';
                });

                // Add selection to clicked card
                this.classList.add('selected');
                this.style.borderColor = '#3B82F6';

                // Update selected department info in next step
                document.getElementById('selected-department-name').textContent = departmentName;

                loadSpecialities(departmentId);
                // Move to next step after a short delay for better UX
                setTimeout(function() {
                    goToStep('speciality');
                }, 500);

            });
        });





        // Change department button
        document.getElementById('change-department-btn').addEventListener('click', function() {
            goToStep('department');
        });

        // Change speciality button
        document.getElementById('change-speciality-btn').addEventListener('click', function() {
            goToStep('speciality');
        });

        // Change doctor button
        document.getElementById('change-doctor-btn').addEventListener('click', function() {
            goToStep('doctor');
        });

        // Back to datetime button
        document.getElementById('back-to-datetime-btn').addEventListener('click', function() {
            goToStep('datetime');
        });

        // Final confirmation button
        document.getElementById('final-confirm-btn').addEventListener('click', function() {
            // In a real app, you would submit the form to the server here
            // For this demo, we'll just show the success step
            goToStep('success');
            createConfetti();
        });


    });

    // Function to navigate between steps
    function goToStep(step) {
        // Hide all steps
        document.getElementById('step-department').classList.add('hidden');
        document.getElementById('step-speciality').classList.add('hidden');
        document.getElementById('step-doctor').classList.add('hidden');
        document.getElementById('step-datetime').classList.add('hidden');
        document.getElementById('step-confirmation').classList.add('hidden');
        document.getElementById('step-success').classList.add('hidden');

        // Show selected step
        document.getElementById('step-' + step).classList.remove('hidden');

        // Update progress bar
        updateProgressBar(step);
    }

    // Function to update progress bar
    function updateProgressBar(currentStep) {
        const steps = document.querySelectorAll('.booking-step');

        // Reset all steps
        steps.forEach(function(step) {
            step.classList.remove('step-complete', 'step-active');
            step.classList.add('border-gray-300');

            const number = step.querySelector('div');
            number.classList.remove('bg-green-500', 'bg-blue-600');
            number.classList.add('bg-gray-400');
        });

        // Update based on current step
        if (currentStep === 'department') {
            steps[0].classList.add('step-active');
            steps[0].classList.remove('border-gray-300');
            steps[0].querySelector('div').classList.remove('bg-gray-400');
            steps[0].querySelector('div').classList.add('bg-blue-600');
        } else if (currentStep === 'speciality') {
            steps[0].classList.add('step-complete');
            steps[0].classList.remove('border-gray-300');
            steps[0].querySelector('div').classList.remove('bg-gray-400');
            steps[0].querySelector('div').classList.add('bg-green-500');

            steps[1].classList.add('step-active');
            steps[1].classList.remove('border-gray-300');
            steps[1].querySelector('div').classList.remove('bg-gray-400');
            steps[1].querySelector('div').classList.add('bg-blue-600');
        } else if (currentStep === 'doctor') {
            steps[0].classList.add('step-complete');
            steps[0].classList.remove('border-gray-300');
            steps[0].querySelector('div').classList.remove('bg-gray-400');
            steps[0].querySelector('div').classList.add('bg-green-500');

            steps[1].classList.add('step-complete');
            steps[1].classList.remove('border-gray-300');
            steps[1].querySelector('div').classList.remove('bg-gray-400');
            steps[1].querySelector('div').classList.add('bg-green-500');

            steps[2].classList.add('step-active');
            steps[2].classList.remove('border-gray-300');
            steps[2].querySelector('div').classList.remove('bg-gray-400');
            steps[2].querySelector('div').classList.add('bg-blue-600');
        } else if (currentStep === 'datetime') {
            steps[0].classList.add('step-complete');
            steps[0].classList.remove('border-gray-300');
            steps[0].querySelector('div').classList.remove('bg-gray-400');
            steps[0].querySelector('div').classList.add('bg-green-500');

            steps[1].classList.add('step-complete');
            steps[1].classList.remove('border-gray-300');
            steps[1].querySelector('div').classList.remove('bg-gray-400');
            steps[1].querySelector('div').classList.add('bg-green-500');

            steps[2].classList.add('step-complete');
            steps[2].classList.remove('border-gray-300');
            steps[2].querySelector('div').classList.remove('bg-gray-400');
            steps[2].querySelector('div').classList.add('bg-green-500');

            steps[3].classList.add('step-active');
            steps[3].classList.remove('border-gray-300');
            steps[3].querySelector('div').classList.remove('bg-gray-400');
            steps[3].querySelector('div').classList.add('bg-blue-600');
        } else if (currentStep === 'confirmation') {
            steps[0].classList.add('step-complete');
            steps[0].classList.remove('border-gray-300');
            steps[0].querySelector('div').classList.remove('bg-gray-400');
            steps[0].querySelector('div').classList.add('bg-green-500');

            steps[1].classList.add('step-complete');
            steps[1].classList.remove('border-gray-300');
            steps[1].querySelector('div').classList.remove('bg-gray-400');
            steps[1].querySelector('div').classList.add('bg-green-500');

            steps[2].classList.add('step-complete');
            steps[2].classList.remove('border-gray-300');
            steps[2].querySelector('div').classList.remove('bg-gray-400');
            steps[2].querySelector('div').classList.add('bg-green-500');

            steps[3].classList.add('step-complete');
            steps[3].classList.remove('border-gray-300');
            steps[3].querySelector('div').classList.remove('bg-gray-400');
            steps[3].querySelector('div').classList.add('bg-green-500');

            steps[4].classList.add('step-active');
            steps[4].classList.remove('border-gray-300');
            steps[4].querySelector('div').classList.remove('bg-gray-400');
            steps[4].querySelector('div').classList.add('bg-blue-600');
        } else if (currentStep === 'success') {
            steps.forEach(function(step) {
                step.classList.add('step-complete');
                step.classList.remove('border-gray-300');

                const number = step.querySelector('div');
                number.classList.remove('bg-gray-400');
                number.classList.add('bg-green-500');
            });
        }
    }

    // Calendar functionality
    function initializeCalendar(availabilities) {
        const currentMonthElement = document.getElementById('current-month');
        const calendarDaysElement = document.getElementById('calendar-days');
        const prevMonthButton = document.getElementById('prev-month');
        const nextMonthButton = document.getElementById('next-month');

        let currentDate = new Date();

        function renderCalendar() {
            // Set month text
            const monthNames = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
                "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];
            currentMonthElement.textContent = monthNames[currentDate.getMonth()] + ' ' + currentDate.getFullYear();

            // Clear previous calendar
            calendarDaysElement.innerHTML = '';

            // Get first day of month and number of days
            const firstDay = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
            const lastDay = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);
            const daysInMonth = lastDay.getDate();

            // Get day of week for first day (0 = Sunday, 1 = Monday, etc.)
            let firstDayIndex = firstDay.getDay();
            // Adjust for Monday as first day of week
            firstDayIndex = firstDayIndex === 0 ? 6 : firstDayIndex - 1;

            // Add empty cells for days before the first day of the month
            for (let i = 0; i < firstDayIndex; i++) {
                const emptyDay = document.createElement('div');
                emptyDay.className = 'h-12';
                calendarDaysElement.appendChild(emptyDay);
            }

            const dayNames = ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"];

            // Add days of the month
            for (let i = 1; i <= daysInMonth; i++) {
                const dateObj = new Date(currentDate.getFullYear(), currentDate.getMonth(), i);
                const dayName = dayNames[dateObj.getDay()];
                const now = new Date();
                const avalabilityForDay= availabilities.filter(av=>av.day===dayName && av.status==="AVAILABLE")[0];

                const dayElement = document.createElement('div');
                dayElement.className = 'calendar-day h-12 flex items-center justify-center rounded-lg cursor-pointer transition-all';
                //Mark passed and unavailable days
                if (dateObj > now && avalabilityForDay) {
                    dayElement.classList.add('bg-blue-50', 'text-blue-700', 'font-semibold');
                    dayElement.setAttribute('data-available', 'true');
                } else {
                    dayElement.classList.add('bg-gray-100', 'text-gray-400');
                    dayElement.classList.remove('cursor-pointer');
                }

                dayElement.textContent = i;
                dayElement.setAttribute('data-day', i);
                dayElement.setAttribute('day-name', dayName);

                // Add click event
                if (dateObj > now && avalabilityForDay) {
                    dayElement.addEventListener('click', function() {
                        // Remove selection from all days
                        document.querySelectorAll('.calendar-day').forEach(function(day) {
                            day.classList.remove('selected', 'text-white');
                            if (day.getAttribute('data-available') === 'true') {
                                day.classList.add('bg-blue-50', 'text-blue-700');
                            }
                        });

                        // Add selection to clicked day
                        this.classList.remove('bg-blue-50', 'text-blue-700');
                        this.classList.add('selected', 'text-white');

                        // Update selected date
                        const selectedDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), i);
                        bookingData.date = selectedDate;

                        // Update UI
                        updateSelectedDate(selectedDate);
                        generateTimeSlots(dateObj);
                    });
                }

                calendarDaysElement.appendChild(dayElement);
            }
        }

        function updateSelectedDate(date) {
            const dayNames = ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"];
            const monthNames = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
                "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];

            const dayName = dayNames[date.getDay()];
            const day = date.getDate();
            const month = monthNames[date.getMonth()];
            const year = date.getFullYear();

            document.getElementById('selected-date-text').textContent = 'Créneaux disponibles le ' + dayName + ' ' + day + ' ' + month + ' ' + year;

            // Update confirmation step
            document.getElementById('confirm-date').textContent = dayName + ' ' + day + ' ' + month + ' ' + year;
            document.getElementById('success-date').textContent = day + ' ' + month.substring(0, 3);
            document.getElementById('success-day').textContent = dayName;
        }



        async function generateTimeSlots(dateObj) {
            const timeSlotsContainer = document.getElementById('time-slots-container');
            timeSlotsContainer.innerHTML = '';

            console.log(dateObj);
            // fetch available time slots from server based on selected date and doctor
            let doctorId = bookingData.doctorId;
            let dayName = dateObj.toLocaleDateString('fr-FR', { weekday: 'long' });
            console.log(bookingData);

            let response;
            try {
                response = await fetch('${pageContext.request.contextPath}/api/patient/doctors/' + doctorId + '/availabilities?day=' + dateObj);
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                const data = await response.json();
                const slots= data.timeSlots; // Assume server returns an array of time slots
                console.log(slots);
            } catch (err) {
                console.error('Error fetching time slots:', err);
                return;
            }


            // Generate time slots (for demo)
            const timeSlots = [
                '09:00 - 09:30', '10:00 - 10:30', '11:00 - 11:30',
                '14:00 - 14:30', '15:00 - 15:30', '16:00 - 16:30'
            ];

            timeSlots.forEach(function(slot) {
                const slotElement = document.createElement('div');
                slotElement.className = 'time-slot p-3 border-2 border-gray-200 rounded-lg text-center cursor-pointer font-semibold transition-all';
                slotElement.textContent = slot;

                slotElement.addEventListener('click', function() {
                    // Remove selection from all slots
                    document.querySelectorAll('.time-slot').forEach(function(s) {
                        s.classList.remove('selected', 'text-white');
                        s.classList.add('border-gray-200', 'text-gray-700');
                    });

                    // Add selection to clicked slot
                    this.classList.remove('border-gray-200', 'text-gray-700');
                    this.classList.add('selected', 'text-white');

                    // Update booking data
                    bookingData.time = slot;

                    // Update UI
                    document.getElementById('summary-date').textContent = document.getElementById('selected-date-text').textContent.replace('Créneaux disponibles le ', '');
                    document.getElementById('summary-time').textContent = slot;
                    document.getElementById('selected-time-summary').classList.remove('hidden');

                    // Update confirmation step
                    document.getElementById('confirm-time').textContent = slot;
                    document.getElementById('success-time').textContent = slot.split(' - ')[0];
                });

                timeSlotsContainer.appendChild(slotElement);
            });
        }

        // Confirm time button
        document.getElementById('confirm-time-btn').addEventListener('click', function() {
            goToStep('confirmation');
        });

        // Month navigation
        prevMonthButton.addEventListener('click', function() {
            currentDate.setMonth(currentDate.getMonth() - 1);
            renderCalendar();
        });

        nextMonthButton.addEventListener('click', function() {
            currentDate.setMonth(currentDate.getMonth() + 1);
            renderCalendar();
        });

        // Initial render
        renderCalendar();
    }

    // Create confetti effect (for final confirmation step)
    function createConfetti() {
        for (let i = 0; i < 50; i++) {
            const confetti = document.createElement('div');
            confetti.className = 'confetti';
            confetti.style.left = Math.random() * 100 + 'vw';
            confetti.style.animationDelay = Math.random() * 5 + 's';
            const colors = ['#FFD700', '#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4'];
            confetti.style.background = colors[Math.floor(Math.random() * 5)];
            document.body.appendChild(confetti);

            setTimeout(function() {
                confetti.remove();
            }, 5000);
        }
    }
</script>
</body>
</html>
