<template>
  <form class="card black" @submit.prevent="signup">
    <div class="field is-horizontal">
      <label class="field-label" for="email">Email</label>
      <div class="control has-icons-left has-icons-right">
        <input class="input" type="email" id="email" v-model="email" placeholder="Email input">
        <span class="icon is-small is-left">
          <font-awesome-icon :icon="['fas', 'envelope']"></font-awesome-icon>
        </span>
      </div>
    </div>
    <p class="help is-danger" v-if="errors.email">
      <span class="icon is-small is-right">
        <font-awesome-icon :icon="['fas','exclamation-triangle']"></font-awesome-icon>
      </span>
      This email is invalid
    </p>

    <div class="field is-horizontal">
      <label class="field-label" for="password">Password</label>
      <div class="control has-icons-left has-icons-right">
        <input class="input" type="password" id="password" v-model="password" placeholder="" />
      </div>
    </div>
    <p class="help is-danger" v-if="errors.password">
      <span class="icon is-small is-right">
        <font-awesome-icon :icon="['fas','exclamation-triangle']"></font-awesome-icon>
      </span>
      Password {{errors.password[0]}}
    </p>

    <div class="field is-horizontal">
      <label class="field-label" for="confirm_password">Confirm Password</label>
      <div class="control has-icons-left has-icons-right">
        <input class="input" type="password" id="confirm_password" v-model="confirmPassword" placeholder="" />
      </div>
    </div>
    <p class="help is-danger" v-if="errors.password_confirmation">
      <span class="icon is-small is-right">
        <font-awesome-icon :icon="['fas','exclamation-triangle']"></font-awesome-icon>
      </span>
      Password confirmation {{errors.password_confirmation[0]}}
    </p>

    <div class="field is-grouped is-grouped-centered">
      <div class="control">
        <button class="button is-link" type="submit">Sign Up</button>
      </div>
    </div>
  </form>
</template>

<script>
export default {
  name: 'Register',
  data () {
    return {
      email: '',
      password: '',
      confirmPassword: '',
      errors: []
    }
  },
  created () {
  },
  updated () {
  },
  methods: {
    signup () {
      this.$http.plain.post('/users.json', { user: {
        email: this.email,
        password: this.password,
        password_confirmation: this.confirmPassword
      }})
        .then(response => {
          if (response.data.success) {
            this.signupSuccessful(response)
          } else {
            const error = {
              response: response
            }
            this.signupFailed(error)
          }
        })
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      this.errors = []
      this.$router.replace('/signup/success')
    },
    signupFailed (error) {
      this.errors = (error.response && error.response.data && error.response.data.errors) || []
      delete localStorage.csrf
      delete localStorage.signedIn
    },
  }
}
</script>

<style scoped>
  .card {
    padding: 1em;
  }
</style>
