<template>
  <div>
    <v-toolbar dark>
      <v-toolbar-title @click="redirectToHome">Home</v-toolbar-title>
    </v-toolbar>
  </div>
</template>

<script>
export default {
  methods: {
    redirectToHome () {
      this.$router.push('/')
    }
  }
}
</script>

<style scoped>
</style>
