// Clinique Digitale - Main JavaScript Functions

// Global utility functions
const CliniqueApp = {
    // Modal Management
    openModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.classList.add('show');
            document.body.style.overflow = 'hidden';
        }
    },

    closeModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.classList.remove('show');
            document.body.style.overflow = '';
        }
    },

    // Alert Messages
    showAlert(message, type = 'info') {
        const alertContainer = document.getElementById('alert-container');
        if (!alertContainer) return;

        const alert = document.createElement('div');
        alert.className = `alert alert-${type}`;
        alert.textContent = message;
        
        alertContainer.appendChild(alert);
        
        setTimeout(() => {
            alert.remove();
        }, 5000);
    },

    // Form Validation
    validateForm(formId) {
        const form = document.getElementById(formId);
        if (!form) return false;

        const inputs = form.querySelectorAll('.form-control[required]');
        let isValid = true;

        inputs.forEach(input => {
            if (!input.value.trim()) {
                input.classList.add('is-invalid');
                isValid = false;
            } else {
                input.classList.remove('is-invalid');
            }
        });

        return isValid;
    },

    // Date Formatting
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

    // Sidebar Toggle
    toggleSidebar() {
        const sidebar = document.querySelector('.sidebar');
        if (sidebar) {
            sidebar.classList.toggle('open');
        }
    },

    // Confirm Action
    confirmAction(message, callback) {
        if (confirm(message)) {
            callback();
        }
    },

    // AJAX Helper
    async fetchData(url, options = {}) {
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
            
            return await response.json();
        } catch (error) {
            console.error('Fetch error:', error);
            this.showAlert('Une erreur est survenue', 'danger');
            throw error;
        }
    },

    // Loading Spinner
    showLoading(elementId) {
        const element = document.getElementById(elementId);
        if (element) {
            element.innerHTML = '<div class="spinner-border" role="status"><span class="sr-only">Chargement...</span></div>';
        }
    },

    hideLoading(elementId) {
        const element = document.getElementById(elementId);
        if (element) {
            element.innerHTML = '';
        }
    }
};

// Initialize event listeners
document.addEventListener('DOMContentLoaded', () => {
    // Close modal when clicking outside
    document.querySelectorAll('.modal').forEach(modal => {
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                CliniqueApp.closeModal(modal.id);
            }
        });
    });

    // Close button handlers
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
});

// Export for use in other scripts
if (typeof module !== 'undefined' && module.exports) {
    module.exports = CliniqueApp;
}
