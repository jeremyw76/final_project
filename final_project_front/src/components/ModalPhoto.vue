<template>
  <transition name="modal">
    <div class="modal-mask" @click="hideModal">
      <div class="modal-wrapper">
        <div class="modal-container">
          <h3 class="title is-3 is-pulled-left">{{image.description}}</h3>
          <div class="image">
            <img :src="image.large_url" />
          </div>
          <div class="modal-footer">
            <div class="level">
              <p class="subtitle is-pulled-left level-left">{{formattedPrice}}</p>
              <span
                v-if="countInCart > 0"
                class="icon level-right has-text-warning"
                @click="removeFromCart"
                @click.stop="hideModal"
              >
                <font-awesome-layers>
                  <font-awesome-icon :icon="['fas', 'shopping-cart']"></font-awesome-icon>
                  <font-awesome-icon :icon="['fas', 'minus']" class="inverse"></font-awesome-icon>
                </font-awesome-layers>
              </span>
              <span class="icon level-right has-text-success" @click="addToCart" @click.stop="hideModal">
                <font-awesome-icon :icon="['fas', 'cart-plus']"></font-awesome-icon>
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
export default {
  props: {
    image: Object
  },
  methods: {
    hideModal (event) {
      this.$store.commit('hideSingleImageModal')
    },
    addToCart () {
      let cartItem = {
        type: 'Photo',
        id: this.image.id
      }
      this.$store.dispatch('addToCartAsync', cartItem)
    },
    removeFromCart() {
      let cartItem = {
        type: 'Photo',
        id: this.image.id
      }
      this.$store.dispatch('removeFromCartAsync', cartItem)
    }
  },
  computed: {
    formattedPrice () {
      return '$' + this.image.price.toFixed(2)
    },
    countInCart () {
      let items = this.$store.state.cart.items.filter(item => item.id === this.image.id)
      return items.length
    }
  }
}
</script>

<style scoped>
.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, .5);
  display: table;
  transition: opacity .3s ease;
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

.modal-container {
  max-width: 50%;
  margin: 0px auto;
  padding: 20px 30px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
  font-family: Helvetica, Arial, sans-serif;
}

.modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-container {
  max-height: 100%;
  overflow-y: auto;
}

.modal-container > .image {
  max-height: 70%;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}

.modal-footer {
  padding-top: 5px;
  padding-bottom: 5px;
}

.icon {
  cursor: pointer;
  font-size: 2em;
  display: flex;
  flex-direction: row;
  align-items: center;
}

.inverse {
  mix-blend-mode: difference;
  font-size: 0.3em;
  margin: auto;
}
</style>
