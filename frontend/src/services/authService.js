import api from './api'

export const authService = {
  login(email, password) {
    return api.post('/auth/login', { email, password })
  },

  register(email, password, firstName, lastName) {
    return api.post('/auth/register', {
      email,
      password,
      firstName,
      lastName
    })
  },

  logout() {
    localStorage.removeItem('token')
    localStorage.removeItem('user')
  }
}

export default authService
