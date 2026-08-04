<template>
  <header class="header">
    <div class="header-container">
      <router-link to="/" class="logo">🛍️ ECommerce</router-link>
      
      <nav class="nav">
        <router-link to="/products">Products</router-link>
        <router-link to="/cart" class="cart-link">
          Cart <span v-if="cart.totalItems > 0" class="badge">{{ cart.totalItems }}</span>
        </router-link>
        
        <div class="auth-links" v-if="auth.isAuthenticated()">
          <span class="user-name">{{ auth.user?.firstName }}</span>
          <router-link v-if="auth.isAdmin()" to="/admin">Admin</router-link>
          <router-link to="/orders">Orders</router-link>
          <button @click="logout" class="logout-btn">Logout</button>
        </div>
        
        <div class="auth-links" v-else>
          <router-link to="/login">Login</router-link>
          <router-link to="/register">Register</router-link>
        </div>
      </nav>
    </div>
  </header>
</template>

<script>
import { useAuthStore } from '../store/modules/auth'
import { useCartStore } from '../store/modules/cart'
import { useRouter } from 'vue-router'

export default {
  setup() {
    const auth = useAuthStore()
    const cart = useCartStore()
    const router = useRouter()

    const logout = () => {
      auth.logout()
      router.push('/login')
    }

    return {
      auth,
      cart,
      logout
    }
  }
}
</script>

<style scoped>
.header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 1rem 0;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.header-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  font-size: 1.5rem;
  font-weight: bold;
  text-decoration: none;
  color: white;
}

.nav {
  display: flex;
  gap: 2rem;
  align-items: center;
}

.nav a {
  color: white;
  text-decoration: none;
  transition: opacity 0.3s;
}

.nav a:hover {
  opacity: 0.8;
}

.cart-link {
  position: relative;
}

.badge {
  position: absolute;
  top: -8px;
  right: -12px;
  background: #ff6b6b;
  color: white;
  border-radius: 50%;
  width: 20px;
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.75rem;
}

.auth-links {
  display: flex;
  gap: 1rem;
  align-items: center;
}

.user-name {
  font-weight: 500;
}

.logout-btn {
  background: #ff6b6b;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
  transition: background 0.3s;
}

.logout-btn:hover {
  background: #ff5252;
}
</style>
