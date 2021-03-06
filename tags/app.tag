<app>
  <div class="container-fluid { finished: board.isFinished() } { theme }">
    <div each={ row, rowIndex in board.getRows() } class="row">
      <button each={ number, numberIndex in row.getNumbers() } ontouchstart={ clickNumber(rowIndex, numberIndex) } onclick={ clickNumber(rowIndex, numberIndex) } class="btn { number.getColor() } number { open: number.isNumberOpen(), marked: number.isNumberMarked(), skipped: number.isNumberSkipped(), disabled: row.isNumberDisabled(numberIndex) } { formatMarkedLinkedRowIndexes(row.getMarkedLinkedRowIndexes(numberIndex)) }">
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
      <button class="btn btn-default rules" data-toggle="modal" data-target="#rules-{ theme }">Spielregeln</button>
      <button class="btn btn-default theme { active: theme === 'classic' }" ontouchstart={ clickTheme('classic') } onclick={ clickTheme('classic') }>Klassik</button>
      <button class="btn btn-default theme { active: theme === 'mixedColors' }" ontouchstart={ clickTheme('mixedColors') } onclick={ clickTheme('mixedColors') }>Gemixxt<br/><span class="badge">Farben</span></button>
      <button class="btn btn-default theme { active: theme === 'mixedNumbers' }" ontouchstart={ clickTheme('mixedNumbers') } onclick={ clickTheme('mixedNumbers') }>Gemixxt<br/><span class="badge">Zahlen</span></button>
      <button class="btn btn-default theme { active: theme === 'bigPoints' }" ontouchstart={ clickTheme('bigPoints') } onclick={ clickTheme('bigPoints') }>Big Points</button>
      <button class="btn btn-default revert { disabled: !isRevertable() }" ontouchstart={ clickRevert } onclick={ clickRevert }>Rückgängig</button>
      <button class="btn btn-default refresh" ontouchstart={ clickRefresh } onclick={ clickRefresh }>Nochmal</button>
    </div>
  </div>

  <div class="modal fade" id="rules-classic" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">
            Spielregeln (Klassik)
          </h4>
        </div>
        <div class="modal-body">
          <p>
            Jeder Spieler versucht, auf seinem Spielblock möglichst viele Zahlen in den vier Farbreihen anzukreuzen. Je
            mehr Kreuze in einer Farbreihe sind, desto mehr Punkte gibt es dafür. Wer zum Schluss insgesamt die meisten
            Punkte hat, gewinnt.
          </p>

          <h4>Zahlen ankreuzen</h4>
          <p>
            Im Spielverlauf müssen die Zahlen in jeder der vier Farbreihen grundsätzlich <b>von links nach rechts</b>
            angekreuzt werden. Man muss nicht ganz links beginnen – es ist erlaubt, dass man Zahlen auslässt (auch
            mehrere auf einmal). Ausgelassene Zahlen können nachträglich nicht mehr angekreuzt werden.
          </p>
          <p>
            <div class="row">
              <div class="col-xs-6">
                <img src="img/rule-examples/classic/mark-numbers.png" class="img-responsive" alt="">
              </div>
              <div class="col-xs-6">
                <i>
                  Beispiel: <b>In der roten Reihe</b> wurde zuerst die 5 und später die 7 angekreuzt. Die rote 2, 3, 4
                  und 6 dürfen nachträglich nicht mehr angekreuzt werden. <b>In der gelben Reihe</b> kann nur noch die
                  11 und die 12 angekreuzt werden. <b>In der grünen Reihe</b> muss bei der 5 weitergemacht werden. <b>In
                  der blauen Reihe</b> muss bei der 9 weitergemacht werden.
                </i>
              </div>
            </div>
          </p>

          <h4>Spielablauf</h4>
          <p>
            Es wird ausgelost, welcher Spieler zuerst als aktiver Spieler fungiert. Der aktive Spieler würfelt <b>mit
            allen sechs Würfeln</b>. Nun werden die beiden folgenden Aktionen <b>nacheinander</b> ausgeführt, zuerst die
            1. Aktion, <b>danach</b> die 2. Aktion.
          </p>
          <ol>
            <li>
              <p>
                Der aktive Spieler zählt die Augen <b>der beiden weißen</b> Würfel zusammen und sagt die Summe laut und
                deutlich an. <b>Jeder Spieler</b> darf nun (muss aber nicht!) die angesagte Zahl in einer
                <b>beliebigen</b> Farbreihe seiner Wahl ankreuzen.
              </p>
              <p class="clearfix">
                <img src="img/rule-examples/classic/dices-white.png" class="img-responsive pull-left" alt="">
                <i>
                  Beispiel: Max ist aktiver Spieler. Die beiden weißen Würfel zeigen eine 4 und eine 1. Max sagt laut
                  und deutlich "fünf" an. Emma kreuzt auf ihrem Zettel die gelbe 5 an. Max kreuzt die rote 5 an. Laura
                  und Linus möchten nichts ankreuzen.
                </i>
              </p>
            </li>
            <li>
              <p>
                Der aktive Spieler (aber nicht die Anderen!) darf nun, muss aber nicht, genau <b>einen weißen Würfel</b>
                mit genau <b>einem beliebigen Farbwürfel</b> seiner Wahl kombinieren und die Summe in der entsprechenden
                Farbreihe ankreuzen.
              </p>
              <p class="clearfix">
                <img src="img/rule-examples/classic/dices-color.png" class="img-responsive pull-left" alt="">
                <i>Beispiel: Max kombiniert die weiße 4 mit der blauen 6 und kreuzt in der blauen Reihe die Zahl 10 an.</i>
              </p>
            </li>
          </ol>
          <p>
            Ganz wichtig: Falls der aktive Spieler <b>weder</b> in der 1. Aktion <b>noch</b> in der 2. Aktion eine Zahl
            ankreuzt, dann muss er in der Spalte <b>"Fehlwürfe"</b> ein Kreuz machen. Die nicht aktiven Spieler müssen
            keinen Fehlwurf markieren, egal ob sie etwas angekreuzt haben oder nicht.
          </p>
          <p>
            Nun wird der nächste Spieler im Uhrzeigersinn zum neuen aktiven Spieler. Er nimmt alle sechs Würfel und
            würfelt. Anschließend werden die beiden Aktionen nacheinander ausgeführt. In der beschriebenen Weise wird
            nachfolgend immer weiter gespielt.
          </p>

          <h4>Eine Reihe abschließen</h4>
          <p>
            Möchte ein Spieler <b>die Zahl ganz rechts</b> in einer Farbreihe ankreuzen (rote 12, gelbe 12, grüne 2,
            blaue 2), dann muss er vorher <b>mindestens fünf Kreuze</b> in dieser Farbreihe gemacht haben. Kreuzt er
            schließlich die Zahl ganz rechts an, dann wird <b>zusätzlich</b> noch das Feld direkt daneben mit dem
            Schloss angekreuzt – dieses Kreuz wird später bei der Endabrechnung mitgezählt! Diese Farbreihe ist nun
            <b>für alle Spieler</b> abgeschlossen und es kann in dieser Farbe in den folgenden Runden nichts mehr
            angekreuzt werden. Der zugehörige Farbwürfel wird sofort aus dem Spiel entfernt und nicht weiter benötigt.
          </p>
          <p>
            <div class="row">
              <div class="col-xs-6">
                <img src="img/rule-examples/classic/closed-green-row.png" class="img-responsive" alt="">
                <img src="img/rule-examples/classic/remove-green-dice.png" class="img-responsive" alt="">
              </div>
              <div class="col-xs-6">
                <i>
                  Beispiel: Laura kreuzt die grüne 2 an, es wird zusätzlich das Schloss angekreuzt. Der grüne Würfel
                  wird aus dem Spiel entfernt.
                </i>
              </div>
            </div>
          </p>
          <p class="bg-warning">
            Beachte: Kreuzt ein Spieler die Zahl ganz rechts an, dann muss er dies laut und deutlich ansagen, damit alle
            Spieler wissen, dass diese Farbreihe nun abgeschlossen wird. Falls das Abschließen der Reihe während der 1.
            Aktion geschieht, können gegebenenfalls nämlich gleichzeitig auch andere Spieler diese Reihe noch
            abschließen. Hat ein Spieler bisher weniger als fünf Kreuze in der Farbreihe, dann darf er das Feld ganz
            rechts auf keinen Fall ankreuzen, auch wenn die Reihe von einem anderen Spieler abgeschlossen wird.
          </p>

          <h4>Spielende</h4>
          <p>
            Das Spiel endet <b>sofort</b>, wenn jemand seinen vierten Fehlwurf angekreuzt hat. Außerdem endet das Spiel
            <b>sofort</b>, wenn (egal von welchen Spielern) zwei Reihen abgeschlossen und somit zwei Farbwürfel entfernt
            wurden.
          </p>
          <p class="bg-info">
            Hinweis: Es kann (während der 1. Aktion) passieren, dass gleichzeitig mit der zweiten Reihe auch eine dritte
            Reihe abgeschlossen wird.
          </p>
          <p>
            <i>
              Beispiel: Die grüne Reihe wurde bereits abgeschlossen. Nun würfelt Emma mit den weißen Würfeln zwei 6en
              und sagt "zwölf" an. Max kreuzt die rote 12 an und schließt die rote Reihe ab. Gleichzeitig kreuzt Linus
              die gelbe 12 an und schließt die gelbe Reihe ab.
            </i>
          </p>

          <h4>Wertung</h4>
          <p>
            Unterhalb der vier Farbreihen und Fehlwürfe ist angegeben, wie viele Punkte der Spieler für die Farben,
            Fehlwürfe und als Gesamtergebnis hat. Der Spieler mit dem höchsten Gesamtergebnis ist Sieger.
          </p>
          <p>
            <div class="row">
              <div class="col-xs-6">
                <img src="img/rule-examples/classic/score.png" class="img-responsive" alt="">
              </div>
              <div class="col-xs-6">
                <i>
                  Beispiel: In Rot hat Laura 4 Kreuze, das gibt 10 Punkte, in Gelb drei Kreuze (= 6 Punkte), in Grün 7
                  Kreuze (= 28 Punkte) und in Blau 8 Kreuze (= 36 Punkte). Für ihre beiden Fehlwürfe bekommt Laura 10
                  Minuspunkte. Lauras Gesamtergebnis lautet somit 70 Punkte.
                </i>
              </div>
            </div>
          </p>


          <h3>Qwixx-Kartenspiel</h3>
          <p class="clearfix">
            <img src="img/rule-examples/qwixx-cards.png" class="img-responsive pull-left" alt="">
            Man kann den digitalen Spielblock auch für das <b>Qwixx-Kartenspiel</b> verwenden. Alle Regeln des
            Würfelspieles bleiben unverändert, mit den folgenden Ergänzungen:
            <ul>
              <li>
                Wenn ein Spieler eine Farbreihe schliesst, gilt dies nur für <b>diesen Spieler</b>. Alle anderen Spieler
                können weiterhin Zahlen in dieser Farbreihe markieren.
              </li>
              <li>Das Spiel endet <b>sofort</b>, wenn <b>ein Spieler zwei Farbreihen</b> auf seinem Spielblock geschlossen hat.</li>
              <li><b>Spielvorbereitung</b> und <b>Spielablauf</b> unterscheiden sich wie unten stehend im Detail beschrieben.</li>
            </ul>
          </p>

          <h4>Spielvorbereitung</h4>
          <p>
            Die <b>11 Jokerkarten</b> kommen in die Schachtel. Sie werden nur für die Jokervariante benötigt. Jeder
            bekommt einen Zettel sowie einen Stift. Die 44 Karten werden gemischt. Jeder Spieler bekommt
            <b>vier Karten</b> auf die Hand. Die restlichen Karten kommen als Zugstapel verdeckt in die Tischmitte, mit
            der neutralen Farbseite nach oben. Die obersten <b>vier Karten</b> werden abgehoben und nebeneinander
            (= Auslage) neben den Stapel gelegt.
          </p>
          <p>
            <div class="row">
              <div class="col-xs-6">
                <img src="img/rule-examples/classic/qwixx-cards/preparation.png" class="img-responsive" alt="">
              </div>
              <div class="col-xs-6">
                Die Auslage besteht im Spielverlauf immer aus vier Karten (neutrale Farbseite sichtbar).
              </div>
            </div>
          </p>

          <h4>Spielablauf</h4>
          <p>
            Es wird ausgelost, wer zuerst als aktiver Spieler fungiert. Der aktive Spieler führt <b>nacheinander</b> die
            folgenden drei Aktionen aus.
          </p>
          <ol>
            <li>
              <p>
                Der aktive Spieler nimmt sich so viele beliebige Karten <b>von der Auslage</b> auf die Hand, dass er
                <b>insgesamt 5 Karten</b> hat (zu Spielbeginn ist das nur eine Karte, später können es auch zwei oder
                drei sein). <b>Nachdem</b> der Spieler die Karte(n) genommen hat, wird die Auslage sofort wieder auf
                vier Karten aufgefüllt, indem entsprechend viele Karten vom Zugstapel abgehoben und verdeckt ausgelegt
                werden.
              </p>
              <p class="bg-info">
                Hinweis: Sollte der Zugstapel im Spielverlauf aufgebraucht sein, wird der Ablagestapel gemischt und
                sofort als neuer Zugstapel hingelegt.
              </p>
              <p>
                <div class="row">
                  <div class="col-xs-6">
                    <img src="img/rule-examples/classic/qwixx-cards/take-card.png" class="img-responsive" alt="">
                  </div>
                  <div class="col-xs-6">
                    <i>
                      Beispiel: Anna nimmt die 11 von der Auslage auf die Hand. Die 8 vom Zugstapel wird anschließend an
                      die freie Stelle der Auslage gelegt.
                    </i>
                  </div>
                </div>
              </p>
            </li>
            <li>
              <p>
                Der aktive Spieler sagt laut und deutlich die Zahl an, die <b>jetzt</b> oben auf dem Stapel zu sehen
                ist. Diese Zahl gilt für alle, d.h. <b>jeder</b> Spieler kann sie (muss aber nicht) auf seinem Block in
                einer <b>beliebigen</b> Farbreihe ankreuzen.
              </p>
              <p>
                <div class="row">
                  <div class="col-xs-6">
                    <img src="img/rule-examples/classic/qwixx-cards/card-white.png" class="img-responsive" alt="">
                  </div>
                  <div class="col-xs-6">
                    <i>
                      Beispiel: Anna sagt: "Eine 4 für alle." Max kreuzt auf seinem Zettel die rote 4 an. Anna kreuzt
                      die gelbe 4 an. Linus kreuzt ebenfalls die gelbe 4 an. Laura möchte nichts ankreuzen.
                    </i>
                  </div>
                </div>
              </p>
            </li>
            <li>
              <p>
                Der aktive Spieler <b>muss</b> nun auf jeden Fall <b>eine</b> seiner 5 Handkarten ausspielen - wenn er
                kann (und möchte), darf er auch mehrere Karten auf einmal ausspielen, allerdings <b>maximal drei</b>.
                Spielt er nur eine Karte aus, dann kann er eine beliebige wählen. Will er mehrere Karten auf einmal
                ausspielen, dann müssen diese <b>von der selben Farbe</b> sein. Die Zahlen der (maximal drei) Karten
                kann der Spieler <b>beliebig</b> wählen, es gibt keine Einschränkung, z.B. rot 2-6-11 oder gelb 3-9 oder
                grün 10-9-4 oder blau 8-7.
              </p>
              <p>
                Der Spieler zeigt die Karte(n) vor und kann nun frei entscheiden, ob er keine, eine oder mehrere der
                abgebildeten Zahlen in der abgebildeten Farbe ankreuzen möchte.
              </p>
              <p class="bg-warning">
                Wichtig: Wenn der Spieler <b>mehrere</b> Zahlen ankreuzen will, dann darf er zwischen der ersten und der
                letzten Zahl, die er ankreuzt, nicht mehr als eine Zahl auslassen. Spielt er z.B rot 4-5-7 aus, dann
                kann er alle drei Zahlen ankreuzen. Spielt er z.B. gelb 2-4-6 aus, kann er nicht alle drei Zahlen
                ankreuzen, da sonst zwei Zahlen ausgelassen werden.
              </p>
              <p class="bg-warning">
                Beachte: Die anderen Spieler dürfen jetzt (also in der 3. Aktion) <b>nichts</b> ankreuzen.
              </p>
              <p><b>Alle</b> ausgespielten Karten kommen anschließend verdeckt auf einen Ablagestapel an den Tischrand.</p>
              <p class="clearfix">
                <img src="img/rule-examples/classic/qwixx-cards/cards-color.png" class="img-responsive pull-left" alt="">
                <i>
                  Beispiel: Anna spielt die grüne 11, die grüne 9 und die grüne 3 aus. Sie kreuzt die 11 und die 9 in
                  der grünen Reihe an und legt dann alle 3 Karten auf den Ablagestapel.
                </i>
              </p>
              <p class="bg-warning">
                Ganz wichtig: Falls der aktive Spieler <b>weder</b> in der 2. Aktion <b>noch</b> in der 3. Aktion eine
                Zahl ankreuzt, dann muss er in der Spalte <b>"Fehlwürfe"</b> ein Kreuz machen. Die nicht aktiven Spieler
                müssen keinen Fehlwurf markieren, egal ob sie etwas angekreuzt haben oder nicht.
              </p>
              <p>
                Nun wird der nächste Spieler im Uhrzeigersinn zum neuen aktiven Spieler und führt die drei Aktionen wie
                beschrieben nacheinander aus. In der beschriebenen Weise wird nachfolgend reihum immer weiter gespielt.
              </p>
            </li>
          </ol>

          <h4>Jokervariante</h4>
          <p>
            Die 11 Joker werden in der Spielvorbereitung gemeinsam mit den anderen 44 Karten gemischt. Die 55 Karten
            werden als Zugstapel hingelegt. Die Zahl einer Jokerkarte steht fest, die Farbe, für die sie gelten soll,
            kann der Spieler beim Ausspielen bestimmen. Alle weiteren Regeln bleiben unverändert.
          </p>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="rules-mixedColors" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">
            Spielregeln (Gemixxt, Farben)
          </h4>
        </div>
        <div class="modal-body">
          <p>
            Alle Regeln des Qwixx-Würfelspieles bleiben <b>exakt</b> erhalten. Bei der vorliegenden Varianten müssen Sie
            lediglich folgendes beachten:
          </p>
          <p>
            Die Zahlen innerhalb einer Reihe sind auf- bzw. absteigend, genau wie beim Originalspiel, aber die Farben
            sind in kleine Segmente aufgeteilt.
          </p>
          <p>
            Schließt ein Spieler eine Reihe ab, indem er die Zahl ganz rechts ankreuzt, wird der entsprechende
            Farbwürfel <b>sofort</b> aus dem Spiel genommen. Wird also z. B. die oberste Reihe von einem Spieler
            geschlossen, indem er (mit seinem mindestens 6. Kreuz in dieser Reihe) die rote 12 ankreuzt, dann kommt der
            rote Würfel <b>sofort</b> aus dem Spiel und die oberste Reihe ist fortan für <b>alle</b> Spieler dicht.
          </p>
          <p class="bg-warning">
            Beachte: In den anderen drei Reihen dürfen weiterhin (mit Hilfe der beiden weißen Würfel) rote Felder
            angekreuzt werden.
          </p>


          <h3>Qwixx-Kartenspiel</h3>
          <p class="clearfix">
            <img src="img/rule-examples/qwixx-cards.png" class="img-responsive pull-left" alt="">
            Man kann den digitalen Spielblock auch für das <b>Qwixx-Kartenspiel</b> verwenden. Alle Regeln des
            Würfelspieles bleiben unverändert, mit den folgenden Ergänzungen:
            <ul>
              <li>Wenn ein Spieler mehrere Karten ausspielt (sie müssen die gleiche Farbe haben), dann darf er in verschiedenen Reihen Kreuze machen.</li>
              <li>Wenn ein Spieler mehrere Felder innerhalb einer Reihe ankreuzt, dann darf er hierbei auch mehr als ein Feld auslassen.</li>
            </ul>
          </p>
          <p>
            <i>
              Beispiel: Tim spielt die rote 3, die rote 8 und die rote 11 aus. Die rote 3 kreuzt er in der zweiten Reihe
              an und die rote 8 in der vierten Reihe. Die rote 11 möchte er nicht ankreuzen.
            </i>
          </p>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="rules-mixedNumbers" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">
            Spielregeln (Gemixxt, Zahlen)
          </h4>
        </div>
        <div class="modal-body">
          <p>
            Alle Regeln des Qwixx-Würfelspieles bleiben <b>exakt</b> erhalten. Bei der vorliegenden Varianten müssen
            Sie lediglich folgendes beachten:
          </p>
          <p>Die Zahlen innerhalb einer Reihe sind nicht mehr auf- bzw. absteigend, sondern wild durcheinander gewürfelt.</p>
          <p>
            Will ein Spieler eine Reihe schließen, also die Zahl ganz rechts ankreuzen, dann muss es nun in Rot mit
            einer 11 geschehen, in Gelb mit einer 10, in Grün mit einer 3 und in Blau mit einer 4.
          </p>


          <h3>Qwixx-Kartenspiel</h3>
          <p class="clearfix">
            <img src="img/rule-examples/qwixx-cards.png" class="img-responsive pull-left" alt="">
            Man kann den digitalen Spielblock auch für das <b>Qwixx-Kartenspiel</b> verwenden. Alle Regeln des
            Würfelspieles bleiben unverändert, mit den folgenden Ergänzungen:
            <ul>
              <li>Wenn ein Spieler mehrere Felder innerhalb einer Reihe ankreuzt, dann darf er hierbei auch mehr als ein Feld auslassen.</li>
            </ul>
          </p>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="rules-bigPoints" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">
            Spielregeln (Big Points)
          </h4>
        </div>
        <div class="modal-body">
          <p>
            Die Spielregeln für die normalen vier Farbreihen (quadratische Felder) und der Spielablauf bleiben
            <b>exakt</b> so wie beim Originalspiel, es ändert sich <b>nichts</b>. Die Spieler kommen reihum dran und
            führen ihre beiden Aktionen aus. <b>Am Ende</b> gibt es Punkte für die vier normalen Farbreihen und jeder
            Fehlwurf zählt 5 Minuspunkte, wie gehabt.
          </p>
          <p>
            Für die beiden Bonusreihen selbst (runde Felder) gibt es keine Punkte. <b>Aber:</b> Angekreuzte Bonusfelder
            zählen für <b>beide</b> benachbarten Farbreihen mit. Auf diese Weise kann man sehr viele Kreuze pro
            Farbreihe werten und sehr viele Punkte pro Farbreihe machen (maximal 120).
          </p>

          <h4>Wie werden die Bonusfelder angekreuzt?</h4>
          <p>
            Hat man ein normales Farbfeld angekreuzt (z.B. die grüne 10), darf man fortan, wenn man diese Zahl erneut
            würfelt (also wieder eine grüne 10), das benachbarte zweifarbige Bonusfeld ankreuzen. Das gilt auch für den
            Fall, dass man eine entsprechende "weiße Zahl" (weiße 10) nutzt. Es ist nicht möglich, ein Bonusfeld
            anzukreuzen, wenn man nicht <b>vorher</b> mindestens ein benachbartes Farbfeld angekreuzt hat.
          </p>
          <p class="clearfix">
            <img src="img/rule-examples/bigpoints/enable-numbers.png" class="img-responsive pull-left" alt="">
            <i>
              Sarah hat die rote 4 und die gelbe 6 angekreuzt. Sollte sie selbst noch einmal eine rote 4 oder eine gelbe
              6 würfeln, darf sie in dieser Aktion das benachbarte Bonusfeld ankreuzen. Das kann sie ebenfalls tun, wenn
              sie selbst (oder ein Mitspieler!) eine weiße 4 oder eine weiße 6 würfelt.
            </i>
          </p>

          <h4>Was muss man noch beachten?</h4>
          <ul>
            <li>
              Auch für die beiden Bonusreihen gilt grundsätzlich: Es <b>muss</b> von links nach rechts angekreuzt werden
              und ausgelassene Bonusfelder können nachträglich <b>nicht</b> mehr angekreuzt werden.
            </li>
            <li>
              Eine Farbreihe kann, wie gehabt, mit dem (mindestens) 6. Kreuz in dieser Farbreihe geschlossen werden,
              wenn man damit das Feld ganz rechts ankreuzt. Die angekreuzten Bonusfelder werden hierbei <b>nicht</b>
              berücksichtigt, also für das Schließen der Farbreihe  (mind. 6. Kreuz) nicht mitgezählt.
            </li>
            <li>
              Sollte eine Farbreihe geschlossen werden (z.B. Grün), kann man weiterhin, wie beschrieben, die
              benachbarten Bonusfelder ankreuzen. Die auf diese Weise noch angekreuzten Bonusfelder zählen für
              <b>beide</b> benachbarten Farbreihen mit - gewertet wird erst ganz zum Schluß.
            </li>
            <li>Sollte der aktive Spieler in seinen beiden Aktionen lediglich ein Bonusfeld ankreuzen, so gilt dies nicht als Fehlwurf.</li>
          </ul>

          <h4>Wertung</h4>
          <p>
            <div class="row">
              <div class="col-xs-6">
                <img src="img/rule-examples/bigpoints/score.png" class="img-responsive" alt="">
              </div>
              <div class="col-xs-6">
                <i>
                  Beispiel: Sarah hat 3 rot-gelbe Bonusfelder angekreuzt. Diese 3 Kreuze zählen sowohl für die rote als
                  auch für die gelbe Farbreihe. Außerdem hat Sarah 4 grün-blaue Bonusfelder angekreuzt. Diese 4 Kreuze
                  zählen sowohl für die grüne als auch für die blaue Farbreihe mit.
                </i>
              </div>
            </div>
          </p>
          <p class="bg-warning">
            Beachte: Sollte jemand in einer Farbreihe (plus benachbarte Bonusfelder) mehr als 15 Kreuze haben, so ist
            dies zwar erlaubt, aber es werden maximal nur 15 Kreuze pro Farbreihe gewertet.
          </p>
        </div>
      </div>
    </div>
  </div>

  this.formatMarkedLinkedRowIndexes = function (markedLinkedRowIndexes) {
    return markedLinkedRowIndexes
      .map(function (markedLinkedRowIndex) {
        return 'markedLinkedRowIndex' + markedLinkedRowIndex;
      })
      .join('-');
  };

  var historySize = 3;
  var history = {
    push: function (currentJson) {
      var historyString = localStorage.getItem('dqwixx-history');
      var historyJson = [];
      if (historyString) {
        var historyJson = JSON.parse(historyString);
      }
      historyJson.push(currentJson);
      historyJson = historyJson.slice(-historySize);
      localStorage.setItem('dqwixx-history', JSON.stringify(historyJson));
    },
    pop: function () {
      var historyString = localStorage.getItem('dqwixx-history');
      if (historyString) {
        var historyJson = JSON.parse(historyString);
        var currentJson = historyJson.pop();
        if (historyJson.length === 0) {
          localStorage.removeItem('dqwixx-history');
        } else {
          localStorage.setItem('dqwixx-history', JSON.stringify(historyJson));
        }
        return currentJson;
      }
    }
  };

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
      history.push({ board: this.board, theme: this.theme });
      this.board.markNumber(rowIndex, numberIndex);
      localStorage.setItem('dqwixx-current', JSON.stringify({ board: this.board, theme: this.theme }));
    };
  };

  this.clickLock = function (rowIndex) {
    return function () {
      history.push({ board: this.board, theme: this.theme });
      this.board.closeRow(rowIndex);
      localStorage.setItem('dqwixx-current', JSON.stringify({ board: this.board, theme: this.theme }));
    };
  };

  this.clickFail = function (failIndex) {
    return function () {
      history.push({ board: this.board, theme: this.theme });
      this.board.failFail(failIndex);
      localStorage.setItem('dqwixx-current', JSON.stringify({ board: this.board, theme: this.theme }));
    };
  };

  this.isRevertable = function () {
    return localStorage.getItem('dqwixx-history');
  };

  this.clickRevert = function () {
    var current = history.pop();
    this.board.resume(current.board);
    this.theme = current.theme;
    localStorage.setItem('dqwixx-current', JSON.stringify({ board: this.board, theme: this.theme }));
  };

  this.clickTheme = function (theme) {
    return function () {
      if (theme === this.theme) {
        return;
      }
      history.push({ board: this.board, theme: this.theme });
      this.board = Dqwixx.themes[theme](new Dqwixx.Board());
      this.theme = theme;
      localStorage.setItem('dqwixx-current', JSON.stringify({ board: this.board, theme: this.theme }));
    };
  };

  this.clickRefresh = function () {
    history.push({ board: this.board, theme: this.theme });
    this.board = Dqwixx.themes[this.theme](new Dqwixx.Board());
    localStorage.setItem('dqwixx-current', JSON.stringify({ board: this.board, theme: this.theme }));
  };
</app>
