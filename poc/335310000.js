function A() {
    Object.defineProperty(this, "x", { writable: true, configurable: true, value: undefined });
}

class B extends A {
    x = {};
}

for (let i = 0; i < 100; i++) {
    new B();
}

let b = new B();
console.log(b.propertyIsEnumerable("x"));

