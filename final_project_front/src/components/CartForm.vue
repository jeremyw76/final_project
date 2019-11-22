<template>
  <div class="cart-form">
    <h1 class="title">Cart</h1>
    <div class="row-container">
      <div v-for="item in items" v-bind:key="item.id">
        <CartItemRow :item="item"></CartItemRow>
      </div>
    </div>
  </div>
</template>

<script>
import 'es6-promise/auto'
import { store } from 'vuex'
import CartItemRow from '@/components/CartItemRow'

export default {
  computed: {
    items () {
      return this.$store.state.cart.items
    }
  },
  components: {
    CartItemRow
  }
}
</script>

<style scoped>
  .cart-form {
    margin-top: 2em;
  }
</style>
