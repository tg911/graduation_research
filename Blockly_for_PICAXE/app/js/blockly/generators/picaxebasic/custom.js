define([
"../picaxebasic"
],function(generators){

generators['picaxe_custom_outputon'] = function(block) {
  var dropdown_value = block.getFieldValue('VALUE');
  var code = ((dropdown_value == "1") ? "\thigh" : "\tlow");
  code += " " + generators.getPinName(block);
  code += "\n";
  return generators.wrapOutput(block, code);
};

});
