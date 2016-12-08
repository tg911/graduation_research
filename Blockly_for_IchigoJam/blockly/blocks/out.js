Blockly.Blocks['out'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("出力")
        .appendField(new Blockly.FieldDropdown([["OUT1", "out1"], ["OUT2", "out2"], ["OUT3", "out3"], ["OUT4", "out4"], ["OUT5", "out5"], ["OUT6", "out6"], ["OUT7", "out7"], ["OUT8", "out8"], ["OUT9", "out9"], ["OUT10", "out10"], ["OUT11", "out11"]]), "out")
        .appendField("を")
        .appendField(new Blockly.FieldDropdown([["オン", "on"], ["オフ", "off"]]), "bool")
        .appendField("にする");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(180);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
