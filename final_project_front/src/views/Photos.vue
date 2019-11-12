<template>
  <div>
    <Navbar></Navbar>
    <div class="level">
      <div class="level-left">
        <Paginator></Paginator>
      </div>
    </div>
  </div>
</template>

<script>
import Navbar from '@/components/Navbar'
import Paginator from '@/components/Paginator'
import PhotoGrid from '@/components/PhotoGrid'

export default {
components: {
    Navbar,
    Paginator,
    PhotoGrid
  }
}
</script>

<style scoped>
.columns {
  margin-top: 3em;
}
</style>
