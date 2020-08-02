
---
eip: 2
title: Funneled Circle Business Accounts
author: Julio Moros <jjmorosr@gmail.com>
discussions-to: https://discord.com/channels/473781666251538452/720664509982703687
status: Draft
type: Standards Track
category: Core
created: 2020-08-01
---


## Simple Summary

A standard interface for gas abstraction in top of smart contracts. 

Allows users to offer [EIP-20] token for paying the gas used in a call. 

## Abstract

A main barrier for adoption of DApps is the requirement of multiple tokens for executing in chain actions. Allowing users to sign messages to show intent of execution, but allowing a third party relayer to execute them can circumvent this problem, while ETH will always be required for ethereum transactions, it's possible for smart contract to take [EIP-191] signatures and forward a payment incentive to an untrusted party with ETH for executing the transaction. 

## Motivation

Standardizing a common format for them, as well as a way in which the user allows the transaction to be paid in tokens, gives app developers a lot of flexibility and can become the main way in which app users interact with the Blockchain.


## Specification 

### Request Functions Changed

After signature validation, the evaluation of `_execBytes` is up to the account contract implementation, it's role of the wallet to properly use the account contract and it's gas relay method. 
A common pattern is to expose an interface which can be only called by the contract itself. The `_execBytes` could entirely forward the call in this way, as example: `address(this).call.gas(_gasLimit)(_execData);`
Where `_execData` could call any method of the contract itself, for example:

- `call(address to, uint256 value, bytes data)`:  allow any type of ethereum call be performed; 
- `create(uint256 value, bytes deployData)`: allows create contract 
- `create2(uint256 value, bytes32 salt, bytes deployData)`: allows create contract with deterministic address 
- `approveAndCall(address token, address to, uint256 value, bytes data)`: allows safe approve and call of an ERC20 token.
- `delegatecall(address codeBase, bytes data)`: allows executing code stored on other contract
- `changeOwner(address newOwner)`: Some account contracts might allow change of owner
- `foo(bytes bar)`: Some account contracts might have custom methods of any format.

The standardization of account contracts is not scope of this ERC, and is presented here only for illustration on possible implementations. 
Using a self call to evaluate `_execBytes` is not mandatory, depending on the account contract logic, the evaluation could be done locally. 

## Rationale

User pain points:

* users don't want to think about ether
* users don't want to think about backing up private keys or seed phrases
* users want to be able to pay for transactions using what they already have on the system, be apple pay, xbox points or even a credit card
* Users don’t want to sign a new transaction at every move
* Users don’t want to download apps/extensions (at least on the desktop) to connect to their apps

App developer pain points:
* Many apps use their own token and would prefer to use those as the main accounting
* Apps want to be able to have apps in multiple platforms without having to share private keys between devices or have to spend transaction costs moving funds between them
* Token developers want to be able for their users to be able to move funds and pay fees in the token
* While the system provides fees and incentives for miners, there are no inherent business model for wallet developers (or other apps that initiate many transactions)

Using signed messages, specially combined with an account contract that holds funds, and multiple disposable ether-less keys that can sign on its behalf, solves many of these pain points.

### Usage examples

This scheme opens up a great deal of possibilities on interaction as well as different experiments on business models:

* Apps can create individual identities contract for their users which holds the actual funds and then create a different private key for each device they log into. Other apps can use the same identity and just ask to add permissioned public keys to manage the device, so that if one individual key is lost, no ether is lost.
* An app can create its own token and only charge their users in its internal currency for any ethereum transaction. The currency units can be rounded so it looks more similar to to actual amount of transactions: a standard transaction always costs 1 token, a very complex transaction costs exactly 2, etc. Since the app is the issuer of the transactions, they can do their own Sybil verifications and give a free amount of currency units to new users to get them started.
* A game company creates games with a traditional monthly subscription, either by credit card or platform-specific microtransactions. Private keys never leave the device and keep no ether and only the public accounts are sent to the company. The game then signs transactions on the device with gas price 0, sends them to the game company which checks who is an active subscriber and batches all transactions and pays the ether themselves. If the company goes bankrupt, the gamers themselves can set up similar subscription systems or just increase the gas price. End result is a **ethereum based game in which gamers can play by spending apple, google or xbox credits**.
* A standard token is created that doesn’t require its users to have ether, and instead allows tokens to be transferred by paying in tokens. A wallet is created that signs messages and send them via whisper to the network, where other nodes can compete to download the available transactions, check the current gas price, and select those who are paying enough tokens to cover the cost. **The result is a token that the end users never need to keep any ether and can pay fees in the token itself.**
* A DAO is created with a list of accounts of their employees. Employees never need to own ether, instead they sign messages, send them to whisper to a decentralized list of relayers which then deploy the transactions. The DAO contract then checks if the transaction is valid and sends ether to the deployers. Employees have an incentive not to use too many of the companies resources because they’re identifiable.  The result is that the users of the DAO don't need to keep ether, and **the contract ends up paying for it's own gas usage**.

## Backwards Compatibility

There is no issues with backwards compatibility, however for future upgrades, as `_execData` contains arbitrary data evaluated by the account contract, it's up to the contract to handle properly this data and therefore contracts can gas relay any behavior with the current interface.

## Implementation

One initial implementation of such a contract can be found at [Status.im account-contracts repository](https://github.com/status-im/account-contracts/blob/develop/contracts/account/AccountGasAbstract.sol)

Other version is implemented as Gnosis Safe variant in: https://github.com/status-im/safe-contracts

## Security Considerations

Deployers of transactions (relayers) should be able to call untrusted contracts, which provides no guarantees that the contract they are interacting with correctly implements the standard and they will be reimbursed for gas. To prevent being fooled by bad implementations, relayers must **estimate the outcome of a transaction**, and only include/sign transactions which have a desired outcome. 

Is also interest of relayers to maintaining a private reputation of contracts they interact with, as well as keep track of which tokens and for which `gasPrice` they’re willing to deploy transactions.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
