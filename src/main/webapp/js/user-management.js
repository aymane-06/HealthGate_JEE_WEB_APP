// ============================================
// User Management System
// Advanced table with pagination, search, filters
// ============================================

const userManager = {
    // State management
    state: {
        currentPage: 1,
        pageSize: 10,
        searchTerm: '',
        roleFilter: '',
        statusFilter: '',
        sortField: '',
        sortOrder: 'asc',
        totalElements: 0,
        totalPages: 0,
        loading: false,
        abortController: null,
        contextPath: '' // Will be set from JSP
    },

    // Initialize
    init(contextPath) {
        this.state.contextPath = contextPath || '';
        this.bindEventListeners();
        this.loadUsers();
    },

    // Bind all event listeners
    bindEventListeners() {
        // Search with debouncing
        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            let searchTimeout;
            searchInput.addEventListener('input', (e) => {
                clearTimeout(searchTimeout);
                searchTimeout = setTimeout(() => {
                    this.state.searchTerm = e.target.value;
                    this.state.currentPage = 1;
                    this.loadUsers();
                }, 500); // 500ms debounce
            });
        }

        // Role filter
        const roleFilter = document.getElementById('roleFilter');
        if (roleFilter) {
            roleFilter.addEventListener('change', (e) => {
                this.state.roleFilter = e.target.value;
                this.state.currentPage = 1;
                this.loadUsers();
            });
        }

        // Status filter
        const statusFilter = document.getElementById('statusFilter');
        if (statusFilter) {
            statusFilter.addEventListener('change', (e) => {
                this.state.statusFilter = e.target.value;
                this.state.currentPage = 1;
                this.loadUsers();
            });
        }

        // Page size selector
        const pageSizeSelector = document.getElementById('pageSizeSelector');
        if (pageSizeSelector) {
            pageSizeSelector.addEventListener('change', (e) => {
                this.state.pageSize = parseInt(e.target.value);
                this.state.currentPage = 1;
                this.loadUsers();
            });
        }

        // Select all checkbox
        const selectAll = document.getElementById('selectAll');
        if (selectAll) {
            selectAll.addEventListener('change', (e) => {
                const checkboxes = document.querySelectorAll('#usersTableBody input[type="checkbox"]');
                checkboxes.forEach(cb => cb.checked = e.target.checked);
            });
        }
    },

    // Load users from API
    async loadUsers() {
        if (this.state.loading) {
            // Cancel previous request
            if (this.state.abortController) {
                this.state.abortController.abort();
            }
        }

        this.state.loading = true;
        this.state.abortController = new AbortController();
        
        this.showLoading(true);

        try {
            // Build URL with query parameters
            const params = new URLSearchParams({
                page: this.state.currentPage,
                size: this.state.pageSize
            });

            if (this.state.searchTerm) params.append('search', this.state.searchTerm);
            if (this.state.roleFilter) params.append('role', this.state.roleFilter);
            if (this.state.statusFilter) params.append('status', this.state.statusFilter);
            if (this.state.sortField) {
                params.append('sort', this.state.sortField);
                params.append('order', this.state.sortOrder);
            }

            const url = this.state.contextPath + '/api/admin/users?' + params.toString();
            
            const response = await fetch(url, {
                signal: this.state.abortController.signal
            });

            if (!response.ok) {
                throw new Error('Failed to fetch users');
            }

            const data = await response.json();

            if (data.status === 'success') {
                this.state.totalElements = data.data.pagination.totalElements;
                this.state.totalPages = data.data.pagination.totalPages;
                
                this.renderUsers(data.data.users);
                this.renderPagination();
                this.showToast('Utilisateurs chargés avec succès', 'success');
            } else {
                throw new Error(data.message || 'Unknown error');
            }

        } catch (error) {
            if (error.name === 'AbortError') {
                console.log('Request cancelled');
                return;
            }
            console.error('Error loading users:', error);
            this.showError('Erreur lors du chargement des utilisateurs', error.message);
            this.showEmptyState('error', 'Erreur de chargement', 'Impossible de charger les utilisateurs. Veuillez réessayer.');
        } finally {
            this.state.loading = false;
            this.showLoading(false);
        }
    },

    // Render users table
    renderUsers(users) {
        const tbody = document.getElementById('usersTableBody');
        
        if (!users || users.length === 0) {
            this.showEmptyState('empty', 'Aucun utilisateur trouvé', 'Aucun utilisateur ne correspond à vos critères de recherche.');
            return;
        }

        tbody.innerHTML = users.map(user => {
            const userId = this.escapeHtml(user.id);
            const userName = this.escapeHtml(user.name);
            const userEmail = this.escapeHtml(user.email);
            const userPhone = user.phone ? this.escapeHtml(user.phone) : 'N/A';
            const userInitial = user.name ? this.escapeHtml(user.name.substring(0, 1).toUpperCase()) : 'U';
            const userIdShort = this.escapeHtml(user.id.substring(0, 8));
            const statusClass = user.active ? 'bg-green-100 text-green-700 hover:bg-green-200' : 'bg-red-100 text-red-700 hover:bg-red-200';
            const statusIcon = user.active ? 'fa-check-circle' : 'fa-times-circle';
            const statusText = user.active ? 'Actif' : 'Inactif';
            const roleBadge = this.getRoleBadge(user.role);
            
            return '<tr class="hover:bg-gray-50 transition-colors">' +
                '<td class="px-6 py-4">' +
                    '<input type="checkbox" class="w-5 h-5 text-primary-600 rounded" value="' + userId + '">' +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap">' +
                    '<div class="flex items-center">' +
                        '<div class="w-10 h-10 bg-gradient-to-br from-primary-500 to-primary-600 rounded-full flex items-center justify-center text-white font-bold text-sm mr-3">' +
                            userInitial +
                        '</div>' +
                        '<div>' +
                            '<div class="font-semibold text-gray-900">' + userName + '</div>' +
                            '<div class="text-sm text-gray-500">ID: ' + userIdShort + '...</div>' +
                        '</div>' +
                    '</div>' +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap">' +
                    roleBadge +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">' +
                    '<i class="fas fa-envelope text-gray-400 mr-2"></i>' + userEmail +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">' +
                    '<i class="fas fa-phone text-gray-400 mr-2"></i>' + userPhone +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap">' +
                    '<button data-user-id="' + userId + '" data-user-status="' + user.active + '" ' +
                            'class="toggle-status-btn px-3 py-1 text-xs font-bold rounded-full transition-all ' + statusClass + '">' +
                        '<i class="fas ' + statusIcon + ' mr-1"></i>' +
                        statusText +
                    '</button>' +
                '</td>' +
                '<td class="px-6 py-4 whitespace-nowrap text-sm space-x-2">' +
                    '<button data-user-id="' + userId + '" class="view-user-btn text-blue-600 hover:text-blue-700 font-semibold transition-colors" title="Voir">' +
                        '<i class="fas fa-eye"></i>' +
                    '</button>' +
                    '<button data-user-id="' + userId + '" class="edit-user-btn text-primary-600 hover:text-primary-700 font-semibold transition-colors" title="Modifier">' +
                        '<i class="fas fa-edit"></i>' +
                    '</button>' +
                    '<button data-user-id="' + userId + '" data-user-name="' + userName + '" ' +
                            'class="delete-user-btn text-red-600 hover:text-red-700 font-semibold transition-colors" title="Supprimer">' +
                        '<i class="fas fa-trash"></i>' +
                    '</button>' +
                '</td>' +
            '</tr>';
        }).join('');

        // Attach event listeners to dynamically created buttons
        this.attachRowEventListeners();
    },

    // Attach event listeners to row buttons
    attachRowEventListeners() {
        // Toggle status buttons
        document.querySelectorAll('.toggle-status-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const userId = e.currentTarget.dataset.userId;
                const currentStatus = e.currentTarget.dataset.userStatus === 'true';
                this.toggleStatus(userId, currentStatus);
            });
        });

        // View user buttons
        document.querySelectorAll('.view-user-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const userId = e.currentTarget.dataset.userId;
                this.viewUser(userId);
            });
        });

        // Edit user buttons
        document.querySelectorAll('.edit-user-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const userId = e.currentTarget.dataset.userId;
                this.editUser(userId);
            });
        });

        // Delete user buttons
        document.querySelectorAll('.delete-user-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const userId = e.currentTarget.dataset.userId;
                const userName = e.currentTarget.dataset.userName;
                this.confirmDelete(userId, userName);
            });
        });
    },

    // Render pagination controls
    renderPagination() {
        const currentPage = this.state.currentPage;
        const pageSize = this.state.pageSize;
        const totalPages = this.state.totalPages;
        const totalElements = this.state.totalElements;
        
        // Update info text
        const startIndex = totalElements === 0 ? 0 : (currentPage - 1) * pageSize + 1;
        const endIndex = Math.min(currentPage * pageSize, totalElements);
        
        const paginationInfo = document.getElementById('paginationInfo');
        if (paginationInfo) {
            paginationInfo.innerHTML = 
                'Affichage de <span class="font-semibold">' + startIndex + '</span> ' +
                'à <span class="font-semibold">' + endIndex + '</span> ' +
                'sur <span class="font-semibold">' + totalElements + '</span> utilisateurs';
        }

        // Generate pagination buttons
        const controls = document.getElementById('paginationControls');
        if (!controls) return;

        let html = '';

        // First button
        const firstDisabled = currentPage === 1;
        html += '<button data-page="1" class="pagination-btn px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors ' + 
                (firstDisabled ? 'opacity-50 cursor-not-allowed' : '') + '" ' +
                (firstDisabled ? 'disabled' : '') +
                ' title="Première page">' +
                '<i class="fas fa-angle-double-left"></i>' +
                '</button>';

        // Previous button
        html += '<button data-page="' + (currentPage - 1) + '" class="pagination-btn px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors ' + 
                (firstDisabled ? 'opacity-50 cursor-not-allowed' : '') + '" ' +
                (firstDisabled ? 'disabled' : '') +
                ' title="Page précédente">' +
                '<i class="fas fa-chevron-left"></i>' +
                '</button>';

        // Page numbers (smart display)
        const maxButtons = 5;
        let startPage = Math.max(1, currentPage - Math.floor(maxButtons / 2));
        let endPage = Math.min(totalPages, startPage + maxButtons - 1);
        
        if (endPage - startPage + 1 < maxButtons) {
            startPage = Math.max(1, endPage - maxButtons + 1);
        }

        if (startPage > 1) {
            html += '<span class="px-2 text-gray-400">...</span>';
        }

        for (let i = startPage; i <= endPage; i++) {
            const isActive = i === currentPage;
            html += '<button data-page="' + i + '" class="pagination-btn px-4 py-2 rounded-lg font-semibold transition-colors ' + 
                    (isActive ? 'bg-primary-600 text-white' : 'border border-gray-300 hover:bg-gray-50') + '">' +
                    i +
                    '</button>';
        }

        if (endPage < totalPages) {
            html += '<span class="px-2 text-gray-400">...</span>';
        }

        // Next button
        const lastDisabled = currentPage === totalPages;
        html += '<button data-page="' + (currentPage + 1) + '" class="pagination-btn px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors ' + 
                (lastDisabled ? 'opacity-50 cursor-not-allowed' : '') + '" ' +
                (lastDisabled ? 'disabled' : '') +
                ' title="Page suivante">' +
                '<i class="fas fa-chevron-right"></i>' +
                '</button>';

        // Last button
        html += '<button data-page="' + totalPages + '" class="pagination-btn px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors ' + 
                (lastDisabled ? 'opacity-50 cursor-not-allowed' : '') + '" ' +
                (lastDisabled ? 'disabled' : '') +
                ' title="Dernière page">' +
                '<i class="fas fa-angle-double-right"></i>' +
                '</button>';

        controls.innerHTML = html;

        // Attach click handlers to pagination buttons
        document.querySelectorAll('.pagination-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                if (!e.currentTarget.disabled) {
                    const page = parseInt(e.currentTarget.dataset.page);
                    this.goToPage(page);
                }
            });
        });
    },

    // Helper functions
    goToPage(page) {
        if (page < 1 || page > this.state.totalPages) return;
        this.state.currentPage = page;
        this.loadUsers();
    },

    sortBy(field) {
        if (this.state.sortField === field) {
            this.state.sortOrder = this.state.sortOrder === 'asc' ? 'desc' : 'asc';
        } else {
            this.state.sortField = field;
            this.state.sortOrder = 'asc';
        }
        this.loadUsers();
    },

    async toggleStatus(userId, currentStatus) {
        if (!confirm(`Voulez-vous vraiment ${currentStatus ? 'désactiver' : 'activer'} cet utilisateur ?`)) {
            return;
        }

        try {
            const response = await fetch(this.state.contextPath + '/api/admin/users/' + userId + '/status', {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ active: !currentStatus })
            });

            if (response.ok) {
                this.showToast('Statut mis à jour avec succès', 'success');
                this.loadUsers();
            } else {
                throw new Error('Failed to update status');
            }
        } catch (error) {
            this.showToast('Erreur lors de la mise à jour du statut', 'error');
        }
    },

    viewUser(userId) {
        // TODO: Implement view user functionality
        console.log('View user:', userId);
        this.showToast('Fonction de visualisation à implémenter', 'info');
    },

    editUser(userId) {
        // TODO: Implement edit user functionality
        console.log('Edit user:', userId);
        this.showToast('Fonction d\'édition à implémenter', 'info');
    },

    confirmDelete(userId, userName) {
        if (confirm('Êtes-vous sûr de vouloir supprimer l\'utilisateur "' + userName + '" ? Cette action est irréversible.')) {
            this.deleteUser(userId);
        }
    },

    async deleteUser(userId) {
        try {
            // TODO: Implement delete endpoint
            this.showToast('Fonction de suppression à implémenter', 'info');
        } catch (error) {
            this.showToast('Erreur lors de la suppression', 'error');
        }
    },

    showLoading(show) {
        const overlay = document.getElementById('loadingOverlay');
        if (overlay) {
            if (show) {
                overlay.classList.remove('hidden');
            } else {
                overlay.classList.add('hidden');
            }
        }
    },

    showEmptyState(type, title, message) {
        const tbody = document.getElementById('usersTableBody');
        if (!tbody) return;

        const icon = type === 'error' ? 'fa-exclamation-triangle' : 'fa-users';
        const color = type === 'error' ? 'text-red-600' : 'text-gray-500';
        const retryButton = type === 'error' ? 
            '<button class="retry-load-btn mt-4 px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors">Réessayer</button>' : '';
        
        tbody.innerHTML = 
            '<tr>' +
                '<td colspan="7" class="px-6 py-12 text-center">' +
                    '<div class="flex flex-col items-center space-y-3">' +
                        '<i class="fas ' + icon + ' text-5xl ' + color + '"></i>' +
                        '<h3 class="text-xl font-bold text-gray-900">' + this.escapeHtml(title) + '</h3>' +
                        '<p class="text-gray-600">' + this.escapeHtml(message) + '</p>' +
                        retryButton +
                    '</div>' +
                '</td>' +
            '</tr>';

        // Attach retry button handler
        const retryBtn = tbody.querySelector('.retry-load-btn');
        if (retryBtn) {
            retryBtn.addEventListener('click', () => this.loadUsers());
        }
    },

    showError(title, message) {
        this.showToast(title + ': ' + message, 'error');
    },

    showToast(message, type) {
        if (!type) type = 'success';
        
        // Remove existing toast
        const existing = document.getElementById('toast');
        if (existing) existing.remove();

        const toast = document.createElement('div');
        toast.id = 'toast';
        const colors = {
            success: 'bg-green-600',
            error: 'bg-red-600',
            info: 'bg-blue-600',
            warning: 'bg-orange-600'
        };
        const icons = {
            success: 'fa-check-circle',
            error: 'fa-times-circle',
            info: 'fa-info-circle',
            warning: 'fa-exclamation-triangle'
        };

        toast.className = 'fixed bottom-6 right-6 z-50 px-6 py-4 rounded-lg shadow-2xl text-white font-semibold flex items-center space-x-3 animate-slide-in ' + colors[type];
        toast.innerHTML = '<i class="fas ' + icons[type] + ' text-xl"></i><span>' + this.escapeHtml(message) + '</span>';

        document.body.appendChild(toast);

        setTimeout(() => {
            toast.classList.add('opacity-0', 'translate-x-full', 'transition-all');
            setTimeout(() => toast.remove(), 300);
        }, 3000);
    },

    getRoleBadge(role) {
        const configs = {
            'ADMIN': { label: 'Admin', icon: 'fa-user-shield', bg: 'bg-orange-100', text: 'text-orange-700' },
            'DOCTOR': { label: 'Médecin', icon: 'fa-user-md', bg: 'bg-secondary-100', text: 'text-secondary-700' },
            'PATIENT': { label: 'Patient', icon: 'fa-user-injured', bg: 'bg-blue-100', text: 'text-blue-700' },
            'STAFF': { label: 'Personnel', icon: 'fa-user-tie', bg: 'bg-purple-100', text: 'text-purple-700' }
        };
        const config = configs[role] || configs['PATIENT'];
        return '<span class="px-3 py-1 text-xs font-bold rounded-full ' + config.bg + ' ' + config.text + '">' +
                    '<i class="fas ' + config.icon + ' mr-1"></i>' + config.label +
                '</span>';
    },

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text || '';
        return div.innerHTML;
    }
};

// Export for use in other scripts
if (typeof module !== 'undefined' && module.exports) {
    module.exports = userManager;
}
