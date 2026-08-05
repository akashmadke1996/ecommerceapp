import { defineStore } from 'pinia'
import { ref } from 'vue'
import productService from '../../services/productService.js'

export const useProductStore = defineStore('product', () => {
  const products = ref([])
  const loading = ref(false)
  const error = ref(null)
  const total = ref(0)

  const fetchAll = async (page = 0, size = 10) => {
    loading.value = true
    error.value = null
    try {
      const response = await productService.getAll(page, size)
      products.value = response.data.content || response.data
      total.value = response.data.totalElements || products.value.length
      return response.data
    } catch (err) {
      error.value = err.response?.data?.message || 'Failed to fetch products'
      throw err
    } finally {
      loading.value = false
    }
  }

  const search = async (name, page = 0, size = 10) => {
    loading.value = true
    error.value = null
    try {
      const response = await productService.search(name, page, size)
      products.value = response.data.content || response.data
      total.value = response.data.totalElements || products.value.length
      return response.data
    } catch (err) {
      error.value = err.response?.data?.message || 'Search failed'
      throw err
    } finally {
      loading.value = false
    }
  }

  const getByCategory = async (category, page = 0, size = 10) => {
    loading.value = true
    error.value = null
    try {
      const response = await productService.getByCategory(category, page, size)
      products.value = response.data.content || response.data
      total.value = response.data.totalElements || products.value.length
      return response.data
    } catch (err) {
      error.value = err.response?.data?.message || 'Failed to fetch products'
      throw err
    } finally {
      loading.value = false
    }
  }

  return {
    products,
    loading,
    error,
    total,
    fetchAll,
    search,
    getByCategory
  }
})
