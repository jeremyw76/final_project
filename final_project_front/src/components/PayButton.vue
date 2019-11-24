<template>
  <div class="button is-success" :disabled="!enabled" @click="processPayment">Proceed to Payment</div>
</template>

<script>
import 'es6-promise/auto'
import { store } from 'vuex'

export default {
  methods: {
    processPayment () {
      this.$store.dispatch('processOrder')
    }
  },
  computed: {
    enabled () {
      return this.$store.getters.isValidOrder
    }
  }
}
</script>

<style scoped>

</style>
