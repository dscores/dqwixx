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

            <p>Jeder Spieler versucht, auf seinem Zettel möglichst viele Zahlen in den vier Farbreihen anzukreuzen. Je mehr Kreuze in einer Farbreihe sind, desto mehr Punkte gibt es dafür. Wer zum Schluss insgesamt die meisten Punkte hat, gewinnt.</p>

            <h5>Zahlen ankreuzen</h5>
            <p>Im Spielverlauf müssen die Zahlen in jeder der vier Farbreihen grundsätzlich <b>von links nach rechts</b> angekreuzt werden. Man muss nicht ganz links beginnen – es ist erlaubt, dass man Zahlen auslässt (auch mehrere auf einmal). Ausgelassene Zahlen dürfen nachträglich nicht mehr angekreuzt werden.</p>
            <p class="bg-info">Hinweis: Wer möchte, kann ausgelassene Zahlen mit einem kleinen waagerechten Strich durchstreichen, damit sie nicht versehentlich nachträglich angekreuzt werden.</p>
            <p>
              <img src="img/rule-examples/classic/mark-numbers.png" class="img-responsive" alt="">
              <i>Beispiel: <b>In der roten Reihe</b> wurde zuerst die 5 und später die 7 angekreuzt. Die rote 2, 3, 4 und 6 dürfen nachträglich nicht mehr angekreuzt werden. <b>In der gelben Reihe</b> kann nur noch die 11 und die 12 angekreuzt werden. <b>In der grünen Reihe</b> muss rechts von der 6 weitergemacht werden. <b>In der blauen Reihe</b> muss rechts von der 10 weitergemacht werden.</i>
            </p>

            <h5>Spielablauf</h5>
            <p>Jeder bekommt einen Zettel und einen Stift. Es wird ausgelost, welcher Spieler zuerst als aktiver Spieler fungiert. Der aktive Spieler würfelt <b>mit allen sechs Würfeln</b>. Nun werden die beiden folgenden Aktionen <b>nacheinander</b> ausgeführt, zuerst die 1. Aktion, <b>danach</b> die 2. Aktion.</p>
            <ol>
              <li>
                <p>Der aktive Spieler zählt die Augen <b>der beiden weißen</b> Würfel zusammen und sagt die Summe laut und deutlich an. <b>Jeder Spieler</b> darf nun (muss aber nicht!) die angesagte Zahl in einer <b>beliebigen</b> Farbreihe seiner Wahl ankreuzen.</p>
                <p class="clearfix">
                  <img src="img/rule-examples/classic/dices-white.png" class="img-responsive pull-left" alt="">
                  <i>Beispiel: Max ist aktiver Spieler. Die beiden weißen Würfel zeigen eine 4 und eine 1. Max sagt laut und deutlich „fünf“ an. Emma kreuzt auf ihrem Zettel die gelbe 5 an. Max kreuzt die rote 5 an. Laura und Linus möchten nichts ankreuzen.</i>
                </p>
              </li>
              <li>
                <p>Der aktive Spieler (aber nicht die Anderen!) darf nun, muss aber nicht, genau <b>einen weißen Würfel</b> mit genau <b>einem beliebigen Farbwürfel</b> seiner Wahl kombinieren und die Summe in der entsprechenden Farbreihe ankreuzen.</p>
                <p class="clearfix">
                  <img src="img/rule-examples/classic/dices-color.png" class="img-responsive pull-left" alt="">
                  <i>Beispiel: Max kombiniert die weiße 4 mit der blauen 6 und kreuzt in der blauen Reihe die Zahl 10 an.</i>
                </p>
              </li>
            </ol>
            <p>Ganz wichtig: Falls der aktive Spieler <b>weder</b> in der 1. Aktion <b>noch</b> in der 2. Aktion eine Zahl ankreuzt, dann muss er in der Spalte <b>"Fehlwürfe"</b> ein Kreuz machen. Die nicht aktiven Spieler müssen keinen Fehlwurf markieren, egal ob sie etwas angekreuzt haben oder nicht.</p>
            <p>Nun wird der nächste Spieler im Uhrzeigersinn zum neuen aktiven Spieler. Er nimmt alle sechs Würfel und würfelt. Anschließend werden die beiden Aktionen nacheinander ausgeführt. In der beschriebenen Weise wird nachfolgend immer weiter gespielt.</p>

            <h5>Eine Reihe abschließen</h5>
            <p>Möchte ein Spieler <b>die Zahl ganz rechts</b> in einer Farbreihe ankreuzen (rote 12, gelbe 12, grüne 2, blaue 2), dann muss er vorher <b>mindestens fünf Kreuze</b> in dieser Farbreihe gemacht haben. Kreuzt er schließlich die Zahl ganz rechts an, dann kreuzt er <b>zusätzlich</b> noch das Feld direkt daneben mit dem Schloss an – dieses Kreuz wird später bei der Endabrechnung mitgezählt! Diese Farbreihe ist nun <b>für alle Spieler</b> abgeschlossen und es kann in dieser Farbe in den folgenden Runden nichts mehr angekreuzt werden. Der zugehörige Farbwürfel wird sofort aus dem Spiel entfernt und nicht weiter benötigt.</p>
            <p>
              <img src="img/rule-examples/classic/closed-green-row.png" class="img-responsive" alt="">
              <img src="img/rule-examples/classic/remove-green-dice.png" class="img-responsive" alt="">
              <i>Beispiel: Laura kreuzt die grüne 2 und zusätzlich das Schloss an. Der grüne Würfel wird aus dem Spiel entfernt.</i>
            </p>
            <p class="bg-warning">Beachte: Kreuzt ein Spieler die Zahl ganz rechts an, dann muss er dies laut und deutlich ansagen, damit alle Spieler wissen, dass diese Farbreihe nun abgeschlossen wird. Falls das Abschließen der Reihe während der 1. Aktion geschieht, können gegebenenfalls nämlich gleichzeitig auch andere Spieler diese Reihe noch abschließen und ebenfalls das Schloss ankreuzen. Hat ein Spieler bisher weniger als fünf Kreuze in der Farbreihe, dann darf er das Feld ganz rechts auf keinen Fall ankreuzen, auch wenn die Reihe von einem anderen Spieler abgeschlossen wird.</p>

            <h5>Spielende</h5>
            <p>Das Spiel endet <b>sofort</b>, wenn jemand seinen vierten Fehlwurf angekreuzt hat. Außerdem endet das Spiel <b>sofort</b>, wenn (egal von welchen Spielern) zwei Reihen abgeschlossen und somit zwei Farbwürfel entfernt wurden.</p>
            <p class="bg-info">Hinweis: Es kann (während der 1. Aktion) passieren, dass gleichzeitig mit der zweiten Reihe auch eine dritte Reihe abgeschlossen wird.</p>
            <p><i>Beispiel: Die grüne Reihe wurde bereits abgeschlossen. Nun würfelt Emma mit den weißen Würfeln zwei 6en und sagt „zwölf“ an. Max kreuzt die rote 12 an und schließt die rote Reihe ab. Gleichzeitig kreuzt Linus die gelbe 12 an und schließt die gelbe Reihe ab.</i></p>

            <h5>Wertung</h5>
            <p>Unterhalb der vier Farbreihen ist angegeben, wie viele Punkte es für wie viele Kreuze innerhalb einer Reihe gibt. Jeder Fehlwurf zählt fünf Minuspunkte. Nun trägt jeder Spieler die Punkte für seine vier Farbreihen und die Minuspunkte für die Fehlwürfe unten auf dem Zettel in die entsprechenden Felder ein. Der Spieler mit dem höchsten Gesamtergebnis ist Sieger.</p>
            <p>
              <img src="img/rule-examples/classic/score.png" class="img-responsive" alt="">
              <i>Beispiel: In Rot hat Laura 4 Kreuze, das gibt 10 Punkte, in Gelb drei Kreuze (= 6 Punkte), in Grün 7 Kreuze (= 28 Punkte) und in Blau 8 Kreuze (= 36 Punkte). Für ihre beiden Fehlwürfe bekommt Laura 10 Minuspunkte. Lauras Gesamtergebnis lautet somit 70 Punkte.</i>
            </p>

          </div>
          <div show={ theme === 'mixedColors' }>

            <p>Alle Regeln des Qwixx-Würfelspieles bleiben <b>exakt</b> erhalten. Bei der vorliegenden Varianten müssen Sie lediglich folgendes beachten:</p>

            <p>Die Zahlen innerhalb einer Reihe sind auf- bzw. absteigend, genau wie beim Originalspiel, aber die Farben sind in kleine Segmente aufgeteilt.</p>
            <p>Schließt ein Spieler eine Reihe ab, indem er die Zahl ganz rechts ankreuzt, wird der entsprechende Farbwürfel <b>sofort</b> aus dem Spiel genommen. Wird also z. B. die oberste Reihe von einem Spieler geschlossen, indem er (mit seinem mindestens 6. Kreuz in dieser Reihe) die rote 12 ankreuzt, dann kommt der rote Würfel <b>sofort</b> aus dem Spiel und die oberste Reihe ist fortan für <b>alle</b> Spieler dicht.</p>
            <p class="bg-warning">Beachte: In den anderen drei Reihen dürfen weiterhin (mit Hilfe der beiden weißen Würfel) rote Felder angekreuzt werden.</p>

            <h5>Noch ein Tipp...</h5>
            <p class="clearfix">
              <img src="img/rule-examples/mixed/qwixx-cards.png" class="img-responsive pull-left" alt="">
              Man kann die „Qwixx gemixxt“-Blöcke auch für das <b>Qwixx-Kartenspiel</b> verwenden. Alle Regeln des Kartenspieles bleiben unverändert, mit den oben beschriebenen Ergänzungen.
            </p>
            <p>Außerdem gilt: Wenn der aktive Spieler mehrere Karten ausspielt (sie müssen die gleiche Farbe haben), dann darf er in verschiedenen Reihen Kreuze machen.</p>
            <p><i>Beispiel: Tim spielt die rote 3, die rote 8 und die rote 11 aus. Die rote 3 kreuzt er in der zweiten Reihe an und die rote 8 in der vierten Reihe. Die rote 11 möchte er nicht ankreuzen.</i></p>
            <p class="bg-warning">Beachte: Wenn der aktive Spieler mehrere Felder innerhalb einer Reihe ankreuzt, dann darf er hierbei auch mehr als ein Feld auslassen.</p>

          </div>
          <div show={ theme === 'mixedNumbers' }>

            <p>Alle Regeln des Qwixx-Würfelspieles bleiben <b>exakt</b> erhalten. Bei der vorliegenden Varianten müssen Sie lediglich folgendes beachten:</p>

            <p>Die Zahlen innerhalb einer Reihe sind nicht mehr auf- bzw. absteigend, sondern wild durcheinander gewürfelt.</p>
            <p>Will ein Spieler eine Reihe schließen, also die Zahl ganz rechts ankreuzen, dann muss es nun in Rot mit einer 11 geschehen, in Gelb mit einer 10, in Grün mit einer 3 und in Blau mit einer 4.</p>

            <h5>Noch ein Tipp...</h5>
            <p class="clearfix">
              <img src="img/rule-examples/mixed/qwixx-cards.png" class="img-responsive pull-left" alt="">
              Man kann die „Qwixx gemixxt“-Blöcke auch für das <b>Qwixx-Kartenspiel</b> verwenden. Alle Regeln des Kartenspieles bleiben unverändert, mit den oben beschriebenen Ergänzungen.
            </p>

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
