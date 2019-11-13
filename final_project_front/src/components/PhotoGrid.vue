<template>
  <div class="columns">
    <div v-for="image in images" class="column">
      <ImageCard v-bind:image="image"></ImageCard>
    </div>
  </div>
</template>

<script>
import ImageCard from './ImageCard'

export default {
  props: {
    images: Array,
  },
  data: function () {
    return {
    }
  },
  components: {
    ImageCard
  }
}
</script>

<style scoped>
</style>
