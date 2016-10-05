define(["../javascript"],function(generators){
    
generators['picaxe_custom_outputon'] = function(block) {
  var dropdown_value = block.getFieldValue('VALUE');
  var code = "picaxe." + ((dropdown_value == "1") ? "high" : "low");
  code += "(" + generators.getPinName(block) + ");";
  return generators.wrapOutput(block, code);
};

});