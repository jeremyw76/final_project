<template>
  <div>
    <article class="panel is-info">
      <p class="panel-heading">
        Order Information
      </p>
      <div class="panel-block itemized">
        <h2 class="subtitle">Order Items</h2>
        <ul>
          <li v-for="item in items" v-bind:key="item.id" class="columns is-mobile item">
            <div class="column is-1">{{item.quantity}}</div>
            <div class="column align-left">{{item.description}}</div>
            <div class="column align-right">{{item.price}}</div>
          </li>
        </ul>
        <div class="columns is-mobile item" id="subtotal">
          <div class="column align-left">
            <h2 class="subtitle is-6">Subtotal</h2>
          </div>
          <div class="column align-right">
            <h2 class="subtitle is-6">${{subtotal.toFixed(2)}}</h2>
          </div>
        </div>
      </div>
      <div class="panel-block itemized" id="taxes">
        <h2 class="subtitle is-6">Taxes</h2>
        <ul v-if="canCalculateTaxes">
          <li v-if="provincialTaxes > 0" class="columns is-mobile tax">
            <div class="column is-2 is-offset-7">{{provincialTaxCode()}}</div>
            <div class="column align-right">{{formattedProvincialTaxes()}}</div>
          </li>
          <li v-if="gst > 0" class="columns is-mobile tax">
            <div class="column is-2 is-offset-7">GST</div>
            <div class="column align-left"></div>
            <div class="column align-right">${{gst.toFixed(2)}}</div>
          </li>
        </ul>
      </div>
      <div class="panel-block">
        <div class="columns is-mobile item" id="total">
          <div class="column is-half">
            <h2 class="subtitle is-4">Total</h2>
          </div>
          <div v-if="canCalculateTaxes" class="column">
            <h2 class="subtitle is-4">${{total.toFixed(2)}}</h2>
          </div>
        </div>
      </div>
    </article>
  </div>
</template>

<script>
import 'es6-promise/auto'
import { store } from 'vuex'

export default {
  methods: {
    formattedProvincialTaxes () {
      return '$' + this.provincialTaxes.toFixed(2)
    },
    provincialTaxCode () {
      return this.province !== undefined ? this.province.tax_code + 'ST' : ''
    }
  },
  computed: {
    items () {
      return this.$store.state.cart.items.map(item => {
        let photo = this.$store.state.images.find(photo => photo.id === item.id)

        return {
          description: photo.description,
          quantity: item.qty,
          unitPrice: photo.price,
          price: '$' + (item.qty * photo.price).toFixed(2),
          numericPrice: photo.price_in_cents
        }
      })
    },
    subtotal () {
      let result = 0

      this.items.forEach(item => {
        result += item.numericPrice
      })

      return result / 100
    },
    canCalculateTaxes () {
      return this.$store.getters.canCalculateTaxes
    },
    province () {
      return this.$store.getters.currentProvince
    },
    provincialTaxes () {
      const currentProvince = this.$store.getters.currentProvince

      return currentProvince === undefined ? 0 : currentProvince.tax_rate * this.subtotal
    },
    gst () {
      return this.province !== undefined && this.province.tax_code === 'H' ? 0 : 0.05 * this.subtotal
    },
    total () {
      return this.subtotal + this.provincialTaxes + this.gst
    }
  }
}
</script>

<style scoped>
  .panel {
    height: 100%;
  }

  .align-left {
    text-align: left;
  }

  .align-right {
    text-align: right;
  }

  .subtitle {
    align-self: flex-start;
  }

  ul {
    width: 80%;
  }

  .itemized {
    flex-direction: column;
  }

  .item div, .tax div {
    padding: 0
  }

  .columns {
    width: 100%;
  }

  li.item {
    border-bottom: 1px solid #CCC;
  }

  .column.items {
    margin: 0;
  }

  .subtitle.is-6 {
    margin-bottom: 0.75em;
  }

  #subtotal {
    margin: 0;
    padding-top: 1.75em;
    padding-right: 0.75em;
    width: 80%;
  }

  .panel-block > .item {
    margin-top: 1em;
  }

  #taxes {
    padding-bottom: 1em;
  }

  #total {
    margin-top: 0em;
  }
</style>
