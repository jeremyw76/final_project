<template>
  <div class="card">
    <div class="image">
      <img :src="image.small_url" @click="showImageModal"/>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    image: Object,
  },
  methods: {
    showImageModal () {
      console.log('Show modal')
    }
  }
}
</script>

<style scoped>
  img {
    cursor: pointer;
  }
</style>
