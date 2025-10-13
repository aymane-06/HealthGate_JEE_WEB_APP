
    // ============================================
    // Department Management System
    // ============================================
    const  departmentManager = {
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
    searchInput.addEventListener('input', (e) => {
    clearTimeout(searchTimeout);
    searchTimeout = setTimeout(() => {
    this.state.searchTerm = e.target.value;
    this.state.currentPage = 1;
    this.loadDepartments();
}, 500);
});
}

    // Filters
    const statusFilter = document.getElementById('statusFilter');
    const sortBy = document.getElementById('sortBy');

    if (statusFilter) {
    statusFilter.addEventListener('change', (e) => {
    this.state.statusFilter = e.target.value;
    this.state.currentPage = 1;
    this.loadDepartments();
});
}

    if (sortBy) {
    sortBy.addEventListener('change', (e) => {
    this.state.sortBy = e.target.value;
    this.loadDepartments();
});
}

    // Form submission
    const form = document.getElementById('departmentForm');
    if (form) {
    form.addEventListener('submit', (e) => this.handleFormSubmit(e));
}
},

    async loadInitialData() {
    try {
    // Load doctors for head doctor selection
    const doctorsResponse = await fetch(this.state.contextPath + '/api/admin/doctors');
    if (doctorsResponse.ok) {
    const doctorsData = await doctorsResponse.json();
    this.state.doctors = doctorsData.data || [];
}

    // Load specialties for checkboxes
    const specialtiesResponse = await fetch(this.state.contextPath + '/api/admin/specialties');
    if (specialtiesResponse.ok) {
    const specialtiesData = await specialtiesResponse.json();
    this.state.specialties = specialtiesData.data?.specialties || [];
}

    this.populateFormSelects();
} catch (error) {
    console.error('Error loading initial data:', error);
}
},

    populateFormSelects() {
    // Populate head doctors dropdown
    const headDoctorSelect = document.querySelector('select[name="headDoctorId"]');
    if (headDoctorSelect && this.state.doctors.length > 0) {
    headDoctorSelect.innerHTML = '<option value="">Sélectionner un responsable</option>' +
    this.state.doctors.map(doctor =>
    `<option value="${doctor.id}">Dr. ${this.escapeHtml(doctor.firstName)} ${this.escapeHtml(doctor.lastName)}</option>`
    ).join('');
}

    // Populate specialties checkboxes
    const specialtiesContainer = document.getElementById('specialtiesContainer');
    if (specialtiesContainer && this.state.specialties.length > 0) {
    specialtiesContainer.innerHTML = this.state.specialties.map(specialty =>
    `<label class="flex items-center space-x-2 mb-2">
                        <input type="checkbox" name="specialties" value="${specialty.id}"
                               class="rounded border-gray-300 text-primary-600 focus:ring-primary-500">
                        <span class="text-sm text-gray-700">${this.escapeHtml(specialty.name)}</span>
                    </label>`
    ).join('');
}
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
    const response = await fetch(url, {
    signal: this.state.abortController.signal
});

    if (!response.ok) throw new Error('Failed to fetch departments');

    const data = await response.json();

    if (data.status === 'success') {
    this.state.totalElements = data.data.pagination.totalElements;
    this.state.totalPages = data.data.pagination.totalPages;
    this.state.departmentsCache = data.data.departments;

    this.renderDepartments(data.data.departments);
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
    const emptyMessage = `
                    <div class="col-span-full text-center py-12">
                        <i class="fas fa-building text-5xl text-gray-400 mb-4"></i>
                        <p class="text-gray-600">Aucun département trouvé</p>
                        <button onclick="departmentManager.openAddModal()" class="mt-4 px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors">
                            <i class="fas fa-plus mr-2"></i>Ajouter un département
                        </button>
                    </div>
                `;
    cardView.innerHTML = emptyMessage;
    listViewBody.innerHTML = '<tr><td colspan="6" class="px-6 py-8 text-center text-gray-500">Aucun département trouvé</td></tr>';
    return;
}

    // Render card view
    cardView.innerHTML = departments.map(dept => this.createDepartmentCard(dept)).join('');

    // Render list view
    listViewBody.innerHTML = departments.map(dept => this.createDepartmentRow(dept)).join('');

    this.attachEventListeners();
},

    createDepartmentCard(department) {
    const colorClass = this.getColorClass(department.color);
    const statusClass = department.status === 'ACTIVE'
    ? 'bg-green-100 text-green-800'
    : 'bg-red-100 text-red-800';
    const statusText = department.status === 'ACTIVE' ? 'Actif' : 'Inactif';

    return `
                <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-lg transition-all transform hover:-translate-y-1">
                    <div class="bg-gradient-to-br ${colorClass} p-6 text-white">
                        <div class="flex items-center justify-between">
                            <div class="w-16 h-16 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center">
                                <i class="fas fa-building text-3xl"></i>
                            </div>
                            <div class="text-right">
                                <p class="text-4xl font-bold">${department.staffCount || 0}</p>
                                <p class="text-white/80 text-sm">Personnel</p>
                            </div>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="flex items-start justify-between mb-2">
                            <h3 class="text-xl font-bold text-gray-900">${this.escapeHtml(department.name)}</h3>
                            <span class="px-3 py-1 text-xs font-bold rounded-full ${statusClass}">${statusText}</span>
                        </div>
                        <p class="text-sm text-gray-600 mb-2"><strong>Code:</strong> ${this.escapeHtml(department.code)}</p>
                        <p class="text-sm text-gray-600 mb-2"><strong>Localisation:</strong> ${this.escapeHtml(department.location || 'Non spécifiée')}</p>
                        <p class="text-sm text-gray-600 mb-4">${this.escapeHtml(department.description || 'Aucune description')}</p>

                        <div class="flex items-center justify-between text-sm text-gray-500 mb-4">
                            <span><i class="fas fa-user-md mr-2 text-primary-600"></i>${department.specialtiesCount || 0} spécialités</span>
                            <span><i class="fas fa-phone mr-2 text-primary-600"></i>${department.phone || 'N/A'}</span>
                        </div>

                        <div class="flex items-center space-x-2">
                            <button data-dept-id="${department.id}" class="view-dept-btn flex-1 px-4 py-2 bg-primary-50 text-primary-600 rounded-lg font-semibold hover:bg-primary-100 transition-colors">
                                <i class="fas fa-eye mr-2"></i>Voir
                            </button>
                            <button data-dept-id="${department.id}" class="edit-dept-btn px-4 py-2 bg-blue-50 text-blue-600 rounded-lg font-semibold hover:bg-blue-100 transition-colors">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button data-dept-id="${department.id}" data-dept-name="${this.escapeHtml(department.name)}"
                                    class="delete-dept-btn px-4 py-2 bg-red-50 text-red-600 rounded-lg font-semibold hover:bg-red-100 transition-colors">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </div>
                </div>
            `;
},

    createDepartmentRow(department) {
    const statusClass = department.status === 'ACTIVE'
    ? 'bg-green-100 text-green-800'
    : 'bg-red-100 text-red-800';
    const statusText = department.status === 'ACTIVE' ? 'Actif' : 'Inactif';

    const headDoctorName = department.headDoctor
    ? `Dr. ${this.escapeHtml(department.headDoctor.firstName)} ${this.escapeHtml(department.headDoctor.lastName)}`
    : 'Non assigné';

    return `
                <tr class="hover:bg-gray-50 transition-colors">
                    <td class="px-6 py-4 whitespace-nowrap">
                        <div class="flex items-center">
                            <div class="w-10 h-10 bg-gradient-to-br from-primary-500 to-primary-600 rounded-lg flex items-center justify-center text-white mr-3">
                                <i class="fas fa-building"></i>
                            </div>
                            <div>
                                <div class="font-semibold text-gray-900">${this.escapeHtml(department.name)}</div>
                                <div class="text-sm text-gray-500">${this.escapeHtml(department.code)}</div>
                            </div>
                        </div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                        ${headDoctorName}
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap">
                        <span class="px-3 py-1 text-xs font-bold rounded-full bg-blue-100 text-blue-700">
                            ${department.staffCount || 0} personnes
                        </span>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                        ${department.specialtiesCount || 0} spécialités
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap">
                        <span class="px-3 py-1 text-xs font-bold rounded-full ${statusClass}">${statusText}</span>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm space-x-2">
                        <button data-dept-id="${department.id}" class="view-dept-btn text-blue-600 hover:text-blue-700 font-semibold">
                            <i class="fas fa-eye"></i>
                        </button>
                        <button data-dept-id="${department.id}" class="edit-dept-btn text-primary-600 hover:text-primary-700 font-semibold">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button data-dept-id="${department.id}" data-dept-name="${this.escapeHtml(department.name)}"
                                class="delete-dept-btn text-red-600 hover:text-red-700 font-semibold">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
            `;
},

    attachEventListeners() {
    // Edit buttons
    document.querySelectorAll('.edit-dept-btn').forEach(btn => {
    btn.addEventListener('click', (e) => {
    this.editDepartment(e.currentTarget.dataset.deptId);
});
});

    // Delete buttons
    document.querySelectorAll('.delete-dept-btn').forEach(btn => {
    btn.addEventListener('click', (e) => {
    this.confirmDelete(e.currentTarget.dataset.deptId, e.currentTarget.dataset.deptName);
});
});

    // View buttons
    document.querySelectorAll('.view-dept-btn').forEach(btn => {
    btn.addEventListener('click', (e) => {
    this.viewDepartment(e.currentTarget.dataset.deptId);
});
});
},

    async editDepartment(departmentId) {
    const department = this.state.departmentsCache.find(d => d.id === departmentId);
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

    // Check specialties
    if (department.specialties) {
    document.querySelectorAll('input[name="specialties"]').forEach(checkbox => {
    checkbox.checked = department.specialties.some(s => s.id === checkbox.value);
});
}
},

    viewDepartment(departmentId) {
    const department = this.state.departmentsCache.find(d => d.id === departmentId);
    if (department) {
    // You can implement a detailed view modal here
    this.showToast(`Vue détaillée de ${department.name}`, 'info');
}
},

    confirmDelete(departmentId, departmentName) {
    if (confirm(`Êtes-vous sûr de vouloir supprimer le département "${departmentName}" ? Cette action est irréversible.`)) {
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
    specialties: Array.from(formData.getAll('specialties')).map(id => ({ id }))
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

    openModal(title = 'Nouveau Département') {
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
    document.getElementById('avgRating').textContent = stats.avgRating ? stats.avgRating.toFixed(1) : '0.0';
}
},

    renderPagination() {
    const paginationInfo = document.getElementById('paginationInfo');
    const paginationControls = document.getElementById('paginationControls');

    if (!paginationInfo || !paginationControls) return;

    const startItem = (this.state.currentPage - 1) * this.state.pageSize + 1;
    const endItem = Math.min(this.state.currentPage * this.state.pageSize, this.state.totalElements);

    paginationInfo.textContent = `Affichage de ${startItem} à ${endItem} sur ${this.state.totalElements} départements`;

    let buttons = '';

    // Previous button
    buttons += `
                <button onclick="departmentManager.changePage(${this.state.currentPage - 1})"
                        ${this.state.currentPage === 1 ? 'disabled' : ''}
                        class="px-3 py-2 border border-gray-300 rounded-lg ${this.state.currentPage === 1 ? 'bg-gray-100 text-gray-400' : 'hover:bg-gray-50'}">
                    <i class="fas fa-chevron-left"></i>
                </button>
            `;

    // Page numbers
    const maxVisiblePages = 5;
    let startPage = Math.max(1, this.state.currentPage - Math.floor(maxVisiblePages / 2));
    let endPage = Math.min(this.state.totalPages, startPage + maxVisiblePages - 1);

    if (endPage - startPage + 1 < maxVisiblePages) {
    startPage = Math.max(1, endPage - maxVisiblePages + 1);
}

    for (let i = startPage; i <= endPage; i++) {
    buttons += `
                    <button onclick="departmentManager.changePage(${i})"
                            class="px-3 py-2 border border-gray-300 rounded-lg ${this.state.currentPage === i ? 'bg-primary-600 text-white' : 'hover:bg-gray-50'}">
                        ${i}
                    </button>
                `;
}

    // Next button
    buttons += `
                <button onclick="departmentManager.changePage(${this.state.currentPage + 1})"
                        ${this.state.currentPage === this.state.totalPages ? 'disabled' : ''}
                        class="px-3 py-2 border border-gray-300 rounded-lg ${this.state.currentPage === this.state.totalPages ? 'bg-gray-100 text-gray-400' : 'hover:bg-gray-50'}">
                    <i class="fas fa-chevron-right"></i>
                </button>
            `;

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

    showToast(message, type = 'success') {
    const existing = document.getElementById('toast');
    if (existing) existing.remove();

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

    const toast = document.createElement('div');
    toast.id = 'toast';
    toast.className = `fixed bottom-6 right-6 z-50 px-6 py-4 rounded-lg shadow-2xl text-white font-semibold flex items-center space-x-3 ${colors[type]}`;
    toast.innerHTML = `<i class="fas ${icons[type]} text-xl"></i><span>${this.escapeHtml(message)}</span>`;

    document.body.appendChild(toast);

    setTimeout(() => {
    toast.classList.add('opacity-0', 'translate-x-full', 'transition-all');
    setTimeout(() => toast.remove(), 300);
}, 3000);
},

    getColorClass(color) {
    const colorMap = {
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
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}
};


