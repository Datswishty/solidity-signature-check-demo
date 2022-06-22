const express = require('express')
const app = express()
const port = 1337
const EthCrypto = require('eth-crypto')
const { ethers } = require('ethers')

const VERY_SECRET_PK =
  '68e37484816455bdab289e0d3d3f2e7251a7a4d9993e5d3001292d4e6df7cc42'
// THIS IS ONLY FOE DEMO PURPOSES
// PLS DO NOT INCLUDE PRIVAKE KEYS THIS CARELESSLY

app.get('/verifyme', async (req, res) => {
  const address = req.query.address
  const message = await EthCrypto.hash.keccak256([
    { type: 'address', value: address },
  ])
  const signature = await EthCrypto.sign(VERY_SECRET_PK, message)
  console.log(signature)
  return signature
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
