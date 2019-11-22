<template>
  <div>
    <article class="panel is-info">
      <p class="panel-heading">
        Billing Information
      </p>
      <div class="panel-block">
        <div class="field">
          <label class="label">Name</label>
          <div class="control">
            <input class="input" type="text" placeholder="e.g Kim Kardashian" :value="userName" />
          </div>
        </div>
        <div class="field">
          <div v-if="hasAddresses" class="select">
            <select @change="onAddressSelectChange($event)">
              <option v-for="address in addresses" :key="address.id" :value="address.id" >{{address.address1}}</option>
            </select>
          </div>
        </div>
        <div class="field">
          <label class="label">Address 1</label>
          <p class="control">
            <input class="input" type="text" :value="current_address.address1"/>
          </p>
        </div>
        <div class="field">
          <label class="label">Address 2</label>
          <p class="control">
            <input class="input" type="text" :value="current_address.address2"/>
          </p>
        </div>
        <div class="field">
          <label class="label">City</label>
          <p class="control">
            <input class="input" type="text" :value="current_address.city"/>
          </p>
        </div>
        <div class="field">
          <label class="label">Province</label>
          <p class="control">
            <input class="input" type="text" :value="current_address.province.name"/>
          </p>
        </div>
        <div class="field">
          <label class="label">Country</label>
          <p class="control">
            <input class="input" type="text" :value="current_address.province.country"/>
          </p>
        </div>
        <div class="field">
          <label class="label">Postal Code</label>
          <p class="control">
            <input class="input" type="text" :value="current_address.postal_code"/>
          </p>
        </div>
      </div>
      <a class="panel-block is-active">
        <span class="panel-icon">
          <i class="fas fa-book" aria-hidden="true"></i>
        </span>
        bulma
      </a>
    </article>
  </div>
</template>

<script>
import 'es6-promise/auto'
import { store } from 'vuex'

export default {
  data: function () { return {
    current_address: {
      address1: '',
      address2: '',
      city: '',
      province: '',
      country: '',
      postal_code: '',
    }
  }},
  methods: {
    onAddressSelectChange (event) {
      this.current_address = this.addresses.find(address => address.id == event.target.value)
      console.log(this.current_address);
    }
  },
  computed: {
    userName () {
      return this.$store.state.user.name
    },
    hasAddresses () {
      return this.addresses.length > 0
    },
    addresses () {
      return this.$store.state.user.addresses
    }
  }
}
</script>

<style scoped>
  .field {
    flex-direction: row;
    align-content: left;
  }

  .panel-block {
    flex-direction: column;
    align-items:flex-start;
  }
</style>
