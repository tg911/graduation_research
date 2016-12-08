Blockly.Blocks['variable'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldVariable("変数1"), "var1");
    this.setOutput(true, "Number");
    this.setColour(330);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};