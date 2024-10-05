function f() {
    console.log(":)");
    const o = {};
    Object.defineProperty(o, "c", { configurable: true, set: f });
    return o;
}
const v = f();
class A extends f {
    c = v;
}
new A();
new A();

