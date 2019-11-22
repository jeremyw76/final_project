<template>
  <div>
    <Navbar></Navbar>
    <CartForm></CartForm>
  </div>
</template>

<script>
import Navbar from '@/components/Navbar'
import CartForm from '@/components/CartForm'

export default {
  created () {
    this.bootIfNoCart()
  },
  mounted () {
    this.$store.state.previousPage = '/cart'
  },
  updated() {
    console.log('updated')
    this.bootIfNoCart()
  },
  computed: {
    cartCount () {

      if (this.$store.state.cart.items.length < 1) {
        this.$router.replace('/photos')
      }

      return this.$store.state.cart.items.length
    }
  },
  methods: {
    bootIfNoCart () {
      if (this.cartCount < 1) {
        this.$router.replace('/photos')
      }
    }
  },
  components: {
    Navbar,
    CartForm
  }
}
</script>

<style scoped>
</style>
