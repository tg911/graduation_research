Blockly.Blocks['asc'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldTextInput("文字"), "string")
        .appendField("に対応する文字コード");
    this.setInputsInline(true);
    this.setOutput(true, "Number");
    this.setColour(315);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
