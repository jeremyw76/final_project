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
        <div v-if="hasAddresses" class="field">
          <label class="label">Your Addresses</label>
          <div  class="select">
            <select @change="onAddressSelectChange($event)">
              <option v-for="address in addresses" :key="address.id" :value="address.id" >{{address.address1}} {{address.address2}} - {{address.city}}</option>
            </select>
          </div>
        </div>
        <div class="field">
          <label class="label">Address 1</label>
          <p class="control">
            <input class="input" type="text" v-model="currentAddress.address1"/>
          </p>
        </div>
        <div class="field">
          <label class="label">Address 2</label>
          <p class="control">
            <input class="input" type="text" v-model="currentAddress.address2"/>
          </p>
        </div>
        <div class="field">
          <label class="label">City</label>
          <p class="control">
            <input class="input" type="text" v-model="currentAddress.city"/>
          </p>
        </div>
        <div class="field">
          <label class="label">Province</label>
          <p class="control">
            <input
              class="input"
              :class="{'is-danger':provinceHasError}"
              type="text"
              v-model="currentAddress.province"
              @blur="onProvinceBlur"
            />
          </p>
        </div>
        <div class="field">
          <label class="label">Country</label>
          <p class="control">
            <input class="input" type="text" v-model="currentAddress.country"/>
          </p>
        </div>
        <div class="field">
          <label class="label">Postal Code</label>
          <p class="control">
            <input class="input" type="text" v-model="currentAddress.postalCode"/>
          </p>
        </div>
      </div>
      <div class="field">
        <label class="checkbox">
          <input type="checkbox" checked @change="saveAddressChanged">
          Save address
        </label>
      </div>
    </article>
  </div>
</template>

<script>
import 'es6-promise/auto'
import { store } from 'vuex'

export default {
  data: function () {
    return {
      provinceHasError: false
    }
  },
  methods: {
    onAddressSelectChange (event) {
      let id = event.target.value
      let selectedAddress = this.addresses.find(address => address.id == id)
      this.$store.commit('setAddress', selectedAddress)
      this.validateProvince()
    },
    onProvinceBlur (event) {
      this.validateProvince()
    },
    getProvinceForName (name) {
      return this.$store.state.provinces.find(province => province.name === name)
    },
    saveAddressChanged (event) {
      this.$store.commit('setShouldSaveAddress', event.target.checked)
    },
    validateProvince() {
      this.provinceHasError = this.currentProvinceName !== '' && !this.selectedProvinceIsValid
    }
  },
  computed: {
    userName () {
      return this.$store.state.user.name
    },
    currentProvinceName () {
      return this.$store.state.currentAddress.province
    },
    hasAddresses () {
      return this.addresses.length > 0
    },
    addresses () {
      return this.$store.state.user.addresses
    },
    canCalculateTaxes () {
      return this.$store.getters.canCalculateTaxes
    },
    currentAddress () {
      return this.$store.state.currentAddress
    },
    selectedProvinceIsValid() {
      return this.$store.getters.selectedProvinceIsValid
    }
  }
}
</script>

<style scoped>
  .panel {
    height: 100%;
  }

  .field {
    display: flex;
    flex-direction: row;
    width: 100%;
    height: 1.5em;
  }

  .input, select {
    height: 1.75em;
  }

  .select {
    width: 65%;
  }

  select {
    padding-top: 1px;
    padding-bottom: 1px;
    width: 100%;
  }

  select:not(.is-multiple):not(.is-loading)::after {
    margin-top: -0.5em;
  }

  .field label {
    padding-top: 0.3em;
    width: 35%;
  }

  .field .control {
    width: 65%;
  }

  .panel-block {
    flex-direction: column;
    align-items:flex-start;
    text-align: left;
  }

  #addresses {
    display: flex;
  }
</style>
