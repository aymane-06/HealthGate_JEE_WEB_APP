<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clinique Digitale - Soins de Santé Modernes</title>
    <meta name="description" content="Votre santé, notre priorité. Prenez rendez-vous avec les meilleurs médecins en quelques clics.">
    
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
    
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        * {
            scroll-behavior: smooth;
            font-family: 'Inter', sans-serif;
        }
        .text-shadow {
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        .animate-fade-in-down {
            animation: fade-in-down 1s ease-out;
        }
        .animate-fade-in {
            animation: fade-in 1.5s ease-out;
        }
        @keyframes fade-in-down {
            0% {
                opacity: 0;
                transform: translateY(-20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes fade-in {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }
        @keyframes bounce {
            0%, 100% {
                transform: translateY(-25%);
                animation-timing-function: cubic-bezier(0.8,0,1,1);
            }
            50% {
                transform: none;
                animation-timing-function: cubic-bezier(0,0,0.2,1);
            }
        }
        .animate-bounce {
            animation: bounce 1s infinite;
        }
    </style>
</head>
<body class="bg-gray-50">
    
    <!-- Navigation -->
    <nav class="bg-white shadow-sm px-4 md:px-6 py-3 sticky top-0 z-40">
        <div class="max-w-7xl mx-auto flex justify-between items-center">
            <div class="flex items-center space-x-2">
                <a href="${pageContext.request.contextPath}/" class="flex items-center space-x-2">
                    <i class="fas fa-hospital text-3xl text-primary-600"></i>
                    <span class="font-bold text-2xl text-primary-600">Clinique Digitale</span>
                </a>
            </div>
            
            <!-- Desktop Navigation -->
            <div class="hidden md:flex space-x-6 text-gray-700 items-center">
                <a href="#features" class="hover:text-primary-600 transition-colors font-medium">Services</a>
                <a href="#how-it-works" class="hover:text-primary-600 transition-colors font-medium">Comment ça marche</a>
                <a href="#specialties" class="hover:text-primary-600 transition-colors font-medium">Spécialités</a>
                <a href="#testimonials" class="hover:text-primary-600 transition-colors font-medium">Témoignages</a>
            </div>
            
            <div class="hidden md:flex items-center space-x-4">
                <a href="${pageContext.request.contextPath}/login" class="text-primary-600 hover:text-primary-700 font-semibold transition-colors">
                    Connexion
                </a>
                <a href="${pageContext.request.contextPath}/register" class="bg-primary-600 text-white px-6 py-2.5 rounded-lg font-semibold hover:bg-primary-700 transition-all shadow-lg hover:shadow-xl">
                    S'inscrire
                </a>
            </div>
            
            <button id="mobile-menu-button" class="md:hidden text-gray-700">
                <i class="fas fa-bars text-2xl"></i>
            </button>
        </div>
        
        <!-- Mobile Menu -->
        <div id="mobile-menu" class="hidden md:hidden mt-4 pb-4">
            <div class="flex flex-col space-y-3">
                <a href="#features" class="text-gray-700 hover:text-primary-600 transition-colors font-medium">Services</a>
                <a href="#how-it-works" class="text-gray-700 hover:text-primary-600 transition-colors font-medium">Comment ça marche</a>
                <a href="#specialties" class="text-gray-700 hover:text-primary-600 transition-colors font-medium">Spécialités</a>
                <a href="#testimonials" class="text-gray-700 hover:text-primary-600 transition-colors font-medium">Témoignages</a>
                <hr class="border-gray-200">
                <a href="${pageContext.request.contextPath}/login" class="text-primary-600 hover:text-primary-700 font-semibold transition-colors">Connexion</a>
                <a href="${pageContext.request.contextPath}/register" class="bg-primary-600 text-white px-6 py-2.5 rounded-lg font-semibold hover:bg-primary-700 text-center">S'inscrire</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="relative overflow-hidden min-h-screen flex items-center bg-gradient-to-br from-primary-900 via-primary-700 to-secondary-600">
        <!-- Background Pattern -->
        <div class="absolute inset-0 opacity-10">
            <div class="absolute inset-0" style="background-image: url('data:image/svg+xml,%3Csvg width=&quot;60&quot; height=&quot;60&quot; viewBox=&quot;0 0 60 60&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot;%3E%3Cg fill=&quot;none&quot; fill-rule=&quot;evenodd&quot;%3E%3Cg fill=&quot;%23ffffff&quot; fill-opacity=&quot;0.4&quot;%3E%3Cpath d=&quot;M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z&quot;/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>
        </div>
        
        <!-- Gradient Overlay -->
        <div class="absolute inset-0 bg-gradient-to-r from-black/60 to-primary-900/70"></div>
        
        <!-- Content -->
        <div class="relative z-20 container mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-20">
            <div class="flex flex-col lg:flex-row items-center gap-10">
                <div class="w-full lg:w-3/5 text-white" data-aos="fade-right" data-aos-duration="1200">
                    <h1 class="text-4xl sm:text-5xl md:text-6xl font-bold mb-6 leading-tight text-shadow animate-fade-in-down">
                        <span class="text-transparent bg-clip-text bg-gradient-to-r from-white to-secondary-200">Votre Santé,</span><br>
                        <span class="text-white">Notre Priorité</span>
                    </h1>
                    <p class="text-lg sm:text-xl mb-8 text-gray-100 max-w-2xl animate-fade-in">
                        Prenez rendez-vous avec les meilleurs médecins en quelques clics. Accédez à des soins de santé modernes, rapides et personnalisés.
                    </p>
                    
                    <div class="flex flex-col sm:flex-row gap-4 mb-10">
                        <a href="${pageContext.request.contextPath}/register" class="inline-flex items-center justify-center bg-secondary-600 text-white px-8 py-4 rounded-lg font-semibold hover:bg-secondary-700 transition-all shadow-xl hover:shadow-2xl transform hover:scale-105">
                            <i class="fas fa-calendar-check mr-2"></i>
                            Prendre RDV
                        </a>
                        <a href="#how-it-works" class="inline-flex items-center justify-center bg-white/10 backdrop-blur-lg text-white border-2 border-white/30 px-8 py-4 rounded-lg font-semibold hover:bg-white/20 transition-all">
                            <i class="fas fa-play-circle mr-2"></i>
                            En savoir plus
                        </a>
                    </div>
                    
                    <!-- Stats -->
                    <div class="grid grid-cols-3 gap-6 max-w-2xl" data-aos="fade-up" data-aos-delay="200">
                        <div class="text-center">
                            <div class="text-3xl sm:text-4xl font-bold text-secondary-400 mb-1">1000+</div>
                            <div class="text-sm sm:text-base text-gray-300">Patients</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl sm:text-4xl font-bold text-secondary-400 mb-1">50+</div>
                            <div class="text-sm sm:text-base text-gray-300">Médecins</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl sm:text-4xl font-bold text-secondary-400 mb-1">98%</div>
                            <div class="text-sm sm:text-base text-gray-300">Satisfaction</div>
                        </div>
                    </div>
                    
                    <!-- Scroll indicator -->
                    <div class="hidden md:block mt-12">
                        <a href="#features" class="inline-flex items-center text-white/80 hover:text-white transition-colors">
                            <span class="mr-2">Découvrir nos services</span>
                            <i class="fas fa-arrow-down animate-bounce"></i>
                        </a>
                    </div>
                </div>
                
                <!-- Hero Image/Illustration -->
                <div class="w-full lg:w-2/5" data-aos="fade-left" data-aos-duration="1200">
                    <div class="relative">
                        <div class="bg-white/10 backdrop-blur-lg rounded-3xl p-8 border border-white/20 shadow-2xl">
                            <div class="space-y-6">
                                <div class="flex items-center space-x-4 bg-white/10 rounded-xl p-4">
                                    <div class="bg-secondary-500 rounded-full p-3">
                                        <i class="fas fa-heartbeat text-white text-2xl"></i>
                                    </div>
                                    <div>
                                        <div class="text-white font-semibold">Téléconsultation</div>
                                        <div class="text-gray-300 text-sm">Disponible 24/7</div>
                                    </div>
                                </div>
                                <div class="flex items-center space-x-4 bg-white/10 rounded-xl p-4">
                                    <div class="bg-primary-500 rounded-full p-3">
                                        <i class="fas fa-calendar-alt text-white text-2xl"></i>
                                    </div>
                                    <div>
                                        <div class="text-white font-semibold">Rendez-vous en ligne</div>
                                        <div class="text-gray-300 text-sm">Simple et rapide</div>
                                    </div>
                                </div>
                                <div class="flex items-center space-x-4 bg-white/10 rounded-xl p-4">
                                    <div class="bg-purple-500 rounded-full p-3">
                                        <i class="fas fa-file-medical text-white text-2xl"></i>
                                    </div>
                                    <div>
                                        <div class="text-white font-semibold">Dossier médical</div>
                                        <div class="text-gray-300 text-sm">Sécurisé et accessible</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-12 md:py-20 bg-gray-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-10 md:mb-16">
                <h2 class="text-3xl sm:text-4xl md:text-5xl font-bold text-gray-900 mb-4" data-aos="fade-up">
                    Pourquoi Choisir Notre Clinique
                </h2>
                <p class="text-base sm:text-lg text-gray-600 max-w-2xl mx-auto" data-aos="fade-up" data-aos-delay="100">
                    Des services de santé modernes et accessibles pour toute la famille
                </p>
            </div>
            
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6 md:gap-10">
                <div class="bg-white p-6 md:p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-1" data-aos="fade-up" data-aos-delay="150">
                    <div class="bg-primary-100 text-primary-600 w-16 h-16 rounded-2xl flex items-center justify-center mb-5">
                        <i class="fas fa-clock text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold mb-3 text-gray-900">Disponibilité 24/7</h3>
                    <p class="text-gray-600">Prenez rendez-vous à tout moment, où que vous soyez. Notre plateforme est accessible 24h/24.</p>
                </div>
                
                <div class="bg-white p-6 md:p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-1" data-aos="fade-up" data-aos-delay="300">
                    <div class="bg-secondary-100 text-secondary-600 w-16 h-16 rounded-2xl flex items-center justify-center mb-5">
                        <i class="fas fa-user-md text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold mb-3 text-gray-900">Médecins Qualifiés</h3>
                    <p class="text-gray-600">Accédez à plus de 50 médecins spécialisés et certifiés pour tous vos besoins de santé.</p>
                </div>
                
                <div class="bg-white p-6 md:p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-1" data-aos="fade-up" data-aos-delay="450">
                    <div class="bg-purple-100 text-purple-600 w-16 h-16 rounded-2xl flex items-center justify-center mb-5">
                        <i class="fas fa-shield-alt text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold mb-3 text-gray-900">Données Sécurisées</h3>
                    <p class="text-gray-600">Vos informations médicales sont protégées par les normes de sécurité les plus strictes.</p>
                </div>
                
                <div class="bg-white p-6 md:p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-1" data-aos="fade-up" data-aos-delay="150">
                    <div class="bg-green-100 text-green-600 w-16 h-16 rounded-2xl flex items-center justify-center mb-5">
                        <i class="fas fa-video text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold mb-3 text-gray-900">Téléconsultation</h3>
                    <p class="text-gray-600">Consultez votre médecin en vidéo depuis le confort de votre domicile.</p>
                </div>
                
                <div class="bg-white p-6 md:p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-1" data-aos="fade-up" data-aos-delay="300">
                    <div class="bg-orange-100 text-orange-600 w-16 h-16 rounded-2xl flex items-center justify-center mb-5">
                        <i class="fas fa-file-prescription text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold mb-3 text-gray-900">Ordonnances en Ligne</h3>
                    <p class="text-gray-600">Recevez vos ordonnances directement sur la plateforme et dans votre email.</p>
                </div>
                
                <div class="bg-white p-6 md:p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-1" data-aos="fade-up" data-aos-delay="450">
                    <div class="bg-pink-100 text-pink-600 w-16 h-16 rounded-2xl flex items-center justify-center mb-5">
                        <i class="fas fa-bell text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold mb-3 text-gray-900">Rappels Intelligents</h3>
                    <p class="text-gray-600">Ne manquez jamais un rendez-vous avec nos notifications personnalisées.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Specialties Section -->
    <section id="specialties" class="py-12 md:py-20 bg-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex flex-col md:flex-row items-center gap-10">
                <div class="w-full md:w-1/2" data-aos="fade-right">
                    <h2 class="text-3xl sm:text-4xl font-bold text-gray-900 mb-6">
                        Nos Spécialités Médicales
                    </h2>
                    <p class="text-lg text-gray-600 mb-8">
                        Nous offrons une gamme complète de services médicaux pour répondre à tous vos besoins de santé.
                    </p>
                    
                    <div class="space-y-4">
                        <div class="flex items-start space-x-4 bg-gray-50 rounded-xl p-4 hover:bg-gray-100 transition-colors">
                            <div class="bg-primary-100 rounded-full p-2">
                                <i class="fas fa-heart text-primary-600 text-xl"></i>
                            </div>
                            <div>
                                <h3 class="font-bold text-gray-900">Cardiologie</h3>
                                <p class="text-gray-600 text-sm">Soins complets pour votre santé cardiovasculaire</p>
                            </div>
                        </div>
                        
                        <div class="flex items-start space-x-4 bg-gray-50 rounded-xl p-4 hover:bg-gray-100 transition-colors">
                            <div class="bg-secondary-100 rounded-full p-2">
                                <i class="fas fa-brain text-secondary-600 text-xl"></i>
                            </div>
                            <div>
                                <h3 class="font-bold text-gray-900">Neurologie</h3>
                                <p class="text-gray-600 text-sm">Diagnostic et traitement des troubles neurologiques</p>
                            </div>
                        </div>
                        
                        <div class="flex items-start space-x-4 bg-gray-50 rounded-xl p-4 hover:bg-gray-100 transition-colors">
                            <div class="bg-green-100 rounded-full p-2">
                                <i class="fas fa-bone text-green-600 text-xl"></i>
                            </div>
                            <div>
                                <h3 class="font-bold text-gray-900">Orthopédie</h3>
                                <p class="text-gray-600 text-sm">Traitement des troubles musculosquelettiques</p>
                            </div>
                        </div>
                        
                        <div class="flex items-start space-x-4 bg-gray-50 rounded-xl p-4 hover:bg-gray-100 transition-colors">
                            <div class="bg-purple-100 rounded-full p-2">
                                <i class="fas fa-baby text-purple-600 text-xl"></i>
                            </div>
                            <div>
                                <h3 class="font-bold text-gray-900">Pédiatrie</h3>
                                <p class="text-gray-600 text-sm">Soins spécialisés pour les enfants et adolescents</p>
                            </div>
                        </div>
                    </div>
                    
                    <a href="${pageContext.request.contextPath}/register" class="inline-block mt-8 bg-primary-600 text-white px-8 py-3 rounded-lg font-semibold hover:bg-primary-700 transition-all shadow-lg hover:shadow-xl">
                        Voir Toutes les Spécialités
                    </a>
                </div>
                
                <div class="w-full md:w-1/2" data-aos="fade-left">
                    <div class="grid grid-cols-2 gap-4">
                        <div class="bg-gradient-to-br from-primary-500 to-primary-700 rounded-2xl p-6 text-white shadow-xl">
                            <i class="fas fa-stethoscope text-4xl mb-3 opacity-80"></i>
                            <div class="text-3xl font-bold mb-1">15+</div>
                            <div class="text-sm opacity-90">Spécialités</div>
                        </div>
                        <div class="bg-gradient-to-br from-secondary-500 to-secondary-700 rounded-2xl p-6 text-white shadow-xl mt-8">
                            <i class="fas fa-hospital-user text-4xl mb-3 opacity-80"></i>
                            <div class="text-3xl font-bold mb-1">5000+</div>
                            <div class="text-sm opacity-90">Consultations</div>
                        </div>
                        <div class="bg-gradient-to-br from-purple-500 to-purple-700 rounded-2xl p-6 text-white shadow-xl">
                            <i class="fas fa-award text-4xl mb-3 opacity-80"></i>
                            <div class="text-3xl font-bold mb-1">10+</div>
                            <div class="text-sm opacity-90">Années d'Expérience</div>
                        </div>
                        <div class="bg-gradient-to-br from-green-500 to-green-700 rounded-2xl p-6 text-white shadow-xl mt-8">
                            <i class="fas fa-star text-4xl mb-3 opacity-80"></i>
                            <div class="text-3xl font-bold mb-1">4.9/5</div>
                            <div class="text-sm opacity-90">Note Moyenne</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section id="how-it-works" class="py-12 md:py-20 bg-gradient-to-br from-gray-50 to-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-3xl sm:text-4xl font-bold text-gray-900 mb-4" data-aos="fade-up">
                    Comment Ça Marche ?
                </h2>
                <p class="text-lg text-gray-600 max-w-2xl mx-auto" data-aos="fade-up" data-aos-delay="100">
                    Prenez rendez-vous en 3 étapes simples
                </p>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 relative">
                <!-- Step 1 -->
                <div class="relative" data-aos="fade-up" data-aos-delay="150">
                    <div class="bg-white rounded-2xl p-8 shadow-xl hover:shadow-2xl transition-all">
                        <div class="absolute -top-6 left-1/2 transform -translate-x-1/2 bg-gradient-to-r from-primary-600 to-primary-700 text-white w-14 h-14 rounded-full flex items-center justify-center text-2xl font-bold shadow-lg">
                            1
                        </div>
                        <div class="pt-6 text-center">
                            <div class="bg-primary-100 text-primary-600 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-6">
                                <i class="fas fa-search text-4xl"></i>
                            </div>
                            <h3 class="text-xl font-bold mb-3 text-gray-900">Trouvez un Médecin</h3>
                            <p class="text-gray-600">Recherchez parmi nos médecins spécialisés et consultez leurs profils détaillés</p>
                        </div>
                    </div>
                </div>
                
                <!-- Step 2 -->
                <div class="relative" data-aos="fade-up" data-aos-delay="300">
                    <div class="bg-white rounded-2xl p-8 shadow-xl hover:shadow-2xl transition-all">
                        <div class="absolute -top-6 left-1/2 transform -translate-x-1/2 bg-gradient-to-r from-secondary-600 to-secondary-700 text-white w-14 h-14 rounded-full flex items-center justify-center text-2xl font-bold shadow-lg">
                            2
                        </div>
                        <div class="pt-6 text-center">
                            <div class="bg-secondary-100 text-secondary-600 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-6">
                                <i class="fas fa-calendar-check text-4xl"></i>
                            </div>
                            <h3 class="text-xl font-bold mb-3 text-gray-900">Réservez en Ligne</h3>
                            <p class="text-gray-600">Choisissez un créneau horaire qui vous convient et confirmez instantanément</p>
                        </div>
                    </div>
                </div>
                
                <!-- Step 3 -->
                <div class="relative" data-aos="fade-up" data-aos-delay="450">
                    <div class="bg-white rounded-2xl p-8 shadow-xl hover:shadow-2xl transition-all">
                        <div class="absolute -top-6 left-1/2 transform -translate-x-1/2 bg-gradient-to-r from-purple-600 to-purple-700 text-white w-14 h-14 rounded-full flex items-center justify-center text-2xl font-bold shadow-lg">
                            3
                        </div>
                        <div class="pt-6 text-center">
                            <div class="bg-purple-100 text-purple-600 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-6">
                                <i class="fas fa-user-md text-4xl"></i>
                            </div>
                            <h3 class="text-xl font-bold mb-3 text-gray-900">Consultez</h3>
                            <p class="text-gray-600">Rendez-vous à la clinique ou consultez en vidéo depuis chez vous</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section id="testimonials" class="py-12 md:py-20 bg-gradient-to-r from-primary-900 to-primary-700 text-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 class="text-3xl sm:text-4xl font-bold mb-4" data-aos="fade-up">
                    Ce Que Disent Nos Patients
                </h2>
                <p class="text-lg text-primary-100 max-w-2xl mx-auto" data-aos="fade-up" data-aos-delay="100">
                    Des milliers de patients satisfaits nous font confiance
                </p>
            </div>
            
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6 md:gap-8">
                <div class="bg-white/10 backdrop-blur-lg p-6 md:p-8 rounded-2xl border border-white/20 shadow-xl hover:bg-white/20 transition-all" data-aos="fade-up" data-aos-delay="150">
                    <div class="text-secondary-300 mb-4 text-lg">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="mb-6 italic text-gray-100">
                        "Excellente expérience ! La prise de rendez-vous était simple et le médecin très professionnel. Je recommande vivement."
                    </p>
                    <div class="flex items-center">
                        <div class="bg-gradient-to-br from-purple-400 to-purple-600 rounded-full w-12 h-12 flex items-center justify-center text-white font-bold text-lg mr-4">
                            SM
                        </div>
                        <div>
                            <h4 class="font-bold">Sarah Martin</h4>
                            <p class="text-primary-200 text-sm">Patiente depuis 2023</p>
                        </div>
                    </div>
                </div>
                
                <div class="bg-white/10 backdrop-blur-lg p-6 md:p-8 rounded-2xl border border-white/20 shadow-xl hover:bg-white/20 transition-all" data-aos="fade-up" data-aos-delay="300">
                    <div class="text-secondary-300 mb-4 text-lg">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="mb-6 italic text-gray-100">
                        "La téléconsultation m'a permis de consulter rapidement sans me déplacer. Service impeccable et très pratique."
                    </p>
                    <div class="flex items-center">
                        <div class="bg-gradient-to-br from-green-400 to-green-600 rounded-full w-12 h-12 flex items-center justify-center text-white font-bold text-lg mr-4">
                            JD
                        </div>
                        <div>
                            <h4 class="font-bold">Jean Dupont</h4>
                            <p class="text-primary-200 text-sm">Patient depuis 2022</p>
                        </div>
                    </div>
                </div>
                
                <div class="bg-white/10 backdrop-blur-lg p-6 md:p-8 rounded-2xl border border-white/20 shadow-xl hover:bg-white/20 transition-all" data-aos="fade-up" data-aos-delay="450">
                    <div class="text-secondary-300 mb-4 text-lg">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <p class="mb-6 italic text-gray-100">
                        "Médecins compétents et à l'écoute. Le système de rappel par SMS est très utile pour ne pas oublier ses rendez-vous."
                    </p>
                    <div class="flex items-center">
                        <div class="bg-gradient-to-br from-orange-400 to-orange-600 rounded-full w-12 h-12 flex items-center justify-center text-white font-bold text-lg mr-4">
                            ML
                        </div>
                        <div>
                            <h4 class="font-bold">Marie Leclerc</h4>
                            <p class="text-primary-200 text-sm">Patiente depuis 2021</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-12 md:py-20 bg-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="bg-gradient-to-r from-primary-50 to-secondary-50 rounded-3xl p-8 sm:p-12 md:p-16 relative overflow-hidden" data-aos="fade-up">
                <div class="absolute right-0 top-0 w-full h-full overflow-hidden opacity-10">
                    <svg class="absolute right-0 top-0 h-full" viewBox="0 0 400 400" fill="none">
                        <circle cx="300" cy="100" r="150" fill="currentColor" class="text-primary-600"/>
                        <circle cx="350" cy="300" r="100" fill="currentColor" class="text-secondary-600"/>
                    </svg>
                </div>
                
                <div class="relative z-10 text-center max-w-3xl mx-auto">
                    <h2 class="text-3xl sm:text-4xl font-bold text-gray-900 mb-6">
                        Prêt à Prendre Soin de Votre Santé ?
                    </h2>
                    <p class="text-lg text-gray-600 mb-8">
                        Rejoignez des milliers de patients satisfaits. Prenez votre premier rendez-vous dès aujourd'hui et découvrez une nouvelle façon de consulter.
                    </p>
                    
                    <div class="flex flex-col sm:flex-row justify-center gap-4">
                        <a href="${pageContext.request.contextPath}/register" class="inline-flex items-center justify-center bg-primary-600 text-white px-8 py-4 rounded-lg font-semibold hover:bg-primary-700 transition-all shadow-lg hover:shadow-xl transform hover:scale-105">
                            <i class="fas fa-user-plus mr-2"></i>
                            Créer un Compte
                        </a>
                        <a href="${pageContext.request.contextPath}/login" class="inline-flex items-center justify-center bg-white text-primary-700 border-2 border-primary-600 px-8 py-4 rounded-lg font-semibold hover:bg-primary-50 transition-all">
                            <i class="fas fa-sign-in-alt mr-2"></i>
                            Se Connecter
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gray-900 text-gray-300 py-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
                <!-- Company Info -->
                <div>
                    <div class="flex items-center space-x-2 mb-4">
                        <i class="fas fa-hospital text-3xl text-primary-500"></i>
                        <h3 class="text-xl font-bold text-white">Clinique Digitale</h3>
                    </div>
                    <p class="mb-4 text-sm">
                        Votre santé, notre priorité. Des soins modernes et accessibles pour toute la famille.
                    </p>
                    <div class="flex space-x-4">
                        <a href="#" class="text-gray-400 hover:text-white transition-colors transform hover:scale-110">
                            <i class="fab fa-facebook-f text-xl"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white transition-colors transform hover:scale-110">
                            <i class="fab fa-twitter text-xl"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white transition-colors transform hover:scale-110">
                            <i class="fab fa-instagram text-xl"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white transition-colors transform hover:scale-110">
                            <i class="fab fa-linkedin-in text-xl"></i>
                        </a>
                    </div>
                </div>

                <!-- Quick Links -->
                <div>
                    <h3 class="text-lg font-semibold text-white mb-4">Liens Rapides</h3>
                    <ul class="space-y-2">
                        <li><a href="#features" class="hover:text-white transition-colors">Services</a></li>
                        <li><a href="#specialties" class="hover:text-white transition-colors">Spécialités</a></li>
                        <li><a href="#how-it-works" class="hover:text-white transition-colors">Comment ça marche</a></li>
                        <li><a href="#testimonials" class="hover:text-white transition-colors">Témoignages</a></li>
                    </ul>
                </div>

                <!-- For Doctors -->
                <div>
                    <h3 class="text-lg font-semibold text-white mb-4">Pour les Médecins</h3>
                    <ul class="space-y-2">
                        <li><a href="${pageContext.request.contextPath}/register" class="hover:text-white transition-colors">Rejoindre la Clinique</a></li>
                        <li><a href="#" class="hover:text-white transition-colors">Espace Médecin</a></li>
                        <li><a href="#" class="hover:text-white transition-colors">Ressources</a></li>
                    </ul>
                </div>

                <!-- Contact -->
                <div>
                    <h3 class="text-lg font-semibold text-white mb-4">Contact</h3>
                    <ul class="space-y-3">
                        <li class="flex items-start">
                            <i class="fas fa-envelope mr-3 mt-1 text-primary-500"></i>
                            <span class="text-sm">contact@cliniquedigitale.com</span>
                        </li>
                        <li class="flex items-start">
                            <i class="fas fa-phone mr-3 mt-1 text-primary-500"></i>
                            <span class="text-sm">+212 5 XX XX XX XX</span>
                        </li>
                        <li class="flex items-start">
                            <i class="fas fa-map-marker-alt mr-3 mt-1 text-primary-500"></i>
                            <span class="text-sm">123 Avenue Mohammed V, Casablanca</span>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="border-t border-gray-700 mt-10 pt-8 flex flex-col md:flex-row justify-between items-center">
                <p class="text-sm mb-4 md:mb-0">© 2024 Clinique Digitale. Tous droits réservés.</p>
                <div class="flex space-x-6 text-sm">
                    <a href="#" class="hover:text-white transition-colors">Politique de Confidentialité</a>
                    <a href="#" class="hover:text-white transition-colors">Conditions d'Utilisation</a>
                    <a href="#" class="hover:text-white transition-colors">Contact</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- AOS Animation Library -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        // Initialize AOS
        AOS.init({
            once: true,
            disable: false,
            duration: 700,
            easing: 'ease-out-cubic',
        });
        
        // Mobile menu toggle
        const mobileMenuButton = document.getElementById('mobile-menu-button');
        const mobileMenu = document.getElementById('mobile-menu');
        
        if (mobileMenuButton) {
            mobileMenuButton.addEventListener('click', function() {
                mobileMenu.classList.toggle('hidden');
            });
        }
        
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                    // Close mobile menu if open
                    if (mobileMenu && !mobileMenu.classList.contains('hidden')) {
                        mobileMenu.classList.add('hidden');
                    }
                }
            });
        });
    </script>
</body>
</html>
