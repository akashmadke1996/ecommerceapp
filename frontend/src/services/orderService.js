import api from './api'

export const orderService = {
  getUserOrders(userId, page = 0, size = 10) {
    return api.get(`/orders/user/${userId}`, { params: { page, size } })
  },

  getById(id) {
    return api.get(`/orders/${id}`)
  },

  create(userId, order) {
    return api.post(`/orders/user/${userId}`, order)
  },

  updateStatus(id, status) {
    return api.put(`/orders/${id}/status`, null, { params: { status } })
  }
}

export default orderService
