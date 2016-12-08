Blockly.Blocks['goto'] = {
  init: function() {
    this.appendValueInput("goto")
        .setCheck("Number")
        .appendField("行番号");
    this.appendDummyInput()
        .appendField("へ飛ぶ");
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(45);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
