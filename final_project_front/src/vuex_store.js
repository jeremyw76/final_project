import Vue from 'vue'
import Vuex from 'vuex'
import 'es6-promise/auto'
import { securedAxiosInstance, plainAxiosInstance } from './backend/index'

Vue.use(Vuex)

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
        console.log('Adding items')
        commit('addToCart', cartItem)
        securedAxiosInstance.post('/carts/update.json', { items: state.cart.items })
          .catch(error => commit('removeFromCart', cartItem))
      }
    }
  })
}
