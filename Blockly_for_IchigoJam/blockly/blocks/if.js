Blockly.Blocks['if'] = {
  init: function() {
    this.appendValueInput("condition")
        .setCheck("Number")
        .appendField("もし");
    this.appendDummyInput()
        .appendField("が0でなければ");
    this.appendStatementInput("execute")
        .setCheck(null);
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(0);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
