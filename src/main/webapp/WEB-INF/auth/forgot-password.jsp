<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mot de passe oublié - Clinique Digitale</title>
    
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
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }
        
        .animate-fade-in { animation: fadeIn 0.6s ease-out; }
        .animate-float { animation: float 3s ease-in-out infinite; }
    </style>
</head>
<body class="bg-gradient-to-br from-primary-50 via-white to-purple-50 min-h-screen flex items-center justify-center p-4">
    
    <div class="w-full max-w-6xl grid grid-cols-1 lg:grid-cols-2 gap-8 items-center">
        
        <!-- Left Side - Illustration & Info -->
        <div class="hidden lg:flex flex-col items-center justify-center p-12 animate-fade-in">
            <div class="relative">
                <!-- Floating Icon -->
                <div class="w-64 h-64 bg-gradient-to-br from-primary-600 to-purple-600 rounded-full flex items-center justify-center shadow-2xl animate-float">
                    <i class="fas fa-lock text-white text-8xl"></i>
                </div>
                
                <!-- Decorative Elements -->
                <div class="absolute -top-4 -right-4 w-24 h-24 bg-purple-400 rounded-full opacity-20 animate-pulse"></div>
                <div class="absolute -bottom-4 -left-4 w-32 h-32 bg-primary-400 rounded-full opacity-20 animate-pulse" style="animation-delay: 0.5s;"></div>
            </div>
            
            <div class="mt-12 text-center">
                <h2 class="text-3xl font-bold text-gray-900 mb-4">Mot de passe oublié ?</h2>
                <p class="text-gray-600 mb-6 max-w-md">
                    Pas de problème ! Entrez votre adresse email et nous vous enverrons un lien pour réinitialiser votre mot de passe.
                </p>
                
                <div class="flex flex-wrap justify-center gap-4 mt-8">
                    <div class="flex items-center space-x-2 bg-white/80 backdrop-blur-sm px-4 py-2 rounded-full shadow-sm">
                        <i class="fas fa-shield-alt text-green-600"></i>
                        <span class="text-sm font-semibold text-gray-700">Sécurisé</span>
                    </div>
                    <div class="flex items-center space-x-2 bg-white/80 backdrop-blur-sm px-4 py-2 rounded-full shadow-sm">
                        <i class="fas fa-bolt text-yellow-600"></i>
                        <span class="text-sm font-semibold text-gray-700">Rapide</span>
                    </div>
                    <div class="flex items-center space-x-2 bg-white/80 backdrop-blur-sm px-4 py-2 rounded-full shadow-sm">
                        <i class="fas fa-check-circle text-primary-600"></i>
                        <span class="text-sm font-semibold text-gray-700">Fiable</span>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Right Side - Form -->
        <div class="w-full max-w-md mx-auto animate-fade-in" style="animation-delay: 0.2s;">
            <div class="bg-white rounded-3xl shadow-2xl overflow-hidden border border-gray-100">
                
                <!-- Header -->
                <div class="bg-gradient-to-r from-primary-600 to-purple-600 p-8 text-center">
                    <div class="w-20 h-20 bg-white/20 backdrop-blur-sm rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-lg">
                        <i class="fas fa-hospital text-white text-3xl"></i>
                    </div>
                    <h1 class="text-2xl font-bold text-white mb-2">Réinitialisation</h1>
                    <p class="text-primary-100 text-sm">Récupérez l'accès à votre compte</p>
                </div>
                
                <!-- Form Content -->
                <div class="p-8">
                    
                    <!-- Success Message (hidden by default) -->
                    <div id="success-message" class="hidden mb-6 p-4 bg-green-50 border-l-4 border-green-500 rounded-lg">
                        <div class="flex items-start">
                            <i class="fas fa-check-circle text-green-600 text-xl mr-3 mt-1"></i>
                            <div>
                                <p class="font-semibold text-green-800">Email envoyé avec succès !</p>
                                <p class="text-sm text-green-700 mt-1">
                                    Vérifiez votre boîte de réception et suivez les instructions pour réinitialiser votre mot de passe.
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Error Message (hidden by default) -->
                    <div id="error-message" class="hidden mb-6 p-4 bg-red-50 border-l-4 border-red-500 rounded-lg">
                        <div class="flex items-start">
                            <i class="fas fa-exclamation-circle text-red-600 text-xl mr-3 mt-1"></i>
                            <div>
                                <p class="font-semibold text-red-800">Erreur</p>
                                <p class="text-sm text-red-700 mt-1" id="error-text">
                                    Cette adresse email n'est pas enregistrée dans notre système.
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <form id="forgotPasswordForm" action="${pageContext.request.contextPath}/auth/forgot-password" method="post">
                        <div class="mb-6">
                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                <i class="fas fa-envelope text-primary-600 mr-2"></i>Adresse email
                            </label>
                            <div class="relative">
                                <input type="email" name="email" id="email" required
                                       placeholder="votre.email@example.com"
                                       class="w-full px-4 py-3 pl-12 border border-gray-300 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all text-gray-900">
                                <i class="fas fa-envelope absolute left-4 top-1/2 -translate-y-1/2 text-gray-400"></i>
                            </div>
                            <p class="text-xs text-gray-500 mt-2">
                                Entrez l'adresse email associée à votre compte
                            </p>
                        </div>
                        
                        <button type="submit" id="submit-btn"
                                class="w-full bg-gradient-to-r from-primary-600 to-purple-600 hover:from-primary-700 hover:to-purple-700 text-white font-bold py-3 px-4 rounded-xl transition-all transform hover:scale-[1.02] shadow-lg shadow-primary-600/30">
                            <i class="fas fa-paper-plane mr-2"></i>
                            <span id="submit-text">Envoyer le lien de réinitialisation</span>
                        </button>
                        
                        <div class="mt-6 text-center">
                            <a href="${pageContext.request.contextPath}/auth/login" 
                               class="text-primary-600 hover:text-primary-700 font-semibold text-sm inline-flex items-center">
                                <i class="fas fa-arrow-left mr-2"></i>
                                Retour à la connexion
                            </a>
                        </div>
                    </form>
                    
                    <!-- Info Box -->
                    <div class="mt-8 p-4 bg-blue-50 rounded-xl border border-blue-200">
                        <div class="flex items-start">
                            <i class="fas fa-info-circle text-blue-600 text-xl mr-3 mt-1"></i>
                            <div class="text-sm text-blue-800">
                                <p class="font-semibold mb-2">Besoin d'aide ?</p>
                                <p class="mb-2">Si vous ne recevez pas l'email dans quelques minutes :</p>
                                <ul class="list-disc list-inside space-y-1 text-xs">
                                    <li>Vérifiez votre dossier spam/courrier indésirable</li>
                                    <li>Assurez-vous d'avoir entré la bonne adresse email</li>
                                    <li>Contactez notre support technique</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
            
            <!-- Support Contact -->
            <div class="mt-6 text-center">
                <p class="text-sm text-gray-600 mb-3">Toujours des problèmes ?</p>
                <div class="flex justify-center gap-4">
                    <a href="tel:+212500000000" class="flex items-center space-x-2 text-primary-600 hover:text-primary-700 font-semibold">
                        <i class="fas fa-phone"></i>
                        <span>+212 5 00 00 00 00</span>
                    </a>
                    <a href="mailto:support@clinique.ma" class="flex items-center space-x-2 text-primary-600 hover:text-primary-700 font-semibold">
                        <i class="fas fa-envelope"></i>
                        <span>support@clinique.ma</span>
                    </a>
                </div>
            </div>
        </div>
        
    </div>
    
    <script>
        document.getElementById('forgotPasswordForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const submitBtn = document.getElementById('submit-btn');
            const submitText = document.getElementById('submit-text');
            const successMessage = document.getElementById('success-message');
            const errorMessage = document.getElementById('error-message');
            const errorText = document.getElementById('error-text');
            
            // Hide messages
            successMessage.classList.add('hidden');
            errorMessage.classList.add('hidden');
            
            // Show loading state
            submitBtn.disabled = true;
            submitBtn.classList.add('opacity-75', 'cursor-not-allowed');
            submitText.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Envoi en cours...';
            
            try {
                const formData = new FormData(this);
                const response = await fetch(this.action, {
                    method: 'POST',
                    body: formData
                });
                
                const result = await response.json();
                
                if (response.ok && result.success) {
                    // Show success message
                    successMessage.classList.remove('hidden');
                    this.reset();
                } else {
                    // Show error message
                    errorText.textContent = result.message || 'Une erreur est survenue. Veuillez réessayer.';
                    errorMessage.classList.remove('hidden');
                }
            } catch (error) {
                // Show error message
                errorText.textContent = 'Impossible de se connecter au serveur. Vérifiez votre connexion internet.';
                errorMessage.classList.remove('hidden');
            } finally {
                // Reset button state
                submitBtn.disabled = false;
                submitBtn.classList.remove('opacity-75', 'cursor-not-allowed');
                submitText.innerHTML = '<i class="fas fa-paper-plane mr-2"></i>Envoyer le lien de réinitialisation';
            }
        });
    </script>
</body>
</html>
