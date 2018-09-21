<template>
  <b-list-group-item>
    {{ title }}
    <b-progress :variant="variant" :animated="progress < 100 && progress >= -1" >
      <b-progress-bar :value="realProgress" :label="translatedLabel">
      </b-progress-bar>
    </b-progress>
  </b-list-group-item>
</template>

<script>
export default {
  name: 'DownloadItem',
  props: ['title', 'progress'],
  data () {
    return {}
  },
  computed: {
    variant: function() {
      if (this.progress == -1) return 'warning'
      if (this.progress == -2) return 'danger'
      if (this.progress < 100) return 'info'
      return 'success'
    },
    realProgress: function() {
      return (this.progress == -1 || this.progress == -2) ? 100 : this.progress
    },
    translatedLabel: function() {
      if (this.progress == -1) {
        return 'Unknown Size'
      } else if (this.progress == -2) {
        return 'Error'
      } else {
        return this.progress.toString()
      }
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
