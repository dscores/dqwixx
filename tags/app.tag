<app>
  <div class="container-fluid { finished: board.isFinished() }">
    <div each={ row, rowIndex in board.getRows() } class="row">
      <button each={ number, numberIndex in row } ontouchstart={ clickNumber(rowIndex, numberIndex) } onclick={ clickNumber(rowIndex, numberIndex) } class="btn { number.getColor() } number { open: number.isNumberOpen(), marked: number.isNumberMarked(), skipped: number.isNumberSkipped(), disabled: row.isNumberDisabled(numberIndex) }">
        <span class={ hidden: number.isNumberMarked() }>{ number.getLabel() }</span>
        <span class="glyphicon glyphicon-remove { hidden: !number.isNumberMarked() }"></span>
      </button>
      <button ontouchstart={ clickLock(rowIndex) } onclick={ clickLock(rowIndex) } class="btn { row.getLastNumber().getColor() } lock { open: row.isRowOpen(), locked: row.isRowClosed() }">
        <span class="glyphicon glyphicon-lock { hidden: !row.isRowOpen() }"></span>
        <span class="glyphicon glyphicon-remove { hidden: !row.isRowClosed() }"></span>
      </button>
    </div>
    <div class="row">
      <button each={ fail, failIndex in board.getFails() } ontouchstart={ clickFail(failIndex) } onclick={ clickFail(failIndex) } class="btn fail { open: fail.isFailOpen(), failed: fail.isFailFailed() }">
        <span class="glyphicon glyphicon-ban-circle { hidden: !fail.isFailOpen() }"></span>
        <span class="glyphicon glyphicon-remove { hidden: !fail.isFailFailed() }"></span>
      </button>
    </div>
    <div class="row">
      <button each={ [{ color: 'red' }, { color: 'yellow' }, { color: 'green' }, { color: 'blue' }] } class="btn { color } points">{ board.getColorPoints(color) }</button>
      <button class="btn fail points">{ board.getFailPoints() }</button>
      <button class="btn total points">{ board.getPoints() }</button>
      <button class="btn btn-default refresh { active: theme === 'classic' }" ontouchstart={ clickRefresh('classic') } onclick={ clickRefresh('classic') }><span class="glyphicon glyphicon-refresh"></span> <span class="badge">Klassik</span></button>
      <button class="btn btn-default refresh { active: theme === 'mixed' }" ontouchstart={ clickRefresh('mixed') } onclick={ clickRefresh('mixed') }><span class="glyphicon glyphicon-refresh"></span> <span class="badge">Gemixxt</span></button>
    </div>
  </div>

  this.board = new Dqwixx.Board();

  function store(board, theme) {
    localStorage.setItem('dqwixx-board-v2', JSON.stringify({ board: board, theme: theme }));
  }

  var string = localStorage.getItem('dqwixx-board-v2');
  if (string) {
    var json = JSON.parse(string);
    this.board.resume(json.board);
    this.theme = json.theme;
  } else {
    Dqwixx.classic(this.board);
    this.theme = 'classic';
  }

  this.clickNumber = function (rowIndex, numberIndex) {
    return function () {
      this.board.markNumber(rowIndex, numberIndex);
      store(this.board, this.theme);
    };
  };

  this.clickLock = function (rowIndex) {
    return function () {
      this.board.closeRow(rowIndex);
      store(this.board, this.theme);
    };
  };

  this.clickFail = function (failIndex) {
    return function () {
      this.board.failFail(failIndex);
      store(this.board, this.theme);
    };
  };

  this.clickRefresh = function (theme) {
    return function () {
      this.board = Dqwixx[theme](new Dqwixx.Board());
      this.theme = theme;
      store(this.board, this.theme);
    };
  };
</app>
