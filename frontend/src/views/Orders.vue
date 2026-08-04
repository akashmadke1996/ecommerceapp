<template>
  <div class="orders-page">
    <h1>My Orders</h1>
    <div v-if="loading" class="loading">Loading orders...</div>
    <div v-else-if="orders.length" class="orders-list">
      <div v-for="order in orders" :key="order.id" class="order-card">
        <div class="order-header">
          <h3>Order #{{ order.id }}</h3>
          <span class="status" :class="order.status.toLowerCase()">{{ order.status }}</span>
        </div>
        <p><strong>Date:</strong> {{ formatDate(order.createdAt) }}</p>
        <p><strong>Total:</strong> ${{ order.totalAmount }}</p>
        <div class="items">
          <h4>Items:</h4>
          <ul>
            <li v-for="item in order.items" :key="item.id">
              {{ item.productName }} (x{{ item.quantity }}) - ${{ item.price }}
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div v-else class="empty">
      <p>No orders yet</p>
      <router-link to="/products">Start Shopping</router-link>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import { useOrderStore } from '../store/modules/orders.js'
import { useAuthStore } from '../store/modules/auth.js'

export default {
  setup() {
    const orderStore = useOrderStore()
    const auth = useAuthStore()
    const orders = ref([])
    const loading = ref(false)

    const formatDate = (date) => {
      return new Date(date).toLocaleDateString()
    }

    onMounted(async () => {
      loading.value = true
      try {
        await orderStore.fetchUserOrders(auth.user.id)
        orders.value = orderStore.orders
      } catch (error) {
        console.error('Failed to load orders:', error)
      } finally {
        loading.value = false
      }
    })

    return {
      orders,
      loading,
      formatDate
    }
  }
}
</script>

<style scoped>
.orders-page {
  max-width: 900px;
  margin: 0 auto;
}

.orders-list {
  display: grid;
  gap: 1.5rem;
  margin-top: 2rem;
}

.order-card {
  background: white;
  padding: 1.5rem;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  border-left: 4px solid #667eea;
}

.order-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.order-header h3 {
  margin: 0;
}

.status {
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: bold;
  color: white;
}

.status.pending {
  background: #ffc107;
  color: #333;
}

.status.confirmed {
  background: #17a2b8;
}

.status.shipped {
  background: #0275d8;
}

.status.delivered {
  background: #28a745;
}

.status.cancelled {
  background: #dc3545;
}

.items {
  margin-top: 1rem;
  padding-top: 1rem;
  border-top: 1px solid #eee;
}

.items h4 {
  margin: 0 0 0.5rem;
}

.items ul {
  list-style: none;
  padding: 0;
}

.items li {
  padding: 0.5rem 0;
  color: #666;
}

.loading {
  text-align: center;
  padding: 2rem;
  color: #999;
}

.empty {
  text-align: center;
  padding: 3rem;
  background: white;
  border-radius: 8px;
  margin-top: 2rem;
}

.empty a {
  display: inline-block;
  margin-top: 1rem;
  padding: 0.75rem 1.5rem;
  background: #667eea;
  color: white;
  text-decoration: none;
  border-radius: 4px;
}

.empty a:hover {
  background: #764ba2;
}
</style>
