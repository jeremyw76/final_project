<template>
  <div class="button is-success" :disabled="!!enabled">Proceed to Payment</div>
</template>

<script>
export default {
  computed: {
    enabled () {
      return this.$store.state.isValidOrder
    }
  }
}
</script>

<style scoped>

</style>
