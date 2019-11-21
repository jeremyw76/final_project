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
      },
      cart: {
        items: []
      },
      previousPage: '/'
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
        }
      },
      addToCart (state, cartItem) {
        state.cart.items.push(cartItem)
      },
      removeFromCart (state, cartItem) {
        let index = state.cart.items.findIndex(item => item.id === cartItem.id)

        if (index > -1) {
          state.cart.items.splice(index, 1)
        }
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
            console.log(response.data)
            if (response.data.cart) {
              response.data.cart.forEach(item => {
                console.log(item)
                commit('addToCart', item)
              })
            }

            postToCartUpdate(state, error => {})
          })
          .catch(error => console.log(error))
      }
    }
  })
}
