Blockly.Blocks['input'] = {
  init: function() {
    this.appendValueInput("num")
        .setCheck("Number")
        .appendField("キーボードから")
        .appendField(new Blockly.FieldVariable("変数1"), "var1")
        .appendField("に");
    this.appendDummyInput()
        .appendField("を入れる");
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(210);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
