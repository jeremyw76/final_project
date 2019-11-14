<template>
  <div class="columns is-multiline">
    <div v-for="image in images" :key="image.id" class="column is-one-fifth">
      <ImageCard :image="image"></ImageCard>
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
