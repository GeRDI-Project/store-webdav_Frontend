<template>
  <div id="app">
    <nav-menu/>
    <div class="container content">
      <router-view/>
    </div>
    <app-footer/>
  </div>
</template>

<script>
import HelloWorld from './components/HelloWorld'

export default {
  name: 'App',
  components: {
    HelloWorld
  }
}
</script>

<style>

#app {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  display: flex;
  min-height: 100vh;
  flex-direction: column;
}

.content {
  flex: 1;
}
</style>
