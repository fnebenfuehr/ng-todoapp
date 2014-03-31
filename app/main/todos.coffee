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

  toggle: (item) ->
    item.done = !item.done

app.controller 'Todos', Todos