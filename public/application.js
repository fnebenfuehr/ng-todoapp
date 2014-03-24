(function() {
  var Todos, app;

  app = angular.module('TodoApp', []);

  Todos = (function() {
    function Todos() {
      this.list = [
        {
          text: 'learn coffescript',
          done: false
        }, {
          text: 'learn angular',
          done: false
        }
      ];
    }

    Todos.prototype.addTodo = function() {
      this.list.push({
        text: this.input,
        done: false
      });
      return this.input = '';
    };

    Todos.prototype.remaining = function() {
      var count, todo, _i, _len, _ref;
      count = 0;
      _ref = this.list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        todo = _ref[_i];
        if (!todo.done) {
          count++;
        }
      }
      return count;
    };

    Todos.prototype.archive = function() {
      var oldList, todo, _i, _len, _results;
      oldList = this.list;
      this.list = [];
      _results = [];
      for (_i = 0, _len = oldList.length; _i < _len; _i++) {
        todo = oldList[_i];
        if (!todo.done) {
          _results.push(this.list.push(todo));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    return Todos;

  })();

  app.controller('Todos', Todos);

}).call(this);
