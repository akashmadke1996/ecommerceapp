import { defineStore } from 'pinia'
import { ref } from 'vue'
import orderService from '../../services/orderService.js'

export const useOrderStore = defineStore('order', () => {
  const orders = ref([])
  const loading = ref(false)
  const error = ref(null)
  const total = ref(0)

  const fetchUserOrders = async (userId, page = 0, size = 10) => {
    loading.value = true
    error.value = null
    try {
      const response = await orderService.getUserOrders(userId, page, size)
      orders.value = response.data.content || response.data
      total.value = response.data.totalElements || orders.value.length
      return response.data
    } catch (err) {
      error.value = err.response?.data?.message || 'Failed to fetch orders'
      throw err
    } finally {
      loading.value = false
    }
  }

  const getOrderById = async (id) => {
    try {
      const response = await orderService.getById(id)
      return response.data
    } catch (err) {
      error.value = err.response?.data?.message || 'Failed to fetch order'
      throw err
    }
  }

  const createOrder = async (userId, orderData) => {
    loading.value = true
    error.value = null
    try {
      const response = await orderService.create(userId, orderData)
      orders.value.push(response.data)
      return response.data
    } catch (err) {
      error.value = err.response?.data?.message || 'Failed to create order'
      throw err
    } finally {
      loading.value = false
    }
  }

  return {
    orders,
    loading,
    error,
    total,
    fetchUserOrders,
    getOrderById,
    createOrder
  }
})
