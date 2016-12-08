Blockly.Blocks['pwm'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown([["OUT2", "out2"], ["OUT3", "out3"], ["OUT4", "out4"], ["OUT5", "out5"]]), "out")
        .appendField("で")
        .appendField(new Blockly.FieldNumber(2000, 0, 2000), "msec")
        .appendField("ミリ秒")
        .appendField("周期：")
        .appendField(new Blockly.FieldNumber(2000, 0, 2000), "period")
        .appendField("のパルスを出力する");
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(180);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
