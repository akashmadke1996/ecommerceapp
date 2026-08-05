import api from './api'

export const productService = {
  getAll(page = 0, size = 10) {
    return api.get('/products', { params: { page, size } })
  },

  search(name, page = 0, size = 10) {
    return api.get('/products/search', { params: { name, page, size } })
  },

  getByCategory(category, page = 0, size = 10) {
    return api.get(`/products/category/${category}`, { params: { page, size } })
  },

  getById(id) {
    return api.get(`/products/${id}`)
  },

  create(product) {
    return api.post('/products', product)
  },

  update(id, product) {
    return api.put(`/products/${id}`, product)
  },

  delete(id) {
    return api.delete(`/products/${id}`)
  }
}

export default productService
