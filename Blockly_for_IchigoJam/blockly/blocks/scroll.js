Blockly.Blocks['scroll'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown([["上", "up"], ["右", "right"], ["下", "down"], ["左", "left"]]), "direction")
        .appendField("方向に1マス分スクロールする");
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(65);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
