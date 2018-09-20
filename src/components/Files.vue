<template>
  <div class="hello">
    <div class="files-display">
      <h4>Store - LRZ Sync &amp; Share - Select destination...</h4>
        <div class="d-flex">
          <b-breadcrumb class="w-100">
            <b-breadcrumb-item class="bc-item" :to="{ name: 'files', params: { sessionId: $route.params.sessionId } }">home</b-breadcrumb-item>
            <b-breadcrumb-item class="bc-item" v-for="i in path.length" :active="i == path.length" :key="i" :to="{ name: 'files', params: { sessionId: $route.params.sessionId }, query: { dir: path.slice(0,i).reduce((a,c) => a+c+'/', '/') } }">
              {{ path[i-1] }}
            </b-breadcrumb-item>
          </b-breadcrumb>
          <b-btn variant="secondary" size="lg" class="flex-shrink-1 align-self-center files-btn" :to="{ name: 'overview', params: { sessionId: $route.params.sessionId }, query: { dir: path.reduce((a,c) => a+c+'/', '/') } }"><font-awesome-icon icon="folder-plus"/></b-btn>
          <b-btn variant="primary" size="lg" class="flex-shrink-1 align-self-center files-btn" :to="{ name: 'overview', params: { sessionId: $route.params.sessionId }, query: { dir: path.reduce((a,c) => a+c+'/', '/') } }"><font-awesome-icon icon="file-upload"/></b-btn>
        </div>
      <div v-if="!loading">
        <b-list-group>
          <file v-for="file in sortedFiles" :title="file.displayName" :type="file.type" :uri="file.uri" :key="file.uri"/>
          <b-list-group-item v-if="files.length == 0">Empty Directory</b-list-group-item>
        </b-list-group>
      </div>
      <b-alert v-else-if="error" show variant="danger">Error while communicating with server</b-alert>
      <div v-else class="d-flex justify-content-center">
        <font-awesome-icon icon="spinner" size="3x" spin />
      </div>
      <div id="overlay" v-if="overlay">
        <div id="text">
          <h2>Please log in to proceed</h2>
          <a :href="windowUrl" target="_blank">Click here to open the login window.</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'Files',
  data () {
    return {
      files: [],
      loading: true,
      error: false,
      windowRef: {},
      overlay: false
    }
  },
  created() {
    this.load()
  },
  computed: {
    path: function() {
      if (this.$route.query.dir) {
        let arr = this.$route.query.dir.split("/").filter(it => it.length > 0)
        return arr
      }
      return []
    },
    sortedFiles: function() {
      return this.files.sort(function(a,b) {
        if (a.type == 'httpd/unix-directory' && b.type != 'httpd/unix-directory') return -1;
        if (a.type != 'httpd/unix-directory' && b.type == 'httpd/unix-directory') return 1;
        return 0;
      })
    }
  },
  watch: {
    '$route.query': "load"
  },
  methods: {
    load() {
      const self = this
      var id = this.$route.params.sessionId
      let url = '/api/v1/store/files/' + id
      if(this.$route.query.dir) url += ('?dir=' + this.$route.query.dir)
      self.loading = true
      self.error = false
      axios.get(url)
      .then(function(response) {
        self.files = response.data
        self.loading = false
      })
      .catch(function(error) {
        //self.errMsg = error.response;
        console.log(error.response)
        if (error.response.status == 403) {
          //self.login(self)
          console.log(self.windowRef)
          //self.windowRef.open('/api/v1/store/login/init.html', 250,350)
          self.login()
        } else {
          self.error = true
        }
      });
    },
    login() {
      let url = '/api/v1/store/login/init.html?sessionId=' + this.$route.params.sessionId
      this.windowUrl = url
      this.PopupCenter(url, 'Log in into LRZ Sync&Share', 300, 350)
    },
    PopupCenter(url, title, w, h) {
      // Fixes dual-screen position                         Most browsers      Firefox
      var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : window.screenX;
      var dualScreenTop = window.screenTop != undefined ? window.screenTop : window.screenY;

      var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? this.document.documentElement.clientWidth : this.screen.width;
      var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? this.document.documentElement.clientHeight : this.screen.height;

      var left = ((width / 2) - (w / 2)) + dualScreenLeft;
      var top = ((height / 2) - (h / 2)) + dualScreenTop;
      this.overlay = true
      let newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

      const self = this

      var timer = setInterval(function() {
        if(newWindow.closed) {
            self.overlay = false
            clearInterval(timer);
            self.load()
        }
      }, 1000);
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.breadcrumb > li + li.ml-auto:before {
  content: none;
}

.files-display {
  margin-top: 2rem;
}

.bc-item {
  vertical-align: sub;
}

.files-btn {
  margin-left: 0.5rem;
  margin-bottom: 1rem;
}

#overlay {
    position: fixed; /* Sit on top of the page content */
    width: 100%; /* Full width (cover the whole page) */
    height: 100%; /* Full height (cover the whole page) */
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0,0,0,0.5); /* Black background with opacity */
    z-index: 2; /* Specify a stack order in case you're using a different order for other elements */
    cursor: pointer; /* Add a pointer on hover */
}

#text{
    position: absolute;
    top: 50%;
    left: 50%;
    color: white;
    text-align: center;
    transform: translate(-50%,-50%);
    -ms-transform: translate(-50%,-50%);
}
</style>
