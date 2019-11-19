import Vue from 'vue'
import Vuex from 'vuex'
import 'es6-promise/auto'

Vue.use(Vuex)

export default {
  store: new Vuex.Store({
    state: {
      showSingleImageModal: false,
      singleImageUrl: '',
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
      showSingleImageModal (state, singleImageUrl) {
        state.showSingleImageModal = true;
        state.singleImageUrl = singleImageUrl;
      },
      hideSingleImageModal (state) {
        state.showSingleImageModal = false;
        state.singleImageUrl = '';
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
      }
    }
  })
}
