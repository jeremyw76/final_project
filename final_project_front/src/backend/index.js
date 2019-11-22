import axios from 'axios'
import Store from '../vuex_store'
import 'es6-promise/auto'

const API_URL = 'http://localhost:3000'
const CSRF_TOKEN = 'X-CSRF-Token'
const vuexStore = Store.store

const securedAxiosInstance = axios.create({
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json'
  },
  csrfToken: null
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
      [CSRF_TOKEN]: securedAxiosInstance.csrfToken
    }
  }

  return config
})

securedAxiosInstance.interceptors.response.use(response => {
  if (response.headers['x-csrf-token']) {
    securedAxiosInstance.csrfToken = response.headers['x-csrf-token']
    return response
  }
}, error => {
  if (error.response && error.response.status && (error.response.status === 401 || error.response.status === 422)) {
    return plainAxiosInstance.post('/refresh.json', {}, {})
    .then(response => {
      securedAxiosInstance.csrfToken = response.data.csrf_token

      let retryConfig = error.response.config
      retryConfig.headers[CSRF_TOKEN] = response.data.csrf_token
      return plainAxiosInstance.request(retryConfig)
    }).catch(error => {
      vuexStore.commit('logOutUser')

      location.replace('/')
      return Promise.reject(error)
    })
  } else {
    return Promise.reject(error)
  }
})

export { securedAxiosInstance, plainAxiosInstance }
