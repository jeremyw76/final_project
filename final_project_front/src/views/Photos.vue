<template>
  <div>
    <Navbar></Navbar>
    <div class="level">
      <div class="level-left">
        <Paginator></Paginator>
      </div>
      <div class="level-right">
        <SearchBar></SearchBar>
      </div>
    </div>
    <PhotoGrid :images="images"></PhotoGrid>
  </div>
</template>

<script>
import Navbar from '@/components/Navbar'
import Paginator from '@/components/Paginator'
import PhotoGrid from '@/components/PhotoGrid'
import SearchBar from '@/components/SearchBar'

export default {
  components: {
    Navbar,
    Paginator,
    PhotoGrid,
    SearchBar
  },
  data: function () {
    return {
      images: [],
      page: 0,
      count: 15,
      errors: {},
    }
  },
  created () {
    this.loadPhotos()
  },
  methods: {
    loadPhotos () {
      this.$http.plain.get('/photos', { page: this.page, count: this.count })
          .then(response => this.loadPhotosSuccessful(response))
          .catch(error => this.loadPhotosFailed(error))
    },
    loadPhotosSuccessful (response) {
      this.images = response.data.images
    },
    loadPhotosFailed (error) {
      errors.connectionError = error
    }
  }
}
</script>

<style scoped>
.columns {
  margin-top: 3em;
}
</style>
