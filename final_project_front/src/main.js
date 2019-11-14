// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from './backend/index'
import './../node_modules/bulma/css/bulma.css'
import Vuex from 'vuex'
import 'es6-promise/auto'

Vue.config.productionTip = false

Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})

Vue.use(Vuex)
const store = new Vuex.Store({
  state: {
    showSingleImageModal: false,
    singleImageUrl: '',
  },
  mutations: {
    showSingleImageModal (state, singleImageUrl) {
      state.showSingleImageModal = true;
      state.singleImageUrl = singleImageUrl;
    },
    hideSingleImageModal (state) {
      console.log('hiding')
      state.showSingleImageModal = false;
      this.singleImageUrl = ''
    }
  }
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  store,
  router,
  securedAxiosInstance,
  plainAxiosInstance,
  components: { App },
  template: '<App/>'
})
