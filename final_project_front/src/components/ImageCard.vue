<template>
  <div class="card">
    <div class="image">
      <img :src="image.small_url" @click="showImageModal"/>
    </div>
  </div>
</template>

<script>
import 'es6-promise/auto'
import { store } from 'vuex'

export default {
  props: {
    image: Object,
  },
  methods: {
    showImageModal () {
      console.log('Show modal')
      this.$store.commit('showSingleImageModal', this.image.large_url)
    }
  }
}
</script>

<style scoped>
  img {
    cursor: pointer;
  }
</style>
