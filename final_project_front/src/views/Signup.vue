<template>
  <div>
    <Navbar></Navbar>
    <div class="columns is-centered is-vcentered">
      <div class="column is-full-mobile is-one-third-desktop">
        <Register></Register>
      </div>
    </div>
  </div>
</template>

<script>
import Navbar from '@/components/Navbar'
import Register from '@/components/Register'

export default {
  components: {
      Navbar,
      Register
    }
  }
</script>

<style scoped>
.columns {
  margin-top: 3em;
}
</style>
