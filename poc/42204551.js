function f() {
  var i = 0;
  while (i++ < 2) {
    j = 0;
    while (j++ < 1) {
      %OptimizeOsr(); %PrepareFunctionForOptimization(f);
      j++;
    }
  }
}

f();

