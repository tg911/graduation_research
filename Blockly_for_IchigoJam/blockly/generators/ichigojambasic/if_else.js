Blockly.JavaScript['if_else'] = function(block) {
  var value_condition = Blockly.JavaScript.valueToCode(block, 'condition', Blockly.JavaScript.ORDER_ATOMIC);
  var statements_execute = Blockly.JavaScript.statementToCode(block, 'execute');
  var statements_elseexecute = Blockly.JavaScript.statementToCode(block, 'elseExecute');
  // TODO: Assemble JavaScript into code variable.
  var code = '...;\n';
  return code;
};