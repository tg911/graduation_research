Blockly.Blocks['calculation'] = {
  init: function() {
    this.appendValueInput("varA")
        .setCheck("Number");
    this.appendValueInput("varB")
        .setCheck("Number")
        .appendField(new Blockly.FieldDropdown([["+", "addition"], ["-", "subtraction"], ["*", "multiplication"], ["/", "division"], ["%", "modulo"], ["AND", "and"], ["OR", "or"], ["=", "equal"], ["<>", "notEqual"], ["<=", "lessEqual"], ["<", "less"], [">=", "greaterEqual"], [">", "greater"]]), "calculation");
    this.setInputsInline(true);
    this.setOutput(true, "Number");
    this.setColour(210);
    this.setTooltip('');
    this.setHelpUrl('http://www.example.com/');
  }
};
