<template>
  <div class="cart-page">
    <h1>Shopping Cart</h1>
    <div class="cart-content" v-if="cart.items.length">
      <table class="cart-table">
        <thead>
          <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in cart.items" :key="item.id">
            <td>{{ item.name }}</td>
            <td>${{ item.price }}</td>
            <td>
              <input 
                type="number" 
                :value="item.quantity"
                @change="e => cart.updateQuantity(item.id, parseInt(e.target.value))"
                min="1"
              />
            </td>
            <td>${{ (item.price * item.quantity).toFixed(2) }}</td>
            <td>
              <button @click="cart.removeItem(item.id)" class="remove-btn">Remove</button>
            </td>
          </tr>
        </tbody>
      </table>
      <div class="cart-summary">
        <h3>Order Summary</h3>
        <p>Total Items: <strong>{{ cart.totalItems }}</strong></p>
        <p>Total Price: <strong>${{ cart.totalPrice.toFixed(2) }}</strong></p>
        <button @click="checkout" class="checkout-btn">Proceed to Checkout</button>
        <router-link to="/products" class="continue-shopping">Continue Shopping</router-link>
      </div>
    </div>
    <div v-else class="empty-cart">
      <p>Your cart is empty</p>
      <router-link to="/products">Continue Shopping</router-link>
    </div>
  </div>
</template>

<script>
import { useCartStore } from '../store/modules/cart.js'
import { useAuthStore } from '../store/modules/auth.js'
import { useOrderStore } from '../store/modules/orders.js'
import { useRouter } from 'vue-router'

export default {
  setup() {
    const cart = useCartStore()
    const auth = useAuthStore()
    const orderStore = useOrderStore()
    const router = useRouter()

    const checkout = async () => {
      try {
        const orderData = {
          items: cart.items.map(item => ({
            productId: item.id,
            quantity: item.quantity
          }))
        }
        await orderStore.createOrder(auth.user.id, orderData)
        cart.clearCart()
        alert('Order placed successfully!')
        router.push('/orders')
      } catch (error) {
        alert('Failed to place order')
      }
    }

    return {
      cart,
      checkout
    }
  }
}
</script>

<style scoped>
.cart-page {
  max-width: 1000px;
  margin: 0 auto;
}

.cart-content {
  display: grid;
  grid-template-columns: 1fr 300px;
  gap: 2rem;
  margin-top: 2rem;
}

.cart-table {
  width: 100%;
  border-collapse: collapse;
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.cart-table th, .cart-table td {
  padding: 1rem;
  text-align: left;
  border-bottom: 1px solid #eee;
}

.cart-table th {
  background: #f5f5f5;
  font-weight: bold;
}

.cart-table input {
  width: 60px;
  padding: 0.5rem;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.remove-btn {
  background: #ff6b6b;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
}

.remove-btn:hover {
  background: #ff5252;
}

.cart-summary {
  background: white;
  padding: 1.5rem;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  height: fit-content;
}

.cart-summary h3 {
  margin-bottom: 1rem;
}

.cart-summary p {
  margin-bottom: 0.5rem;
  display: flex;
  justify-content: space-between;
}

.checkout-btn {
  width: 100%;
  padding: 0.75rem;
  background: #667eea;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  margin-top: 1rem;
  font-weight: bold;
}

.checkout-btn:hover {
  background: #764ba2;
}

.continue-shopping {
  display: block;
  text-align: center;
  margin-top: 1rem;
  color: #667eea;
  text-decoration: none;
}

.empty-cart {
  text-align: center;
  padding: 3rem;
  background: white;
  border-radius: 8px;
  margin-top: 2rem;
}

.empty-cart p {
  margin-bottom: 1rem;
  font-size: 1.2rem;
  color: #666;
}

.empty-cart a {
  display: inline-block;
  padding: 0.75rem 1.5rem;
  background: #667eea;
  color: white;
  text-decoration: none;
  border-radius: 4px;
}

.empty-cart a:hover {
  background: #764ba2;
}
</style>
