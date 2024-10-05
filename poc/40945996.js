function profiledFunction() {}  
console.profile(profiledFunction);  
  
function func(start_at) {  
  // only execute once maglev compilation is done  
  if (start_at < 400) return;  
  class ClassDefinition {}  
  
  for (let i = 0; i < 400; i++) {  
    () => {}  
  }  
  const options = {  
      "type": "function",  
  };  
  const worker = new Worker(() => {},  
                            options);  
  worker.terminate()  
  
  const used = ClassDefinition && 0;  
  used | 0;  
}  
  
for(let i = 0; i < 410; i++){  
  func(i);  
}  

