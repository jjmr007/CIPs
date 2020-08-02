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

* _Payroll Implementation_: A group of associates decides to create a cooperative transportation company, but members who work for the cooperative demand to be sure that the company's profits are fairly distributed and that payments to suppliers, services and taxes are transparent processes. This [contract](https://github.com/jjmr007/CIPs/blob/master/assets/cip-2/payroll/Payroll.sol) reflects this situation, which is only possible when the Circle Business Account is of the "Funnelled" type. And in this [document](https://github.com/jjmr007/CIPs/blob/master/assets/cip-2/payroll/README.md) a brief review of the contract is made.
* _Dividend Distribution_: A civil association in Panama decides to contract the services of a construction company to develop a complex "mall" type shopping center. For this they decide to rise the funds through a process and a contract type [DAICO](https://ethresear.ch/t/explanation-of-daicos/465) (not shown in this proposal). Upon successful completion of the work, each member of the civil association has a token (which in this [contract](https://github.com/jjmr007/CIPs/blob/master/assets/cip-2/payroll/Payroll.sol) is referred to as the Type B token) with which they can go to the referred dividend distribution contract to collect their royalties, in USDC currency (which in the referred contract is mentioned to as type A token). The Circle API acdept payments from of both merchants' debit and credit cards for the pay of the rent of their commercial shops of the shopping center. But only through a funnelled account it is possible to guarantee to the shareholders (or holders of type B tokens) that they will be receiving the true dividends from the payment of rents. The following [document](https://github.com/jjmr007/CIPs/blob/master/assets/cip-2/payroll/README.md) provides a brief explanation of the contract. WARNING: These contracts are merely illustrative examples and their use in production is not recommended until they go through an adequate testing process.

## Backwards Compatibility

There are two potential risks in backwards compatibility:

1.- The assignment of a boolean flag to each new account / secret API-KEY, which is a parameter that is assumed to be still non-existent. To improve the probability of backwards compatibility, general purpose accounts (or "normal" accounts) will have this flag associated with "false" and only funnelled accounts will have this flag associated with "true".
2.- The assignment of the only blockchain address to which a funnelled account can withdraw funds. "Normal" accounts that previously did not have a value for this new field can assume a NULL value or the address 0x0000000000000000000000000000000000000000; then funnelled accounts would receive a significant value for this field (the associated smart contract address). However, this development depends on the particularities of the database of the proprietary code of the Circle payment platform.

## Implementation

It is hoped that if a proposal like this is accepted, upon acceptance of the draft and within a reasonable amount of time, the Circle team will be able to generate a fork of your available code in a "Funnelled-Related-Sand-Box". And after the due discussion and tests, if no bugs are found, it can be integrated into the main Sand-Box. Finnally, if it is accepted by Circle staff ant the community, the code will be merged to the main Circle payment system platform.

## Security Considerations

Security considerations are exclusively on the side of changes to Circle's proprietary code, as none other changes are suggested to any other application.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
