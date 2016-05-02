<app>
  <script src="dqwixx.js"></script>
  <div class="container-fluid { finished: state.finished }">
    <div each={ state.colors } class="row { color }">
      <button each={ numbers } ontouchstart={ clickNumber(color) } onclick={ clickNumber(color) } class="btn { skipped: skipped, marked: marked, disabled: last && !lockable }">
        <span class={ hidden: marked }>{ number }</span>
        <span class="glyphicon glyphicon-remove { hidden: !marked }"></span>
      </button>
      <button ontouchstart={ clickLock } onclick={ clickLock } class="btn lock { locked: locked }">
        <span class="glyphicon glyphicon-lock { hidden: locked }"></span>
        <span class="glyphicon glyphicon-remove { hidden: !locked }"></span>
      </button>
    </div>
    <div class="row fails">
      <button each={ state.fails.fails } ontouchstart={ clickFail } onclick={ clickFail } class="btn { failed: failed }">
        <span class="glyphicon glyphicon-ban-circle { hidden: failed }"></span>
        <span class="glyphicon glyphicon-remove { hidden: !failed }"></span>
      </button>
    </div>
    <div class="row results">
      <button each={ state.colors } class="btn { color }">+ { points }</button>
      <button class="btn fails">- { state.fails.points }</button>
      <button class="btn total">= { state.points }</button>
      <button class="btn btn-info refresh" ontouchstart={ clickRefresh } onclick={ clickRefresh }><span class="glyphicon glyphicon-refresh"></span></button>
    </div>
  </div>

  this.state = dqwixx.state;

  var colors = {};
  dqwixx.state.colors.map(function (color) {
    colors[color.color] = color;
  });

  this.clickRefresh = function () { dqwixx.clickRefresh(); };
  this.clickNumber = function (color) { return function (e) { dqwixx.clickNumber(colors[color], e.item); }; };
  this.clickLock = function (e) { dqwixx.clickLock(e.item); };
  this.clickFail = function (e) { dqwixx.clickFail(e.item); };
</app>
