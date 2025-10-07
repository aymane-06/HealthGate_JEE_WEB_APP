// ============================================
// Clinique Digitale - Premium Animation System
// Modern UI/UX with Advanced Interactions
// ============================================

const CliniqueApp = {
    // ==========================================
    // Modal Management with Animations
    // ==========================================
    openModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.classList.add('show');
            document.body.style.overflow = 'hidden';
            
            // Add animation to modal content
            const modalDialog = modal.querySelector('.modal-dialog');
            if (modalDialog) {
                modalDialog.style.animation = 'none';
                setTimeout(() => {
                    modalDialog.style.animation = '';
                }, 10);
            }
        }
    },

    closeModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            const modalDialog = modal.querySelector('.modal-dialog');
            if (modalDialog) {
                modalDialog.style.animation = 'scaleOut 0.3s ease forwards';
            }
            
            setTimeout(() => {
                modal.classList.remove('show');
                document.body.style.overflow = '';
            }, 300);
        }
    },

    // ==========================================
    // Alert Messages with Auto-dismiss
    // ==========================================
    showAlert(message, type = 'info', duration = 5000) {
        let alertContainer = document.getElementById('alert-container');
        
        if (!alertContainer) {
            alertContainer = document.createElement('div');
            alertContainer.id = 'alert-container';
            alertContainer.style.cssText = `
                position: fixed;
                top: 2rem;
                right: 2rem;
                z-index: 9999;
                max-width: 400px;
            `;
            document.body.appendChild(alertContainer);
        }

        const alert = document.createElement('div');
        alert.className = `alert alert-${type}`;
        alert.innerHTML = `
            <div style="flex: 1;">${message}</div>
            <button class="close" onclick="this.parentElement.remove()" style="margin-left: 1rem;">×</button>
        `;
        
        alertContainer.appendChild(alert);
        
        // Auto-dismiss
        if (duration > 0) {
            setTimeout(() => {
                alert.style.opacity = '0';
                alert.style.transform = 'translateX(100%)';
                setTimeout(() => alert.remove(), 300);
            }, duration);
        }
    },

    // ==========================================
    // Form Validation with Visual Feedback
    // ==========================================
    validateForm(formId) {
        const form = document.getElementById(formId);
        if (!form) return false;

        const inputs = form.querySelectorAll('.form-control[required]');
        let isValid = true;
        let firstInvalidInput = null;

        inputs.forEach(input => {
            const value = input.value.trim();
            const type = input.type;
            let inputIsValid = true;

            if (!value) {
                inputIsValid = false;
            } else if (type === 'email') {
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                inputIsValid = emailPattern.test(value);
            } else if (type === 'tel') {
                const phonePattern = /^[\d\s\-+()]+$/;
                inputIsValid = phonePattern.test(value) && value.length >= 10;
            }

            if (!inputIsValid) {
                input.classList.add('is-invalid');
                isValid = false;
                if (!firstInvalidInput) {
                    firstInvalidInput = input;
                }
                
                // Add or update error message
                let feedback = input.parentElement.querySelector('.invalid-feedback');
                if (!feedback) {
                    feedback = document.createElement('div');
                    feedback.className = 'invalid-feedback';
                    input.parentElement.appendChild(feedback);
                }
                feedback.textContent = this.getErrorMessage(input);
            } else {
                input.classList.remove('is-invalid');
                const feedback = input.parentElement.querySelector('.invalid-feedback');
                if (feedback) feedback.remove();
            }
        });

        // Scroll to first invalid input
        if (firstInvalidInput) {
            firstInvalidInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
            firstInvalidInput.focus();
        }

        return isValid;
    },

    getErrorMessage(input) {
        const label = input.previousElementSibling?.textContent || 'Ce champ';
        if (!input.value.trim()) {
            return `${label} est requis`;
        }
        if (input.type === 'email') {
            return 'Veuillez entrer une adresse email valide';
        }
        if (input.type === 'tel') {
            return 'Veuillez entrer un numéro de téléphone valide';
        }
        return `${label} n'est pas valide`;
    },

    // ==========================================
    // Date & Time Formatting
    // ==========================================
    formatDate(dateString) {
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        return new Date(dateString).toLocaleDateString('fr-FR', options);
    },

    formatTime(timeString) {
        return new Date(`2000-01-01T${timeString}`).toLocaleTimeString('fr-FR', { 
            hour: '2-digit', 
            minute: '2-digit' 
        });
    },

    formatDateTime(dateTimeString) {
        const date = new Date(dateTimeString);
        return date.toLocaleString('fr-FR', {
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
    },

    // ==========================================
    // Sidebar Toggle with Animation
    // ==========================================
    toggleSidebar() {
        const sidebar = document.querySelector('.sidebar');
        if (sidebar) {
            sidebar.classList.toggle('open');
            
            // Add overlay for mobile
            let overlay = document.querySelector('.sidebar-overlay');
            if (!overlay) {
                overlay = document.createElement('div');
                overlay.className = 'sidebar-overlay';
                overlay.style.cssText = `
                    position: fixed;
                    inset: 0;
                    background: rgba(0, 0, 0, 0.5);
                    backdrop-filter: blur(4px);
                    z-index: 99;
                    display: none;
                `;
                overlay.onclick = () => this.toggleSidebar();
                document.body.appendChild(overlay);
            }
            
            if (sidebar.classList.contains('open')) {
                overlay.style.display = 'block';
                setTimeout(() => overlay.style.opacity = '1', 10);
            } else {
                overlay.style.opacity = '0';
                setTimeout(() => overlay.style.display = 'none', 300);
            }
        }
    },

    // ==========================================
    // Confirmation Dialog
    // ==========================================
    confirmAction(message, callback, cancelCallback = null) {
        if (confirm(message)) {
            callback();
        } else if (cancelCallback) {
            cancelCallback();
        }
    },

    // ==========================================
    // AJAX Helper with Loading States
    // ==========================================
    async fetchData(url, options = {}) {
        const loadingOverlay = this.showLoading();
        
        try {
            const response = await fetch(url, {
                ...options,
                headers: {
                    'Content-Type': 'application/json',
                    ...options.headers
                }
            });
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            const data = await response.json();
            this.hideLoading(loadingOverlay);
            return data;
        } catch (error) {
            console.error('Fetch error:', error);
            this.hideLoading(loadingOverlay);
            this.showAlert('Une erreur est survenue. Veuillez réessayer.', 'danger');
            throw error;
        }
    },

    // ==========================================
    // Loading Overlay
    // ==========================================
    showLoading(message = 'Chargement...') {
        const overlay = document.createElement('div');
        overlay.className = 'loading-overlay';
        overlay.style.cssText = `
            position: fixed;
            inset: 0;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(8px);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            gap: 1rem;
            z-index: 99999;
            animation: fadeIn 0.3s ease;
        `;
        overlay.innerHTML = `
            <div class="spinner"></div>
            <p style="color: var(--gray-700); font-weight: 500;">${message}</p>
        `;
        document.body.appendChild(overlay);
        return overlay;
    },

    hideLoading(overlay) {
        if (overlay && overlay.parentElement) {
            overlay.style.opacity = '0';
            setTimeout(() => overlay.remove(), 300);
        }
    },

    // ==========================================
    // Scroll Animations
    // ==========================================
    initScrollAnimations() {
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -100px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-fade-in-up');
                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);

        document.querySelectorAll('.card, .stat-card, .timeline-item').forEach(el => {
            observer.observe(el);
        });
    },

    // ==========================================
    // Number Counter Animation
    // ==========================================
    animateNumber(element, target, duration = 1500) {
        const start = 0;
        const increment = target / (duration / 16);
        let current = start;

        const timer = setInterval(() => {
            current += increment;
            if (current >= target) {
                element.textContent = Math.round(target);
                clearInterval(timer);
            } else {
                element.textContent = Math.round(current);
            }
        }, 16);
    },

    // ==========================================
    // Stat Cards Animation
    // ==========================================
    animateStatCards() {
        document.querySelectorAll('.stat-value').forEach(el => {
            const target = parseInt(el.textContent);
            if (!isNaN(target)) {
                el.textContent = '0';
                setTimeout(() => {
                    this.animateNumber(el, target, 2000);
                }, 200);
            }
        });
    },

    // ==========================================
    // Dropdown Menu Handler
    // ==========================================
    initDropdowns() {
        document.querySelectorAll('.dropdown').forEach(dropdown => {
            const toggle = dropdown.querySelector('[data-toggle="dropdown"]');
            if (toggle) {
                toggle.addEventListener('click', (e) => {
                    e.stopPropagation();
                    dropdown.classList.toggle('show');
                });
            }
        });

        // Close dropdowns when clicking outside
        document.addEventListener('click', () => {
            document.querySelectorAll('.dropdown.show').forEach(dropdown => {
                dropdown.classList.remove('show');
            });
        });
    },

    // ==========================================
    // Tabs Handler
    // ==========================================
    initTabs() {
        document.querySelectorAll('.nav-tab').forEach(tab => {
            tab.addEventListener('click', () => {
                const targetId = tab.dataset.target;
                
                // Remove active class from all tabs and panes
                document.querySelectorAll('.nav-tab').forEach(t => t.classList.remove('active'));
                document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
                
                // Add active class to clicked tab and target pane
                tab.classList.add('active');
                const targetPane = document.getElementById(targetId);
                if (targetPane) {
                    targetPane.classList.add('active');
                }
            });
        });
    },

    // ==========================================
    // Accordion Handler
    // ==========================================
    initAccordions() {
        document.querySelectorAll('.accordion-header').forEach(header => {
            header.addEventListener('click', () => {
                const body = header.nextElementSibling;
                const isActive = header.classList.contains('active');
                
                // Close all other accordions in the same container
                const parent = header.closest('.accordion');
                if (parent) {
                    parent.querySelectorAll('.accordion-header').forEach(h => {
                        h.classList.remove('active');
                        const b = h.nextElementSibling;
                        if (b) b.classList.remove('active');
                    });
                }
                
                // Toggle current accordion
                if (!isActive) {
                    header.classList.add('active');
                    if (body) body.classList.add('active');
                }
            });
        });
    },

    // ==========================================
    // Scroll to Top Button
    // ==========================================
    initScrollToTop() {
        let scrollBtn = document.querySelector('.scroll-top');
        
        if (!scrollBtn) {
            scrollBtn = document.createElement('button');
            scrollBtn.className = 'scroll-top';
            scrollBtn.innerHTML = '↑';
            scrollBtn.setAttribute('aria-label', 'Scroll to top');
            document.body.appendChild(scrollBtn);
        }

        window.addEventListener('scroll', () => {
            if (window.pageYOffset > 300) {
                scrollBtn.classList.add('show');
            } else {
                scrollBtn.classList.remove('show');
            }
        });

        scrollBtn.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    },

    // ==========================================
    // Form Input Animations
    // ==========================================
    initFormAnimations() {
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });

            input.addEventListener('blur', function() {
                if (!this.value) {
                    this.parentElement.classList.remove('focused');
                }
            });

            // Remove invalid class on input
            input.addEventListener('input', function() {
                if (this.classList.contains('is-invalid')) {
                    this.classList.remove('is-invalid');
                    const feedback = this.parentElement.querySelector('.invalid-feedback');
                    if (feedback) feedback.remove();
                }
            });
        });
    },

    // ==========================================
    // Initialize All Features
    // ==========================================
    init() {
        this.initScrollAnimations();
        this.initDropdowns();
        this.initTabs();
        this.initAccordions();
        this.initScrollToTop();
        this.initFormAnimations();
        
        // Animate stat cards if present
        if (document.querySelector('.stat-value')) {
            this.animateStatCards();
        }
    }
};

