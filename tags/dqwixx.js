'use strict';

(function () {
  function generateColor(color, order) {
    color = { color: color, order: order, numbers: [], lockable: false, closed: false, points: 0 };
    if (order === 'asc') {
      var number;
      for (number = 2; number <= 12; ++number) {
        color.numbers.push({ number: number, marked: false, skipped: false, last: number === 12 });
      }
    }
    if (order === 'desc') {
      for (number = 12; number >= 2; --number) {
        color.numbers.push({ number: number, marked: false, skipped: false, last: number === 2 });
      }
    }
    return color;
  }

  function generate(state) {
    state.colors = [generateColor('red', 'asc'), generateColor('yellow', 'asc'), generateColor('green', 'desc'), generateColor('blue', 'desc')];
    state.fails = {
      fails: [{ failed: false }, { failed: false }, { failed: false }, { failed: false }],
      points: 0
    };
    state.points = 0;
    state.finished = false;
  }

  function refresh(state) {
    state.colors.forEach(function (color) {
      color.numbers.forEach(function (number) {
        number.marked = false;
        number.skipped = false;
      });
      color.lockable = false;
      color.closed = false;
      color.points = 0;
    });
    state.fails.fails.forEach(function (fail) {
      fail.failed = false;
    });
    state.fails.points = 0;
    state.points = 0;
    state.finished = false;
  }

  function calcColorPoints(color) {
    var marked = color.numbers.filter(function (number) { return number.marked }).length;
    var numbers = color.numbers;
    var last = numbers[numbers.length - 1];
    if (marked > 5 && last.marked && color.locked) {
      ++marked;
    }
    color.points = [0, 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66, 78][marked];
  }

  function determineLockable(color) {
    var marked = color.numbers.filter(function (number) { return number.marked }).length;
    color.lockable = marked >= 5;
  }

  function calcFailPoints(state) {
    var fails = state.fails;
    var failed = fails.fails.filter(function (fail) { return fail.failed }).length;
    fails.points = failed * 5;
  }

  function calcTotalPoints(state) {
    var points = state.colors
        .map(function (color) { return color.points })
        .reduce(function (pointsA, pointsB) { return pointsA + pointsB }, 0);
    points -= state.fails.points;
    state.points = points;
  }

  function determineFinished(state) {
    var locked = state.colors.filter(function (color) { return color.locked }).length;
    var failed = state.fails.fails.filter(function (fail) { return fail.failed }).length;
    state.finished = locked >= 2 || failed >= 4;
  }

  function markNumber(color, number) {
    number.marked = true;
    number.skipped = false;
    if (number.last && !color.locked) {
      lockColor(color);
    } else {
      var numbers = color.numbers;
      for (var i = 0; i < numbers.length; ++i) {
        if (numbers[i].number === number.number) {
          break;
        }
        numbers[i].skipped = !numbers[i].marked;
      }
    }
  }

  function unmarkNumber(color, number) {
    number.marked = false;
    if (number.last && color.locked) {
      unlockColor(color);
    } else {
      var numbers = color.numbers;
      var last = numbers[10];
      var marked = numbers.filter(function (number) { return number.marked }).length;
      if (last.marked && marked <= 5) {
        unmarkNumber(color, last);
      }
      for (var i = numbers.length - 1; i >= 0; --i) {
        if (numbers[i].marked) {
          if ((color.order === 'asc' && numbers[i].number > number.number)
              || (color.order === 'desc' && numbers[i].number < number.number)) {
            number.skipped = true;
          }
          break;
        }
        numbers[i].skipped = color.locked;
      }
    }
  }

  function lockColor(color) {
    color.locked = true;
    var numbers = color.numbers;
    for (var i = 0; i < numbers.length; ++i) {
      var number = numbers[i];
      number.skipped = !number.marked;
    }
  }

  function unlockColor(color) {
    color.locked = false;
    var numbers = color.numbers;
    var last = numbers[numbers.length - 1];
    if (last.marked) {
      unmarkNumber(color, last);
    } else {
      for (var i = numbers.length - 1; i >= 0; --i) {
        if (numbers[i].marked) {
          break;
        }
        numbers[i].skipped = false;
      }
    }
  }

  function storeState(state) {
    if (state) {
      localStorage.setItem('dqwixx-state', JSON.stringify(state));
    } else {
      localStorage.removeItem('dqwixx-state');
    }
  }

  function loadState() {
    var state = localStorage.getItem('dqwixx-state');
    if (state) {
      state = JSON.parse(state);
    }
    return state;
  }

  var dqwixx = { state: loadState() };
  if (!dqwixx.state) {
    dqwixx.state = {};
    generate(dqwixx.state);
  }

  dqwixx.clickNumber = function (color, number) {
    if (number.last && !color.lockable) {
      return;
    }
    if (number.marked) {
      unmarkNumber(color, number);
    } else {
      markNumber(color, number);
    }
    calcColorPoints(color);
    determineLockable(color);
    calcTotalPoints(dqwixx.state);
    if (number.last) {
      determineFinished(dqwixx.state);
    }
    storeState(dqwixx.state);
  };

  dqwixx.clickLock = function (color) {
    if (color.locked) {
      unlockColor(color);
    } else {
      lockColor(color);
    }
    calcColorPoints(color);
    determineLockable(color);
    calcTotalPoints(dqwixx.state);
    determineFinished(dqwixx.state);
    storeState(dqwixx.state);
  };

  dqwixx.clickFail = function (fail) {
    fail.failed = !fail.failed;
    calcFailPoints(dqwixx.state);
    calcTotalPoints(dqwixx.state);
    determineFinished(dqwixx.state);
    storeState(dqwixx.state);
  };

  dqwixx.clickRefresh = function () {
    refresh(dqwixx.state);
    storeState();
  };

  window.dqwixx = dqwixx;
})();
