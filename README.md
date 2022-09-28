# e=vm²

*e=vm²* (pronounced *evm-squared*; the = is silent), also spelled *evm2*, is an evm that runs inside evm.

## Yo dawg I heard you like building

## Huff - use this!

Added [huff](https://huff.sh/) implementation:

`run_huff.sh` and `test_huff.sh`

### Compiling (old method)

`evm` is a tool that comes with `go-ethereum`.

```sh
evm compile evm.easm
```

### Running (old method)

Use `evm run` or the provided helper script:

```sh
./run.sh 0x<bytecode>
```

### Debugging (old method)

`./disas.sh` will compile *evm2* and then show disassembly so, you can like, do things that help stuff.

## Testing

(NOTE: code without a return statement will return evm2's memory)

return 0x33 * 2:

```sh
./test_huff.sh 60336002025952
"0000000000000000000000000000000000000000000000000000000000000066"
```

return [0x00, 0x20, 0x40]:
```sh
./test_huff.sh 595952595952595952
"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000040"
```

mstore8 & mstore:
```sh
./test_huff.sh 6040595360205952
"40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020"
```

emit LOG0(abi.encode(uint256(-1), uint256(0))):

(to see logs need to run `evm --debug`)
```sh
# classic evm:
evm --debug --json --code 600019595260406000a0 run

# and for evm2:
evm --debug --json --code `huffc evm.huff --bin-runtime` --input 600019595260406000a0 run

#### LOGS ####
LOG0: 0000000000000000000000007265636569766572 bn=0 txi=0
00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
```

### untested

untested but presumably works:

- `CALL`, `STATICCALL`, `DELEGATECALL`, `CALLCODE`
- `CREATE`, `CREATE2`
- `CODESIZE` (simply replaced to `CALLDATASIZE`)
- `CODECOPY` (simply replaced to `CALLDATACOPY`)

## TODO

Not yet implemented:
- `SELFDESTRUCT` - currently implemented as `STOP`... (probably should not be implemented at all)

Implemented without virtualization: (will shift all data 32 bytes)
- `GAS` (note: can implement HOSTGAS opcode in addition to virtualized GAS but is it useful?)
- `CALLDATASIZE` (this would be CODESIZE of the input code)
- `CALLDATACOPY` (this would be CODECOPY of the input code)
- `RETURNDATASIZE` (supposedly ok)
- `RETURNDATACOPY` (supposedly ok)

NOTE:
  `CODESIZE` & `CODECOPY` are simply translated to CALLDATASIZE & CALLDATACOPY.

# Fun fact

I used `evm` to write pure bytecode, I couldn't even use labels for jumps I had to calculate offsets!
I wanted to do it in pure solidity or yul; I just couldn't get it to run properly.
Solidity has breaking changes every other day especially when it comes to inline assembly.
So I just ended up implementing from scratch.

Thanks to [The Optimizor](https://twitter.com/0x_Beans/status/1568661118259982336) by [0x_Beans](http://twitter.com/0x_Beans), by the end of which I was building mental models in pure assembly while typing bytecodes from memory.

