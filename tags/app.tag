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

            <h5>Zahlen ankreuzen</h5>
            <p>Im Spielverlauf müssen die Zahlen in jeder der vier Farbreihen grundsätzlich von links nach rechts angekreuzt werden. Man muss nicht ganz links beginnen – es ist erlaubt, dass man Zahlen auslässt (auch mehrere auf einmal). Ausgelassene Zahlen dürfen nachträglich nicht mehr angekreuzt werden.</p>
            <p class="bg-info">Hinweis: Wer möchte, kann ausgelassene Zahlen mit einem kleinen waagerechten Strich durchstreichen, damit sie nicht versehentlich nachträglich angekreuzt werden.</p>
            <p>
              <img src="img/rule-examples/classic/mark-numbers.png" class="img-responsive" alt="">
              <p>Beispiel: In der roten Reihe wurde zuerst die 5 und später die 7 angekreuzt. Die rote 2, 3, 4 und 6 dürfen nachträglich nicht mehr angekreuzt werden. In der gelben Reihe kann nur noch die 11 und die 12 angekreuzt werden. In der grünen Reihe muss rechts von der 6 weitergemacht werden. In der blauen Reihe muss rechts von der 10 weitergemacht werden.
            </p>

            <h5>Spielablauf</h5>
            <p>Jeder bekommt einen Zettel und einen Stift. Es wird ausgelost, welcher Spieler zuerst als aktiver Spieler fungiert. Der aktive Spieler würfelt mit allen sechs Würfeln. Nun werden die beiden folgenden Aktionen nacheinander ausgeführt, zuerst die 1. Aktion, danach die 2. Aktion.</p>
            <ol>
              <li>
                <p>Der aktive Spieler zählt die Augen der beiden weißen Würfel zusammen und sagt die Summe laut und deutlich an. Jeder Spieler darf nun (muss aber nicht!) die angesagte Zahl in einer beliebigen Farbreihe seiner Wahl ankreuzen.</p>
                <p class="clearfix">
                  <img src="img/rule-examples/classic/dices-white.png" class="img-responsive pull-left" alt="">
                  Beispiel: Max ist aktiver Spieler. Die beiden weißen Würfel zeigen eine 4 und eine 1. Max sagt laut und deutlich „fünf“ an. Emma kreuzt auf ihrem Zettel die gelbe 5 an. Max kreuzt die rote 5 an. Laura und Linus möchten nichts ankreuzen.
                </p>
              </li>
              <li>
                <p>Der aktive Spieler (aber nicht die Anderen!) darf nun, muss aber nicht, genau einen weißen Würfel mit genau einem beliebigen Farbwürfel seiner Wahl kombinieren und die Summe in der entsprechenden Farbreihe ankreuzen.</p>
                <p class="clearfix">
                  <img src="img/rule-examples/classic/dices-color.png" class="img-responsive pull-left" alt="">
                  Beispiel: Max kombiniert die weiße 4 mit der blauen 6 und kreuzt in der blauen Reihe die Zahl 10 an.
                </p>
              </li>
            </ol>
            <p>Ganz wichtig: Falls der aktive Spieler weder in der 1. Aktion noch in der 2. Aktion eine Zahl ankreuzt, dann muss er in der Spalte "Fehlwürfe" ein Kreuz machen. Die nicht aktiven Spieler müssen keinen Fehlwurf markieren, egal ob sie etwas angekreuzt haben oder nicht.</p>
            <p>Nun wird der nächste Spieler im Uhrzeigersinn zum neuen aktiven Spieler. Er nimmt alle sechs Würfel und würfelt. Anschließend werden die beiden Aktionen nacheinander ausgeführt. In der beschriebenen Weise wird nachfolgend immer weiter gespielt.</p>

            <h5>Eine Reihe abschließen</h5>
            <p>Möchte ein Spieler die Zahl ganz rechts in einer Farbreihe ankreuzen (rote 12, gelbe 12, grüne 2, blaue 2), dann muss er vorher mindestens fünf Kreuze in dieser Farbreihe gemacht haben. Kreuzt er schließlich die Zahl ganz rechts an, dann kreuzt er zusätzlich noch das Feld direkt daneben mit dem Schloss an – dieses Kreuz wird später bei der Endabrechnung mitgezählt! Diese Farbreihe ist nun für alle Spieler abgeschlossen und es kann in dieser Farbe in den folgenden Runden nichts mehr angekreuzt werden. Der zugehörige Farbwürfel wird sofort aus dem Spiel entfernt und nicht weiter benötigt.</p>
            <p>
              <img src="img/rule-examples/classic/closed-green-row.png" class="img-responsive" alt="">
              <img src="img/rule-examples/classic/remove-green-dice.png" class="img-responsive" alt="">
              Beispiel: Laura kreuzt die grüne 2 und zusätzlich das Schloss an. Der grüne Würfel wird aus dem Spiel entfernt.
            </p>
            <p class="bg-warning">Beachte: Kreuzt ein Spieler die Zahl ganz rechts an, dann muss er dies laut und deutlich ansagen, damit alle Spieler wissen, dass diese Farbreihe nun abgeschlossen wird. Falls das Abschließen der Reihe während der 1. Aktion geschieht, können gegebenenfalls nämlich gleichzeitig auch andere Spieler diese Reihe noch abschließen und ebenfalls das Schloss ankreuzen. Hat ein Spieler bisher weniger als fünf Kreuze in der Farbreihe, dann darf er das Feld ganz rechts auf keinen Fall ankreuzen, auch wenn die Reihe von einem anderen Spieler abgeschlossen wird.</p>

            <h5>Spielende</h5>
            <p>Das Spiel endet sofort, wenn jemand seinen vierten Fehlwurf angekreuzt hat. Außerdem endet das Spiel sofort, wenn (egal von welchen Spielern) zwei Reihen abgeschlossen und somit zwei Farbwürfel entfernt wurden.</p>
            <p class="bg-info">Hinweis: Es kann (während der 1. Aktion) passieren, dass gleichzeitig mit der zweiten Reihe auch eine dritte Reihe abgeschlossen wird.</p>
            <p>Beispiel: Die grüne Reihe wurde bereits abgeschlossen. Nun würfelt Emma mit den weißen Würfeln zwei 6en und sagt „zwölf“ an. Max kreuzt die rote 12 an und schließt die rote Reihe ab. Gleichzeitig kreuzt Linus die gelbe 12 an und schließt die gelbe Reihe ab.</p>

            <h5>Wertung</h5>
            <p>Unterhalb der vier Farbreihen ist angegeben, wie viele Punkte es für wie viele Kreuze innerhalb einer Reihe gibt. Jeder Fehlwurf zählt fünf Minuspunkte. Nun trägt jeder Spieler die Punkte für seine vier Farbreihen und die Minuspunkte für die Fehlwürfe unten auf dem Zettel in die entsprechenden Felder ein. Der Spieler mit dem höchsten Gesamtergebnis ist Sieger.</p>
            <p>
              <img src="img/rule-examples/classic/score.png" class="img-responsive" alt="">
              Beispiel: In Rot hat Laura 4 Kreuze, das gibt 10 Punkte, in Gelb drei Kreuze (= 6 Punkte), in Grün 7 Kreuze (= 28 Punkte) und in Blau 8 Kreuze (= 36 Punkte). Für ihre beiden Fehlwürfe bekommt Laura 10 Minuspunkte. Lauras Gesamtergebnis lautet somit 70 Punkte.
            </p>

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
