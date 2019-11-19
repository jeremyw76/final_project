<template>
  <div>
    <Navbar></Navbar>
    <div class="columns is-centered is-vcentered">
      <div class="column is-full-mobile is-one-third-desktop">
        <SignupSuccess></SignupSuccess>
      </div>
    </div>
  </div>
</template>

<script>
import Navbar from '@/components/Navbar'
import SignupSuccess from '@/components/SignupSuccess'

export default {
  components: {
      Navbar,
      SignupSuccess
    }
  }
</script>

<style scoped>
.columns {
  margin-top: 3em;
}
</style>
