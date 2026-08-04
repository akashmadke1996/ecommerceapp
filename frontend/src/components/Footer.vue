<template>
  <footer class="footer">
    <div class="footer-content">
      <div class="footer-section">
        <h3>About</h3>
        <p>Your trusted online shopping destination</p>
      </div>
      <div class="footer-section">
        <h3>Quick Links</h3>
        <ul>
          <li><router-link to="/products">Products</router-link></li>
          <li><router-link to="/">Home</router-link></li>
        </ul>
      </div>
      <div class="footer-section">
        <h3>Contact</h3>
        <p>Email: support@ecommerce.com</p>
        <p>Phone: +1 (555) 123-4567</p>
      </div>
    </div>
    <div class="footer-bottom">
      <p>&copy; 2026 E-Commerce App. All rights reserved.</p>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'Footer'
}
</script>

<style scoped>
.footer {
  background: #1a1a1a;
  color: #fff;
  padding: 3rem 2rem 1rem;
  margin-top: auto;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  margin-bottom: 2rem;
}

.footer-section h3 {
  margin-bottom: 1rem;
  color: #667eea;
}

.footer-section ul {
  list-style: none;
}

.footer-section ul li {
  margin-bottom: 0.5rem;
}

.footer-section a {
  color: #ccc;
  text-decoration: none;
  transition: color 0.3s;
}

.footer-section a:hover {
  color: #667eea;
}

.footer-bottom {
  text-align: center;
  padding-top: 1rem;
  border-top: 1px solid #333;
  color: #999;
}
</style>
