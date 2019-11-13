<template>
  <div class="card">
    <div class="image">
      <img :src="url">
    </div>
  </div>
</template>

<script>
export default {
  props: {
    image: String,
    url: String,
  },
  data: function () {
    return {
      url: 'no_url'
    }
  },
  created () {
    console.log('CREATED')
    this.url = this.image
  }
}
</script>

<style scoped>
</style>
