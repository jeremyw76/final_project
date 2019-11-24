<template>
  <div>
    <h1>Payment successfully made</h1>
    <div class="button" @click="backToShop">Back to Shop</div>
  </div>
</template>

<script>
export default {
  methods: {
    backToShop () {
      this.$router.push('/photos')
    }
  }
}
</script>

<style scoped>

</style>
