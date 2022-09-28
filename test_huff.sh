echo original evm:
evm --json --debug --code ${1}596000f3 run | tail -n 1 | jq .output

echo ""
echo huff-evm2:
./run_huff.sh $1 | tail -n 1 | jq .output

