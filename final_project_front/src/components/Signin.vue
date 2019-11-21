<template>
  <form class="card black" @submit.prevent="signin">
    <div class="field is-horizontal">
      <label class="field-label" for="email">Email</label>
      <div class="control has-icons-left has-icons-right">
        <input class="input" type="email" id="email" v-model="email" placeholder="Email input">
        <span class="icon is-small is-left">
          <font-awesome-icon :icon="['fas', 'envelope']"></font-awesome-icon>
        </span>
      </div>
    </div>

    <div class="field is-horizontal">
      <label class="field-label" for="password">Password</label>
      <div class="control has-icons-left has-icons-right">
        <input class="input" type="password" id="password" v-model="password" placeholder="" />
      </div>
    </div>

    <p class="help is-danger" v-if="error">
      <span class="icon is-small is-right">
        <font-awesome-icon :icon="['fas','exclamation-triangle']"></font-awesome-icon>
      </span>
      Invalid email address or password
    </p>

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
  methods: {
    signin () {
      this.error = ''
      this.$http.plain.post('/users/sign_in.json', { user: { email: this.email, password: this.password, remember_me: 1 }})
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf_token) {
        this.signinFailed(response)
        return
      }
      console.log(response.data)

      let user = {
        name: response.data.customer.name
      }

      this.$store.commit('logInUser', user)

      this.error = ''
      this.$router.replace(this.$store.state.previousPage)
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      this.$store.commit('logOutUser')
    }
  }
}
</script>

<style scoped>
  .card {
    padding: 1em;
  }
</style>
