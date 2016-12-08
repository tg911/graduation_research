Blockly.Blocks['btn'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown([["ボタン", "btn"], ["↑", "up"], ["↓", "down"], ["→", "right"], ["←", "left"], ["スペース", "space"]]), "argument")
        .appendField("の状態（オン：1 オフ：0）");
    this.setOutput(true, "Number");
    this.setColour(315);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
