import Vue from 'vue'
import Vuex from 'vuex'
import 'es6-promise/auto'

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
      session: {
        csrfToken: null
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
      setCSRFToken (state, token) {
        state.session.csrfToken = token
      },
      clearCSRFToken (state) {
        state.session.csrfToken = null
      },
      addToCart (state, cartItem) {
        state.cart.items.push(cartItem)
      },
      removeFromCart (state, cartItem) {
        let index = state.cart.items.findIndex(item => item.id === cartItem.id);

        if (index > -1) {
          state.cart.items.splice(index, 1)
        }
      }
    }
  })
}
