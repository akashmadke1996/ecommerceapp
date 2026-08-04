<template>
  <div class="products">
    <h1>Products</h1>
    <div class="search-bar">
      <input 
        v-model="searchQuery" 
        @keyup.enter="search"
        type="text" 
        placeholder="Search products..."
      />
      <button @click="search">Search</button>
    </div>
    <div class="products-grid" v-if="products.length">
      <ProductCard 
        v-for="product in products" 
        :key="product.id" 
        :product="product"
        @add-to-cart="addToCart"
      />
    </div>
    <p v-else class="loading">{{ loading ? 'Loading...' : 'No products found' }}</p>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import ProductCard from '../components/ProductCard.vue'
import { useProductStore } from '../store/modules/products.js'
import { useCartStore } from '../store/modules/cart.js'

export default {
  components: { ProductCard },
  setup() {
    const productStore = useProductStore()
    const cartStore = useCartStore()
    const searchQuery = ref('')
    const products = ref([])
    const loading = ref(false)

    const loadProducts = async () => {
      loading.value = true
      try {
        await productStore.fetchAll()
        products.value = productStore.products
      } catch (error) {
        console.error('Failed to load products:', error)
      } finally {
        loading.value = false
      }
    }

    const search = async () => {
      if (!searchQuery.value) {
        loadProducts()
        return
      }
      loading.value = true
      try {
        await productStore.search(searchQuery.value)
        products.value = productStore.products
      } catch (error) {
        console.error('Search failed:', error)
      } finally {
        loading.value = false
      }
    }

    const addToCart = (product) => {
      cartStore.addItem(product)
      alert('Added to cart!')
    }

    onMounted(loadProducts)

    return {
      searchQuery,
      products,
      loading,
      search,
      addToCart
    }
  }
}
</script>

<style scoped>
.products {
  max-width: 1200px;
  margin: 0 auto;
}

.products h1 {
  margin-bottom: 2rem;
}

.search-bar {
  display: flex;
  gap: 1rem;
  margin-bottom: 2rem;
}

.search-bar input {
  flex: 1;
  padding: 0.75rem;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.search-bar button {
  padding: 0.75rem 1.5rem;
  background: #667eea;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.search-bar button:hover {
  background: #764ba2;
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
