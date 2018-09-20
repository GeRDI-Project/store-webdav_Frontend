/* eslint-disable */
import Vue from 'vue'
import Router from 'vue-router'

import Overview from "../components/Overview"
import Files from "../components/Files"

// Statical UI Elements Components
import HelloWorld from '../components/HelloWorld'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [{
    path: '/store/overview/:sessionId',
    name: 'overview',
    component: Overview
  },
  {
    path: '/',
    name: 'start',
    component: HelloWorld
  },
  {
    path: '/store/files/:sessionId',
    name: 'files',
    component: Files
  }
  ]
})
