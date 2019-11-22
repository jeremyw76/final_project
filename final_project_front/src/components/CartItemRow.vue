<template>
  <div>
    <div class="box">
      <article class="media">
        <div class="media-left">
          <figure class="image is-64x64">
            <img :src="image.small_url" :alt="image.description">
          </figure>
        </div>
        <div class="media-content">
          <div class="content">
            <div class="columns">
              <p class="column"><strong>{{image.description}}</strong></p>
              <p class="column">Unit Price: {{unitPrice}}</p>
              <div class="column">
                <p>Quantity: {{item.qty}}</p>
                <div class="vertical">
                  <button class="button" @click="addItem">+</button>
                  <button class="button" @click="subtractItem">-</button>
                </div>
              </div>
              <p class="column">Price: {{totalPrice}}</p>
            </div>
          </div>
        </div>
      </article>
    </div>
  </div>
</template>

<script>
import 'es6-promise/auto'
import { store } from 'vuex'

export default {
  props: {
    item: Object
  },
  methods: {
    addItem () {
      this.$store.dispatch('addToCartAsync', this.item)
    },
    subtractItem() {
      this.$store.dispatch('removeFromCartAsync', this.item)
    }
  },
  computed: {
    image () {
      let image = this.$store.state.images.find(image => image.id === this.item.id)

      if (image !== undefined) {
        return image
      } else {
        return {
          description: 'Photo not found.',
          price: 0,
          quantity: 0,
          url: 'https://bulma.io/images/placeholders/128x128.png'
        }
      }
    },
    unitPrice () {
      return '$' + this.image.price.toFixed(2)
    },
    totalPrice () {
      return '$' + (this.image.price * this.item.qty).toFixed(2)
    }
  }
}
</script>

<style scoped>
  .box {
    border-radius: 0px;
  }
</style>
