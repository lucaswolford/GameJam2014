class Game.Question
  selection: 0
  question: null
  active: false
  answer: null

  constructor: (stage, question) ->
    @text = new PIXI.Text("", {font: "bold italic 36px Arvo", fill: "#11FF11", align: "left", stroke: "#22FF00", strokeThickness: 1})
    @text.position.x = 40
    @text.position.y = 10
    @text.anchor.x = @text.anchor.y = 0
    stage.addChild(@text)
    @question = question
    window.addEventListener('keydown', ( (event) => @keydown(event) ), false)

  keydown: (event) ->
    if event.keyCode == Game.Key.UP
      @moveUp()
    else if event.keyCode == Game.Key.DOWN
      @moveDown()
    else if event.keyCode == Game.Key.ENTER
      @finalize()

  update: (dt) ->
    @displayAnswers()

  finalize: ->
    @text.setText('')
    @answer = @getAnswers()[ @selection ].value
    @active = false

  moveUp: ->
    @selection-- if @selection > 0
  moveDown: ->
    @selection++ if @selection < @getAnswers().length - 1

  displayAnswers: ->
    text = ''
    index = 0
    if @active == true
      text += @getQuestion() + '\n'
      for answer in @getAnswers()
        if index == @selection
          text += '>'
        else
          text += '  '
        text += answer.displayText + '\n'
        index++
    @text.setText(text)


  getQuestion: ->
    Game.answers[@question]['question']
  getAnswers: ->
    Game.answers[@question]['answers']
