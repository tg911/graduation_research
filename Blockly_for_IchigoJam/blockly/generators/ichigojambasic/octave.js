Blockly.JavaScript['octave'] = function(block) {
  var number_octave = block.getFieldValue('octave');
  var value_note = Blockly.JavaScript.valueToCode(block, 'note', Blockly.JavaScript.ORDER_ATOMIC);
  // TODO: Assemble JavaScript into code variable.
  var code = '...';
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.JavaScript.ORDER_NONE];
};