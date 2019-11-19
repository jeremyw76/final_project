<template>
  <transition name="modal">
    <div class="modal-mask" @click="this.hideModal">
      <div class="modal-wrapper">
        <div class="modal-container">
          <h3 class="title is-3 is-pulled-left">{{image.description}}</h3>
          <div class="image">
            <img :src="image.large_url" />
          </div>
          <div class="modal-footer">
            <p class="subtitle is-pulled-left">{{formattedPrice}}</p>
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
    hideModal () {
      this.$store.commit('hideSingleImageModal')
    }
  },
  computed: {
    formattedPrice () {
      return '$' + this.image.price.toFixed(2)
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

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}

.modal-footer {
  padding-top: 5px;
  padding-bottom: 5px;
}
</style>
