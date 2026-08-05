import api from './api'

export const authService = {
  login(email, password) {
  alert('login called with email: ' + email + ' and password: ' + password);
    return api.post('/api/auth/login', { email, password })

  },

  register(email, password, firstName, lastName) {
    return api.post('/api/auth/register', {
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
