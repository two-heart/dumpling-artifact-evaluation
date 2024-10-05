class A {  
  constructor() {  
    this.prop = 1;  
  }  
}  
  
function trigger() {  
    class B extends A {  
        set prop(x) { console.log(x); }  
  
        prop = 12341234;  
    }  
  
    return new B();  
}  
  
for (let j = 0; j < 20; j++) {  
  trigger();  
}

