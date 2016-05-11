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
      <button class="btn btn-info refresh" ontouchstart={ clickRefresh('classic') } onclick={ clickRefresh('classic') }><span class="glyphicon glyphicon-refresh"></span></button>
      <button class="btn btn-info refresh" ontouchstart={ clickRefresh('mixed') } onclick={ clickRefresh('mixed') }><span class="glyphicon glyphicon-refresh"></span></button>
    </div>
  </div>

  this.board = new Dqwixx.Board();

  const store = () => {
    localStorage.setItem('dqwixx-board-v2', JSON.stringify(this.board));
  }

  stringBoard = localStorage.getItem('dqwixx-board-v2');
  if (stringBoard) {
    this.board.resume(JSON.parse(stringBoard));
  } else {
    Dqwixx.classic(this.board);
  }

  this.clickNumber = (rowIndex, numberIndex) => () => {
    this.board.markNumber(rowIndex, numberIndex);
    store();
  };

  this.clickLock = (rowIndex) => () => {
    this.board.closeRow(rowIndex);
    store();
  };

  this.clickFail = (failIndex) => () => {
    this.board.failFail(failIndex);
    store();
  };

  this.clickRefresh = (variant) => () => {
    this.board = Dqwixx[variant](new Dqwixx.Board());
    store();
  };
</app>
