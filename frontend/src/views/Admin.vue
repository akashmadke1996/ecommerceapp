<template>
  <div class="admin-page">
    <h1>Admin Dashboard</h1>
    <div class="admin-content">
      <div class="admin-section">
        <h2>Product Management</h2>
        <p>Manage products coming soon</p>
      </div>
      <div class="admin-section">
        <h2>Order Management</h2>
        <p>Manage orders coming soon</p>
      </div>
      <div class="admin-section">
        <h2>User Management</h2>
        <p>Manage users coming soon</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Admin'
}
</script>

<style scoped>
.admin-page {
  max-width: 1200px;
  margin: 0 auto;
}

.admin-content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.admin-section {
  background: white;
  padding: 2rem;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.admin-section h2 {
  margin-bottom: 1rem;
  color: #667eea;
}

.admin-section p {
  color: #666;
}
</style>
