<template>
  <div>
    <Navbar></Navbar>
    <div class="columns is-centered is-vcentered">
      <div class="column is-full-mobile is-one-third-desktop">
        <Signin></Signin>
      </div>
    </div>
  </div>
</template>

<script>
import Navbar from '@/components/Navbar'
import Signin from '@/components/Signin'

export default {
components: {
    Navbar,
    Signin
  }
}
</script>

<style scoped>
.columns {
  margin-top: 3em;
}
</style>
