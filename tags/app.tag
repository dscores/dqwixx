<app>
  <div class="container-fluid { finished: board.isFinished() } { this.theme }">
    <div each={ row, rowIndex in board.getRows() } class="row">
      <button each={ number, numberIndex in row.getNumbers() } ontouchstart={ clickNumber(rowIndex, numberIndex) } onclick={ clickNumber(rowIndex, numberIndex) } class="btn { number.getColor() } number { open: number.isNumberOpen(), marked: number.isNumberMarked(), skipped: number.isNumberSkipped(), disabled: row.isNumberDisabled(numberIndex) }">
        <span class={ hidden: number.isNumberMarked() }>{ number.getLabel() }</span>
        <span class="glyphicon glyphicon-remove { hidden: !number.isNumberMarked() }"></span>
      </button>
      <button hide={ row.isBigPoints() } ontouchstart={ clickLock(rowIndex) } onclick={ clickLock(rowIndex) } class="btn { row.getLastNumber().getColor() } lock { open: row.isRowOpen(), locked: row.isRowClosed() }">
        <span class="glyphicon glyphicon-lock { hidden: !row.isRowOpen() }"></span>
        <span class="glyphicon glyphicon-remove { hidden: !row.isRowClosed() }"></span>
      </button>
      <div show={ row.isBigPoints() } class="btn empty"></div>
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
    </div>
    <div class="row">
      <button class="btn btn-default rules" data-toggle="modal" data-target="#rulesModal">Spielregeln</button>
      <button class="btn btn-default theme { active: theme === 'classic' }" ontouchstart={ clickTheme('classic') } onclick={ clickTheme('classic') }>Klassik</button>
      <button class="btn btn-default theme { active: theme === 'mixedColors' }" ontouchstart={ clickTheme('mixedColors') } onclick={ clickTheme('mixedColors') }>Gemixxt<br/><span class="badge">Farben</span></button>
      <button class="btn btn-default theme { active: theme === 'mixedNumbers' }" ontouchstart={ clickTheme('mixedNumbers') } onclick={ clickTheme('mixedNumbers') }>Gemixxt<br/><span class="badge">Zahlen</span></button>
      <button class="btn btn-default theme { active: theme === 'bigPoints' }" ontouchstart={ clickTheme('bigPoints') } onclick={ clickTheme('bigPoints') }>Big Points</button>
      <button class="btn btn-default revert { disabled: !isRevertable() }" ontouchstart={ clickRevert } onclick={ clickRevert }>Rückgängig</button>
      <button class="btn btn-default refresh" ontouchstart={ clickRefresh } onclick={ clickRefresh }>Nochmal</button>
    </div>
  </div>
  <div class="modal fade" id="rulesModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">
            Spielregeln
            <span show={ theme === 'classic' }>(Klassik)</span>
            <span show={ theme === 'mixedColors' }>(Gemixxt, Farben)</span>
            <span show={ theme === 'mixedNumbers' }>(Gemixxt, Zahlen)</span>
            <span show={ theme === 'bigPoints' }>(Big Points)</span>
          </h4>
        </div>
        <div class="modal-body">
          <div show={ theme === 'classic' }>
            ...
          </div>
          <div show={ theme === 'mixedColors' }>
            ...
          </div>
          <div show={ theme === 'mixedNumbers' }>
            ...
          </div>
          <div show={ theme === 'bigPoints' }>
            ...
          </div>
        </div>
      </div>
    </div>
  </div>

  this.board = new Dqwixx.Board();

  var currentString = localStorage.getItem('dqwixx-current');
  if (currentString) {
    var currentJson = JSON.parse(currentString);
    this.board.resume(currentJson.board);
    this.theme = currentJson.theme;
  } else {
    Dqwixx.themes.classic(this.board);
    this.theme = 'classic';
  }

  this.clickNumber = function (rowIndex, numberIndex) {
    return function () {
      localStorage.setItem('dqwixx-before', localStorage.getItem('dqwixx-current'));
      this.board.markNumber(rowIndex, numberIndex);
      localStorage.setItem('dqwixx-current', JSON.stringify({ board: this.board, theme: this.theme }));
    };
  };

  this.clickLock = function (rowIndex) {
    return function () {
      localStorage.setItem('dqwixx-before', localStorage.getItem('dqwixx-current'));
      this.board.closeRow(rowIndex);
      localStorage.setItem('dqwixx-current', JSON.stringify({ board: this.board, theme: this.theme }));
    };
  };

  this.clickFail = function (failIndex) {
    return function () {
      localStorage.setItem('dqwixx-before', localStorage.getItem('dqwixx-current'));
      this.board.failFail(failIndex);
      localStorage.setItem('dqwixx-current', JSON.stringify({ board: this.board, theme: this.theme }));
    };
  };

  this.isRevertable = function () {
    return localStorage.getItem('dqwixx-before');
  };

  this.clickRevert = function () {
    var beforeString = localStorage.getItem('dqwixx-before');
    var beforeJson = JSON.parse(beforeString);
    this.board.resume(beforeJson.board);
    this.theme = beforeJson.theme;
    localStorage.setItem('dqwixx-current', beforeString);
    localStorage.removeItem('dqwixx-before');
  };

  this.clickTheme = function (theme) {
    return function () {
      if (theme === this.theme) {
        return;
      }
      localStorage.setItem('dqwixx-before', localStorage.getItem('dqwixx-current'));
      this.board = Dqwixx.themes[theme](new Dqwixx.Board());
      this.theme = theme;
      localStorage.setItem('dqwixx-current', JSON.stringify({ board: this.board, theme: this.theme }));
    };
  };

  this.clickRefresh = function () {
    localStorage.setItem('dqwixx-before', localStorage.getItem('dqwixx-current'));
    this.board = Dqwixx.themes[this.theme](new Dqwixx.Board());
    localStorage.setItem('dqwixx-current', JSON.stringify({ board: this.board, theme: this.theme }));
  };
</app>
