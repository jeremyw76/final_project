<template>
  <Navbar></Navbar>
</template>

<script>
import Navbar from '@/components/Navbar'
export default {
  created () {
    if (this.$store.state.cart.items.length === 0) {
      this.$router.replace('/photos')
    }
  },
  components: {
    Navbar
  }
}
</script>

<style scoped>

</style>
