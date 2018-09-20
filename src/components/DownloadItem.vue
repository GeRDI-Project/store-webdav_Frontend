<template>
  <b-list-group-item>
    {{ title }}
    <b-progress :value="realProgress" :max="100" show-progress :variant="variant" :animated="progress < 100" :label="(progress == -1) ? 'Unknown Size' : progress">
    </b-progress>
  </b-list-group-item>
</template>

<script>
export default {
  name: 'DownloadItem',
  props: ['title', 'progress'],
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  },
  created() {
    console.log("Overview")
  },
  computed: {
    variant: function() {
      console.log(this.progress)
      if (this.progress == -1) return 'warning'
      if (this.progress < 100) return 'info'
      return 'success'
    },
    realProgress: function() {
      return (this.progress == -1) ? 100 : this.progress
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
