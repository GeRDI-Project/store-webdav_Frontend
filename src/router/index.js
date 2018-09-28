/* eslint-disable */
import Vue from 'vue'
import Router from 'vue-router'

import Overview from "../components/Overview"
import Files from "../components/Files"

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [{
    path: '/store/overview/:sessionId',
    name: 'overview',
    component: Overview
  },
  {
    path: '/store/files/:sessionId',
    name: 'files',
    component: Files
  }
  ]
})
