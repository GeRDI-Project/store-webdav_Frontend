<template>
  <div class="hello">
    <b-button variant="primary" @click="click">TEST ME!!!</b-button>
    <router-link :to="{ name: 'overview', params: { sessionId: 's' } }">adf</router-link>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'HelloWorld',
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  },
  created() {
    console.log("HelloWorld")
  },
  methods: {
    click () {
      const self = this
      console.log("Hello")
      axios.post('/api/',
        {
          "bookmarkId": "123",
          "bookmarkName": "fancy",
          "docs": [
          	"http://fenixservices.fao.org/faostat/static/bulkdownloads/Investment_Machinery_E_Americas.zip",
          	"http://fenixservices.fao.org/faostat/static/bulkdownloads/Investment_Machinery_E_Oceania.zip"
          ],
          "userId": "Nelson"
        }
      )
      .then(function(response) {
        const val =  response.data.sessionId
        self.$router.push({ name: 'overview' , params: { sessionId: val }})
        console.log(response)
      })
      .catch(function(error) {
        //self.errMsg = error.response;
        console.error(error)
      });
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
