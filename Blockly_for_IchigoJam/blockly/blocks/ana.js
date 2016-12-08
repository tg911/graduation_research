Blockly.Blocks['ana'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown([["IN0", "in0"], ["IN2", "in2"], ["IN5", "in5"], ["IN6", "in6"], ["IN7", "in7"], ["IN8", "in8"], ["IN9", "in9"]]), "input")
        .appendField("の電圧");
    this.setOutput(true, "Number");
    this.setColour(315);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
