# ABI & AST Encoding Formats

## ABI Encoder v2

> No Longer considered `experimental` , will retain this naming convention for backwards comp. reasons

## solidity Parsers 

The standard antlr4 grammar produces a few less fields than the Consensys Dilligence one 

Explore the differences in `ast` formats here: [https://astexplorer.net/](https://astexplorer.net/)

### Smart contract interfaces ( abi json files) can have different formats, for example:


### abi-json
```js
{
  abi: "...",
  evm:
    bytecode:
      object: "0x..."
}
```

### 0x/solcompiler

0x/sol-compiler outputs JSON in this format:
```js
{
  compiledOutput:
    abi: "...",
    evm:
      bytecode:
        object: "0x..."
}
```
### Truffle 
truffle compile outputs JSON in this format:
```js
{
  abi: "...",
  bytecode: "0x...."
}
```

> more to follow
