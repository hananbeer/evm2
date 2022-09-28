# e=vm²

*e=vm²* (pronounced *evm-squared; the = is silent), also spelled *evm2*, is an evm that runs inside evm.

## Yo dawg I heard you like building

### Compiling

`evm` is a tool that comes with `go-ethereum`.

```sh
evm compile evm.easm
```

### Running

Use `evm run` or the provided helper script:

```sh
./run.sh 0x<bytecode>
```

### Debugging

`./disas.sh` will compile *evm2* and then show disassembly so, you can like, do things that help stuff.

# Fun fact

I used `evm` to write pure bytecode, I couldn't even use labels for jumps I had to calculate offsets!
I wanted to do it in pure solidity or yul; I just couldn't get it to run properly.
Solidity has breaking changes every other day especially when it comes to inline assembly.
So I just ended up implementing from scratch.

Thanks to [The Optimizor](https://twitter.com/0x_Beans/status/1568661118259982336) by [0x_Beans](http://twitter.com/0x_Beans), by the end of which I was building mental models in pure assembly while typing bytecodes from memory.
