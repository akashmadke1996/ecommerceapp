<template>
  <div class="home">
    <div class="hero">
      <h1>Welcome to Our Store</h1>
      <p>Discover amazing products at great prices</p>
      <router-link to="/products" class="cta-button">Shop Now</router-link>
    </div>
    
    <div class="featured-section">
      <h2>Featured Products</h2>
      <div class="products-grid" v-if="products.length">
        <ProductCard 
          v-for="product in products.slice(0, 6)" 
          :key="product.id" 
          :product="product"
          @add-to-cart="addToCart"
        />
      </div>
      <p v-else class="loading">{{ loading ? 'Loading products...' : 'No products available' }}</p>
    </div>
  </div>
</template>

<script>
import { onMounted, ref } from 'vue'
import ProductCard from '../components/ProductCard.vue'
import { useProductStore } from '../store/modules/products.js'
import { useCartStore } from '../store/modules/cart.js'

export default {
  components: {
    ProductCard
  },
  setup() {
    const productStore = useProductStore()
    const cartStore = useCartStore()
    const products = ref([])
    const loading = ref(false)

    const addToCart = (product) => {
      cartStore.addItem(product)
      alert('Added to cart!')
    }

    onMounted(async () => {
      loading.value = true
      try {
        await productStore.fetchAll(0, 6)
        products.value = productStore.products
      } catch (error) {
        console.error('Failed to load products:', error)
      } finally {
        loading.value = false
      }
    })

    return {
      products,
      loading,
      addToCart
    }
  }
}
</script>

<style scoped>
.home {
  width: 100%;
}

.hero {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 4rem 2rem;
  text-align: center;
  border-radius: 8px;
  margin-bottom: 3rem;
}

.hero h1 {
  font-size: 2.5rem;
  margin-bottom: 1rem;
}

.hero p {
  font-size: 1.2rem;
  margin-bottom: 2rem;
}

.cta-button {
  display: inline-block;
  background: white;
  color: #667eea;
  padding: 0.75rem 2rem;
  border-radius: 4px;
  text-decoration: none;
  font-weight: bold;
  transition: background 0.3s;
}

.cta-button:hover {
  background: #f0f0f0;
}

.featured-section h2 {
  font-size: 2rem;
  margin-bottom: 2rem;
  text-align: center;
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 2rem;
}

.loading {
  text-align: center;
  padding: 2rem;
  color: #999;
}
</style>
