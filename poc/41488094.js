function f(i) {  
    return {  
        get d() {  
            console.log(i);  
            return i;  
        }  
    };  
}  
  
for(let i = 0; i < 15; i++) {  
  const child = f(i);  
  const proto = f(i);  
  child.__proto__ = proto;  
  
  let newd;  
  let spr;  
  ({"d":newd,...spr} = proto);  
  console.log("-");  
}

