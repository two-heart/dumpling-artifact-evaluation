y = -BigInt("9223372036854775808")
function b() {
    let x = BigInt.asUintN(64, -1n);
    console.log("x: ", x);
    console.log("y: ", y);
    let diff = x <<  (y);
    return BigInt.asIntN(64, diff);
}

console.log("diff: ", b());
console.log("diff: ", b());
%OptimizeFunctionOnNextCall(b);
console.log("diff: ", b());

