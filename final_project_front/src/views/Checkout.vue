<template>
  <div>
    <CheckoutNav></CheckoutNav>
    <div class="box">
      <div class="columns">
        <BillingDetails class="column is-one-half"></BillingDetails>
        <OrderDetails class="column is-one-half"></OrderDetails>
      </div>
      <PayButton></PayButton>
    </div>
  </div>
</template>

<script>
import CheckoutNav from '@/components/CheckoutNav'
import BillingDetails from '@/components/BillingDetails'
import OrderDetails from '@/components/OrderDetails'
import PayButton from '@/components/PayButton'

export default {
  created () {
    this.$store.dispatch('loadCheckout')
  },
  mounted () {
    this.$store.state.previousPage = '/checkout'

    if (this.$store.state.cart.items.length === 0) {
      this.$router.replace('/photos')
    }

    if (!this.$store.state.loggedIn) {
      this.$router.replace('/login')
    }

    this.$store.commit('clearTaxData')
  },
  components: {
    CheckoutNav,
    BillingDetails,
    OrderDetails,
    PayButton
  }
}
</script>

<style scoped>

</style>
