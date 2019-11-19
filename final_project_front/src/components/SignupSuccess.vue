<template>
  <form class="card black" @submit.prevent="signin">
    <div>
      <p class="success">Success!</p>
    </div>
    <div class="field is-grouped is-grouped-centered">
      <div class="control">
        <button class="button is-link" type="submit" @click="logIn">Log In</button>
      </div>
    </div>
  </form>
</template>

<script>
export default {
  methods: {
    logIn () {
        this.$router.replace('/login')
    }
  }
}
</script>

<style scoped>

</style>
