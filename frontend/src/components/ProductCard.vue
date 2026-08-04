<template>
  <div class="product-card">
    <div class="image-container">
      <img :src="product.imageUrl || 'https://via.placeholder.com/250'" :alt="product.name" />
      <span v-if="product.quantity === 0" class="out-of-stock">Out of Stock</span>
    </div>
    <div class="card-content">
      <h3>{{ product.name }}</h3>
      <p class="description">{{ product.description?.substring(0, 60) }}...</p>
      <p class="category">{{ product.category }}</p>
      <div class="footer">
        <span class="price">${{ product.price }}</span>
        <button 
          @click="handleAddToCart" 
          :disabled="product.quantity === 0"
          class="add-btn"
        >
          Add to Cart
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    product: {
      type: Object,
      required: true
    }
  },
  emits: ['add-to-cart'],
  methods: {
    handleAddToCart() {
      this.$emit('add-to-cart', this.product)
    }
  }
}
</script>

<style scoped>
.product-card {
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s, box-shadow 0.3s;
}

.product-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.15);
}

.image-container {
  position: relative;
  width: 100%;
  height: 200px;
  overflow: hidden;
  background: #f0f0f0;
}

.image-container img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.out-of-stock {
  position: absolute;
  top: 10px;
  right: 10px;
  background: rgba(255, 107, 107, 0.9);
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 4px;
  font-size: 0.875rem;
}

.card-content {
  padding: 1rem;
}

.card-content h3 {
  margin: 0 0 0.5rem;
  font-size: 1.1rem;
  color: #333;
}

.description {
  font-size: 0.875rem;
  color: #666;
  margin: 0.5rem 0;
}

.category {
  font-size: 0.75rem;
  color: #999;
  margin: 0.5rem 0;
}

.footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 1rem;
}

.price {
  font-size: 1.5rem;
  font-weight: bold;
  color: #667eea;
}

.add-btn {
  background: #667eea;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
  transition: background 0.3s;
}

.add-btn:hover:not(:disabled) {
  background: #764ba2;
}

.add-btn:disabled {
  background: #ccc;
  cursor: not-allowed;
}
</style>
