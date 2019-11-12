<template>
  <form class="card black" @submit.prevent="signin">
    <div class="field is-horizontal">
      <label class="field-label" for="email">Email</label>
      <div class="control has-icons-left has-icons-right">
        <input class="input" type="email" id="email" placeholder="Email input">
        <span class="icon is-small is-left">
          <font-awesome-icon :icon="['fas', 'envelope']"></font-awesome-icon>
        </span>
      </div>
    </div>
    <p class="help is-danger" v-if="error">
      <span class="icon is-small is-right">
        <font-awesome-icon :icon="['fas','exclamation-triangle']"></font-awesome-icon>
      </span>
      This email is invalid
    </p>

    <div class="field is-horizontal">
      <label class="field-label" for="password">Password</label>
      <div class="control has-icons-left has-icons-right">
        <input class="input" type="password" id="password" placeholder="" />
      </div>
    </div>

    <div class="field is-grouped is-grouped-centered">
      <div class="control">
        <button class="button is-link" type="submit">Log In</button>
      </div>
      <div class="control">
        <button class="button is-link">I Forget</button>
      </div>
    </div>
  </form>
</template>

<script>
export default {
  name: 'Signin',
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      this.$http.plain.post('/signin', { email: this.email, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }

      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/home')
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      this.error = error.response
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/home')
      }
    }
  }
}
</script>

<style scoped>
  .card {
    padding: 1em;
  }
</style>
