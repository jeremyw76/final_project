import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/views/Login'
import Home from '@/views/Home'
import loadFontAwesome from '@/fontawesome'
import Photos from '@/views/Photos'

loadFontAwesome();

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Home
    },
    {
      path: '/login',
      component: Login
    },
    {
      path: '/photos',
      component: Photos
    }
  ]
})