// ==========================================
// Initialize on DOM Ready
// ==========================================
document.addEventListener('DOMContentLoaded', () => {
    CliniqueApp.init();

    // Modal handlers
    document.querySelectorAll('.modal').forEach(modal => {
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                CliniqueApp.closeModal(modal.id);
            }
        });
    });

    document.querySelectorAll('.close').forEach(button => {
        button.addEventListener('click', () => {
            const modal = button.closest('.modal');
            if (modal) {
                CliniqueApp.closeModal(modal.id);
            }
        });
    });

    // Form validation on submit
    document.querySelectorAll('form[data-validate]').forEach(form => {
        form.addEventListener('submit', (e) => {
            if (!CliniqueApp.validateForm(form.id)) {
                e.preventDefault();
            }
        });
    });

    // Sidebar toggle button
    const sidebarToggle = document.getElementById('sidebar-toggle');
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', () => {
            CliniqueApp.toggleSidebar();
        });
    }

    // Add ripple effect to buttons
    document.querySelectorAll('.btn').forEach(button => {
        button.addEventListener('click', function(e) {
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;
            
            ripple.style.cssText = `
                position: absolute;
                width: ${size}px;
                height: ${size}px;
                top: ${y}px;
                left: ${x}px;
                background: rgba(255, 255, 255, 0.5);
                border-radius: 50%;
                pointer-events: none;
                transform: scale(0);
                animation: ripple 0.6s ease-out;
            `;
            
            this.appendChild(ripple);
            setTimeout(() => ripple.remove(), 600);
        });
    });

    // Add animation to page load
    document.body.style.opacity = '0';
    setTimeout(() => {
        document.body.style.transition = 'opacity 0.5s ease';
        document.body.style.opacity = '1';
    }, 100);
});

// Add ripple animation CSS
if (!document.getElementById('ripple-styles')) {
    const style = document.createElement('style');
    style.id = 'ripple-styles';
    style.textContent = `
        @keyframes ripple {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }
        @keyframes scaleOut {
            to {
                transform: scale(0.8);
                opacity: 0;
            }
        }
    `;
    document.head.appendChild(style);
}

// Export for use in other scripts
if (typeof module !== 'undefined' && module.exports) {
    module.exports = CliniqueApp;
}
