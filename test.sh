echo original evm: ${1}596000f3
evm --json --code ${1}596000f3 run | tail -n 1 | jq .output

echo evm2:
evm --json --code `evm compile evm.easm` --input $1 run | tail -n 1 | jq .output

