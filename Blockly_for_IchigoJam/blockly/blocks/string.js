Blockly.Blocks['string'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldTextInput("文字"), "string");
    this.setOutput(true, "String");
    this.setColour(330);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
