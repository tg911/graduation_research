Blockly.Blocks['in'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown([["IN0", "in0"], ["IN1", "in1"], ["IN2", "in2"], ["IN3", "in3"], ["IN4", "in4"], ["IN5", "in5"], ["IN6", "in6"], ["IN7", "in7"], ["IN8", "in8"], ["IN9", "in9"], ["IN10", "in10"]]), "input")
        .appendField("の状態");
    this.setInputsInline(true);
    this.setOutput(true, "Number");
    this.setColour(315);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
