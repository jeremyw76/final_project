import Vue from 'vue'
import { library } from '@fortawesome/fontawesome-svg-core'

import {
  faUserSecret,
  faEnvelope,
  faExclamationTriangle,
  faCartPlus,
  faMinus,
  faShoppingBasket,
  faShoppingCart
} from '@fortawesome/free-solid-svg-icons'

import { FontAwesomeIcon, FontAwesomeLayers } from '@fortawesome/vue-fontawesome'

export default () => {
  library.add(
    faUserSecret,
    faEnvelope,
    faExclamationTriangle,
    faCartPlus,
    faShoppingBasket,
    faMinus,
    faShoppingCart
  )

  Vue.component('font-awesome-icon', FontAwesomeIcon)
  Vue.component('font-awesome-layers', FontAwesomeLayers)

  Vue.config.productionTip = false
}
