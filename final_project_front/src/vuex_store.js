import Vue from 'vue'
import Vuex from 'vuex'
import 'es6-promise/auto'
import { securedAxiosInstance, plainAxiosInstance } from './backend/index'

Vue.use(Vuex)

const postToCartUpdate = (state, errorHandler) => {
  securedAxiosInstance.post('/carts/update.json', { items: state.cart.items })
      .catch(error => errorHandler(error))
}

export default {
  store: new Vuex.Store({
    state: {
      showSingleImageModal: false,
      modalImage: null,
      loggedIn: false,
      user: {
        name: null,
        paymentTokens: [],
        addresses: [],
      },
      cart: {
        items: []
      },
      previousPage: '/',
      images: [],
      page: 0,
      count: 0,
      errors: {
        customerDataError: null
      },
      provinces: [],
      taxes: {
        canCalculateTaxes: false,
        provinceId: undefined,
        rate: 0
      },
      shouldSaveAddress: true
    },
    mutations: {
      showSingleImageModal (state, image) {
        state.showSingleImageModal = true;
        state.modalImage = image;
      },
      hideSingleImageModal (state) {
        state.showSingleImageModal = false;
        state.modalImage = null;
      },
      logInUser (state, user) {
        state.loggedIn = true;
        state.user.name = user.name;
      },
      logOutUser (state) {
        state.loggedIn = false;
        state.user = {
          name: null,
          paymentTokens: [],
          addresses: []
        }
      },
      addToCart (state, cartItem) {
        let index = state.cart.items.findIndex(item => item.id === cartItem.id)

        if (index > -1) {
          state.cart.items[index].qty += 1
        } else {
          cartItem.qty = 1
          state.cart.items.push(cartItem)
        }
      },
      removeFromCart (state, cartItem) {
        let index = state.cart.items.findIndex(item => item.id === cartItem.id)

        if (index > -1) {
          if (state.cart.items[index].qty - 1 < 1) {
            state.cart.items.splice(index, 1)
          } else {
            state.cart.items[index].qty -= 1
          }
        }
      },
      canCalculateTaxes (state, payload)
      {
        state.taxes.provinceId = payload.provinceId
        state.taxes.canCalculateTaxes = payload.validProvince
        state.taxes.rate = state.provinces.find(province => province.id == payload.provinceId).tax_rate
      },
      clearTaxData (state) {
        state.taxes.canCalculateTaxes = false
        state.taxes.provinceId = null
        state.taxes.rate = 0
      },
      setShouldSaveAddress(state, shouldSaveAddress) {
        state.shouldSaveAddress = shouldSaveAddress
      }
    },
    actions: {
      addToCartAsync ({ commit, state }, cartItem) {
        commit('addToCart', cartItem)
        postToCartUpdate(state, error => commit('removeFromCart', cartItem))
      },
      removeFromCartAsync ({ commit, state }, cartItem) {
        commit('removeFromCart', cartItem)
        postToCartUpdate(state, error => commit('addToCart', cartItem))
      },
      clearCart({ commit, state }) {
        commit('clearCart')
        postToCartUpdate(state, {})
      },
      loadInitialData({ commit, state }) {
        plainAxiosInstance.get('/users.json')
          .then(response => {
            commit('logInUser', response.data.customer)

            if (response.data.cart) {
              response.data.cart.forEach(item => {
                commit('addToCart', item)
              })
            }

            postToCartUpdate(state, error => {})
          })
          .catch(error => console.log(error))
      },
      loadImages({ commit, state}) {
        plainAxiosInstance.get('/photos', { page: state.page, count: state.count })
        .then(response => {
          let knownIds = state.images.map(image => image.id)
          let unknownImages = response.data.images.filter(image => !knownIds.includes(image.id))
          state.images = [...state.images, ...unknownImages]
        })
        .catch(error => {
          state.errors.connectionError = error
        })
      },
      loadCheckout({ commit, state }) {
        securedAxiosInstance.post('/checkout.json')
          .then(response => {
            state.user.addresses = response.data.addresses
            state.provinces = response.data.provinces
            state.errors.customerDataError = null
          })
          .catch(error => {
            state.errors.customerDataError = error
          })
      }
    }
  })
}
