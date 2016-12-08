Blockly.Blocks['chr'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("文字コード")
        .appendField(new Blockly.FieldNumber(1, 0, 255), "chr")
        .appendField("に対応する文字");
    this.setInputsInline(true);
    this.setOutput(true, "String");
    this.setColour(315);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
