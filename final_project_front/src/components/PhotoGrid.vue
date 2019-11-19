<template>
  <div class="columns is-multiline">
    <div v-for="image in images" :key="image.id" class="column is-one-fifth">
      <ImageCard :image="image"></ImageCard>
    </div>
    <ModalPhoto :image="selectedImage" v-if="showModal"></ModalPhoto>
  </div>
</template>

<script>
  import ImageCard from './ImageCard'
  import ModalPhoto from './ModalPhoto'
  import 'es6-promise/auto'
  import { mapState } from 'vuex'

  export default {
    props: {
      images: Array,
    },
    data: function () {
      return {
      }
    },
    components: {
      ImageCard,
      ModalPhoto
    },
    computed: mapState({
      showModal (state) {
        return state.showSingleImageModal
      },
      selectedImage (state) {
        return state.modalImage
      }
    })
  }
</script>

<style scoped>
</style>
