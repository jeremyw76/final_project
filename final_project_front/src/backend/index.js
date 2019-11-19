import axios from 'axios'
import Store from '../vuex_store'

const API_URL = 'http://localhost:3000'
const CSRF_TOKEN = 'X-CSRF-Token'
const store = Store.store

const securedAxiosInstance = axios.create({
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json'
  }
})

const plainAxiosInstance = axios.create({
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json'
  }
})

securedAxiosInstance.interceptors.request.use(config => {
  const method = config.method.toUpperCase()
  if (method !== 'OPTIONS' && method !== 'GET') {
    config.headers = {
      ...config.headers,
      CSRF_TOKEN: store.state.session.csrfToken
    }
  }

  return config
})

securedAxiosInstance.interceptors.response.use(null, error => {
  csrf_token = store.state.session.csrf_token
  if (error.response && error.response.config && error.response.status === 401) {
    return plainAxiosInstance.post('/refresh', {}, { headers: { CSRF_TOKEN: csrf_token }})
    .then(response => {
      store.commit('setCSRFToken', response.data.csrf_token)

      let retryConfig = error.response.config
      retryConfig.headers[CSRF_TOKEN] = response.data.csrf_token
      return plainAxiosInstance.request(retryConfig)
    }).catch(error => {
      store.commit('clearCSRFToken')
      store.commit('logOutUser')

      location.replace('/')
      return Promise.reject(error)
    })
  } else {
    return Promise.reject(error)
  }
})

export { securedAxiosInstance, plainAxiosInstance }
