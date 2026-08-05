<template>
  <div class="register-container">
    <div class="register-form">
      <h2>Register</h2>
      <form @submit.prevent="handleRegister">
        <div class="form-group">
          <label for="firstName">First Name:</label>
          <input 
            id="firstName"
            v-model="form.firstName" 
            type="text" 
            required
            placeholder="Enter your first name"
          />
        </div>
        <div class="form-group">
          <label for="lastName">Last Name:</label>
          <input 
            id="lastName"
            v-model="form.lastName" 
            type="text"
            placeholder="Enter your last name"
          />
        </div>
        <div class="form-group">
          <label for="email">Email:</label>
          <input 
            id="email"
            v-model="form.email" 
            type="email" 
            required
            placeholder="Enter your email"
          />
        </div>
        <div class="form-group">
          <label for="password">Password:</label>
          <input 
            id="password"
            v-model="form.password" 
            type="password" 
            required
            placeholder="Enter your password"
          />
        </div>
        <button type="submit" class="btn" :disabled="auth.loading">
          {{ auth.loading ? 'Registering...' : 'Register' }}
        </button>
        <p v-if="auth.error" class="error">{{ auth.error }}</p>
      </form>
      <p class="login-link">
        Already have an account? <router-link to="/login">Login here</router-link>
      </p>
    </div>
  </div>
</template>

<script>
import { reactive } from 'vue'
import { useAuthStore } from '../store/modules/auth.js'
import { useRouter } from 'vue-router'

export default {
  setup() {
    const auth = useAuthStore()
    const router = useRouter()
    
    const form = reactive({
      firstName: '',
      lastName: '',
      email: '',
      password: ''
    })

    const handleRegister = async () => {
      try {
        await auth.register(form.email, form.password, form.firstName, form.lastName)
        router.push('/')
      } catch (error) {
        console.error('Registration failed:', error)
      }
    }

    return {
      form,
      auth,
      handleRegister
    }
  }
}
</script>

<style scoped>
.register-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 60vh;
}

.register-form {
  background: white;
  padding: 2rem;
  border-radius: 8px;
  box-shadow: 0 2px 16px rgba(0, 0, 0, 0.1);
  width: 100%;
  max-width: 400px;
}

.register-form h2 {
  text-align: center;
  margin-bottom: 2rem;
  color: #333;
}

.form-group {
  margin-bottom: 1.5rem;
}

label {
  display: block;
  margin-bottom: 0.5rem;
  color: #333;
  font-weight: 500;
}

input {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 1rem;
  transition: border-color 0.3s;
}

input:focus {
  outline: none;
  border-color: #667eea;
}

.btn {
  width: 100%;
  padding: 0.75rem;
  background: #667eea;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 1rem;
  cursor: pointer;
  transition: background 0.3s;
  font-weight: 500;
}

.btn:hover:not(:disabled) {
  background: #764ba2;
}

.btn:disabled {
  background: #ccc;
  cursor: not-allowed;
}

.error {
  color: #ff6b6b;
  margin-top: 1rem;
  text-align: center;
}

.login-link {
  text-align: center;
  margin-top: 1rem;
  color: #666;
}

.login-link a {
  color: #667eea;
  text-decoration: none;
}

.login-link a:hover {
  text-decoration: underline;
}
</style>
