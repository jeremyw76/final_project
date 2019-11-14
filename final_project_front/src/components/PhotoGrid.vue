<template>
  <div class="columns is-multiline">
    <div v-for="image in images" :key="image.id" class="column is-one-fifth">
      <ImageCard :image="image"></ImageCard>
    </div>
    <ModalPhoto :imageUrl="singleImageUrl" v-if="showModal"></ModalPhoto>
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
        singleImageUrl: '',
      }
    },
    components: {
      ImageCard,
      ModalPhoto
    },
    computed: mapState({
      showModal (state) {
        this.singleImageUrl = state.singleImageUrl;
        return state.showSingleImageModal;
      }
    })
  }
</script>

<style scoped>
</style>
