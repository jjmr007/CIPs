---
eip: 2
title: Funnelled Circle Business Accounts
author: Julio Moros <jjmorosr@gmail.com>
discussions-to: https://discord.com/channels/473781666251538452/720664509982703687
status: Draft
type: Standards Track
category: Core
created: 2020-08-01
---


## Simple Summary

Create a new type of Circle Business Account, which may be called "Funnelled Accounts". 

Unlike what we could call general purpose accounts from now on, a channeled account can only withdraw funds from the master wallet to a single address of the blockchain, containing a smart contract.

This kind of accounts may allow to business to offer to the public tokenized shares, with a very reduced or null intervention of regulatory bodies.

## Abstract

Because the code of Circle's exclusive payment platform, as a result of seven years of experience in payment processing, is a proprietary code, and by virtue of the timely acceptance of suggestions from customers and users, which frequently results in the benefit of companies, the following suggestion is presented to enable Circle Business Accounts with a single channel to liquidate funds: the Funnelled Account.

These type of accounts will be able to receive payments from whatever many internal wallets are created inside the Circle API master wallet (through debit and credit cards), and receive payments in USDC from the blockchain from whatever many addres created for the internal wallets of the platform.

However, funds cannot be withdrawn from these accounts, but only to a single smart contract, the address of which will be provided by the merchant when requesting the account.

This contract must be previously deployed on the blockchain for the Circle team to accept the creation of the Funnelled Account, and the code of it must be checked at least in etherscan, in addition to providing some type of audit (in which the Circle team can assist customer).

This will allow tokenize the shares of any business, no matter how small it is, since the income from a commercial activity will be publicly viewed and auditable, without the possibility of deceiving shareholders.

## Motivation

So far, only large companies -and after strict regulatory processes- can become public, offering their shares to the public. Through Funnelled Accounts, Circle would open the doors to tokenization of shares for small and medium-sized companies, who could do it with virtually no oversight from regulatory agencies in many jurisdictions.

This is because the "raison d'être" of most regulatory laws is shareholder protection, seeking to establish mechanisms that prevent a company from diverting funds from its commercial activity to avoid the payment and recognition of dividends.

If funds from a commercial activity can only be transfered to a smart contract, which autonomously enforces promises of an agreement translated into lines of code, then the risk of shareholder fraud would be resolved, without the need for regulatory intervention.

And this is the reason that justifies the existence of Funnelled Accounts.


## Specification 

### Procedure for the Creation of a New Funnelled Account

When a merchant (or a group of associates) requests a Funnelled Account, the request, in addition to covering the legal details of their jurisdiction, must provide the code of a smart contract, some audit of the code and assistance of Circle staff (if it is required) to deploy this contract in the Ethereum mainnet prior to the approval of the Funnelled Account.

All Circle Business Accounts are stored in a database, with a unique correspondence to a secret API-KEY. When a Funnelled Account is approved, the Circle team includes the address of the deployed smart contract provided in the account request, associated to this API-KEY.

All Circle's Business Accounts would have a Boolean flag associated with them, which by default would be "false" (in order to facilitate the backwards compatibility). In that case, the smart contract address data will be a field required by the database, and to be provided only by the Circle team by the time of creation of the funnelled business account. This address parameter won't be able to be changed, after the account creation.

### Request Functions Changed

Only the responses of two functions or commands of API requests to Circle's payment protocol will be modified, in the case of Funnelled Accounts.

N°1: The **`POST /wire`** request. All requests to this command from the API-KEY of a Funnelled Account should get an error as response. Something like: "`funneled account, please fill a request for a general purpose account`".

N°2: The **`POST /transfer`** request. All requests to this command from the API-KEY of a Funnelled Account that includes in the field `"type":` the value of `"wallet"`:

```json
"destination": {
"type": "wallet",
``` 

Should always get an error as response. Something like: "`funneled account, please fill a request for a general purpose account`".
Only the requests to this command from the API-KEY of a Funnelled Account, that includes in the field `"type":` the value of `"blockchain"`, and if in the field of `"address"` it includes de right address value of the smart contract associated to the Funnelled Account, it should result in a succesfull request:

```json
"destination": {
"type": "blockchain",
"address": "0x<THE_RIGHT_SMART_CONTRACT_ADDRESS_ASSOCIATED_TO_THE_API_KEY>",
"chain": "ETH"
} 
``` 

Otherwise, the response returned by the Circle payment platform API, to the requests generated from the API-KEY of a Funnelled Account, must be an error message, and the request must be repudiated from the Circle's platform. Something like: "`funneled account, please fill a request for a general purpose account`".

## Rationale

The currently existing alternatives for the tokenization of shares by small and medium-size companies, which can be offered to the public, through some mechanism that save them from the cumbersome process of the bureaucracy of regulatory entities, are practically non-existent in the market of financial services; such alternatives clearly are not within the current state of the art.

The implementation of channeled accounts would give Circle an unmatched competitive advantage in this field of financial services, and would translate into a significant increase of its demand for its services.

### Usage examples

There are endless possibilities of use for this idea, but below I will present at least two:

* _Payroll Implementation_: Apps can create individual identities contract for their users which holds the actual funds and then create a different private key for each device they log into. Other apps can use the same identity and just ask to add permissioned public keys to manage the device, so that if one individual key is lost, no ether is lost.
* _Dividend Distribution_: its own token and only charge their users in its internal currency for any ethereum transaction. The currency units can be rounded so it looks more similar to to actual amount of transactions: a standard transaction always costs 1 token, a very complex transaction costs exactly 2, etc. Since the app is the issuer of the transactions, they can do their own Sybil verifications and give a free amount of currency units to new users to get them started.

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
