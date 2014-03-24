app = angular.module 'TodoApp', ['ngRoute']

app.config ($routeProvider) ->
  $routeProvider.when '/',
    templateUrl: '../app/views/todos.html'
    controller: 'Todos'

class Todos

  constructor: ->
    @list = [
      {
        text: 'learn coffescript'
        done: false
      }
      {
        text: 'learn angular'
        done: false
      }
    ]

  addTodo: ->
    @list.push
      text: @input
      done: false
    @input = ''

  remaining: ->
    count = 0
    for todo in @list
      count++ unless todo.done
    count

  archive: ->
    oldList = @list
    @list = []
    for todo in oldList
      unless todo.done
        @list.push todo
    @search = ''

app.controller 'Todos', Todos