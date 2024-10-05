function f(x, y, z) {
  ++y;
  return f.arguments;
}
for (let i = 0; i < 900; i++) {
  args = f(f, f);
  console.log(args[1])
}

