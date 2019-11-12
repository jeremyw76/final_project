import Vue from 'vue'
import { library } from '@fortawesome/fontawesome-svg-core'

import {
  faUserSecret,
  faEnvelope,
  faExclamationTriangle
} from '@fortawesome/free-solid-svg-icons'

import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

export default () => {
  library.add(
    faUserSecret,
    faEnvelope,
    faExclamationTriangle
  )

  Vue.component('font-awesome-icon', FontAwesomeIcon)

  Vue.config.productionTip = false
}
