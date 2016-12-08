Blockly.Blocks['scr'] = {
  init: function() {
    this.appendValueInput("width")
        .setCheck(null)
        .appendField("横");
    this.appendValueInput("height")
        .setCheck(null)
        .appendField("縦");
    this.appendDummyInput()
        .appendField("の位置にある文字コード");
    this.setInputsInline(true);
    this.setOutput(true, "Number");
    this.setColour(315);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
