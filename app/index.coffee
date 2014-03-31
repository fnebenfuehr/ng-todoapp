app = angular.module 'todoapp', ['ngRoute']

app.config ($routeProvider) ->
  $routeProvider.when '/',
    templateUrl: 'main/todos.html'
    controller: 'Todos'

# class App
#   constructor: ->
#     console.log 'Application'

# app.controller 'App', App