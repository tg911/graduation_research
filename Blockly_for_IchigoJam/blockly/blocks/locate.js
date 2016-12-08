Blockly.Blocks['locate'] = {
  init: function() {
    this.appendValueInput("width")
        .setCheck(null)
        .appendField("次に文字を書く位置を")
        .appendField("横");
    this.appendValueInput("height")
        .setCheck(null)
        .appendField("縦");
    this.appendDummyInput()
        .appendField("に指定する");
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(65);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
