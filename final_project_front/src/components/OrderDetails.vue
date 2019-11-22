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
      </div>
      <div class="panel-block itemized">
        <h2 class="subtitle is-6">Taxes</h2>
        <ul>
          <li v-for="item in items" v-bind:key="item.id" class="columns is-mobile item">
            <div class="column is-1">{{item.quantity}}</div>
            <div class="column align-left">{{item.description}}</div>
            <div class="column align-right">{{item.price}}</div>
          </li>
        </ul>
      </div>
      <div class="panel-block">
        <h2 class="subtitle is-4">Total</h2>
      </div>
    </article>
  </div>
</template>

<script>
import 'es6-promise/auto'
import { store } from 'vuex'

export default {
  computed: {
    items () {
      return this.$store.state.cart.items.map(item => {
        let photo = this.$store.state.images.find(photo => photo.id === item.id)

        return {
          description: photo.description,
          quantity: item.qty,
          unitPrice: photo.price,
          price: '$' + (item.qty * photo.price).toFixed(2)
        }
      })
    }
  }
}
</script>

<style scoped>
  .align-left {
    text-align: left;
  }

  .align-right {
    text-align: right;
  }

  .subtitle {
    align-self: flex-start;
  }

  .itemized {
    flex-direction: column;
  }

  .item {
    margin-bottom: 0.2em;
    padding: 0.5em;
  }
</style>
