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
    }
  },
  computed: {
    images () {
      return this.$store.state.images
    },
    errors () {
      return this.$store.state.errors
    }
  },
  created () {
    this.$store.dispatch('loadImages')
  },
}
</script>

<style scoped>
.columns {
  margin-top: 3em;
}
</style>
