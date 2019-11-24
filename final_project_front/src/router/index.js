import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/views/Login'
import Home from '@/views/Home'
import loadFontAwesome from '@/fontawesome'
import Photos from '@/views/Photos'
import Signup from '@/views/Signup'
import SignupSuccess from '@/views/SignupSuccess'
import Cart from '@/views/Cart'
import Checkout from '@/views/Checkout'
import PaymentSuccess from '@/views/PaymentSuccess'
import PaymentError from '@/views/PaymentError'

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
      path: '/signup',
      component: Signup
    },
    {
      path: '/signup/success',
      component: SignupSuccess
    },
    {
      path: '/photos',
      component: Photos
    },
    {
      path: '/cart',
      component: Cart
    },
    {
      path: '/checkout',
      component: Checkout
    },
    {
      path: '/payment_success',
      component: PaymentSuccess
    },
    {
      path: '/payment_error',
      component: PaymentError
    }
  ]
})
