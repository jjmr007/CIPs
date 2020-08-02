---
cip: 1
title: CIP Purpose and Guidelines
status: Active
type: Meta
author: Julio Moros <jjmorosr@gmail.com>
        https://github.com/jjmr007/CIPs/blob/master/CIPs/cip-1.md
created: 2020-08-01
updated: 
---

## What is an CIP?

CIP stands for Circle Improvement Proposal. A CIP is a design document providing information to the Circle community, or describing a new feature for the Circle platform or its processes or environment. The CIP should provide a concise technical specification of the feature and a rationale for the feature. The CIP author is responsible for building consensus within the community and documenting dissenting opinions.

## CIP Rationale

We intend CIPs to be the primary mechanisms for proposing new features, for collecting community technical input on an issue, and for documenting the design decisions that have gone into Circle. Because the CIPs are maintained as text files in a versioned repository, their revision history is the historical record of the feature proposal.

For Circle implementers, CIPs are a convenient way to track the progress of their implementation. Ideally each implementation maintainer would list the CIPs that they have implemented. This will give end users a convenient way to know the current status of a given implementation or library.

## CIP Types

There are three types of CIP:

- A **Standard Track CIP** describes any change that affects most or all Circle implementations, such as a change to the platform of payments protocol, a change the request protocol at merchant's server level, proposed application standards/conventions, or any change or addition that affects the interoperability of applications using Circle API platform. Furthermore Standard CIPs can be broken down into the following categories. Standards Track CIPs consist of three parts, a design document, implementation, and finally if warranted an update to the [formal specification].
  - **Core** - improvements requiring a consensus and taking action from Circle staff on their propietary protocol; as well as changes that are not necessarily critical but may be relevant to “circle developers” discussions.
  - **Interface** - includes improvements around user interface, and merchant requests specifications and standards
  - **ERC** - application-level standards, best practices and conventions, including contract standards, library/packages and wallet formats.
- A **Meta CIP** describes a process surrounding Circle or proposes a change to (or an event in) a process. Process CIPs are like Standards Track CIPs but apply to areas other than the Circle payment protocol itself. They may propose an implementation, but not to Circle's payment propietary protocol; they often require approval from Circle staff; unlike Informational CIPs, they are more than recommendations, and users are typically not free to ignore them. 
- An **Informational CIP** describes a Circle design issue, or provides general guidelines or information to the Circle community, but does not propose a new feature. Informational CIPs do not necessarily represent Circle's staff approval or a recommendation, so users and implementers are free to ignore Informational CIPs or follow their advice.

It is highly recommended that a single CIP contain a single key proposal or new idea. The more focused the CIP, the more successful it tends to be.

A CIP must meet certain minimum criteria. It must be a clear and complete description of the proposed enhancement. The enhancement must represent a net improvement. The proposed implementation, if applicable, must be solid and must not complicate the protocol unduly.

### Special requirements for Core CIPs

If a **Core** CIP mentions or proposes changes to the propietary Circle's payment platform, it should refer to the instructions by their request API call commands.

## CIP Work Flow

### Shepherding an CIP

Parties involved in the process are you, the champion or *CIP author*, the [*CIP editors*](#cip-editors), and the *Circle's Developers*.

Before you begin writing a formal CIP, you should vet your idea. Ask the Circle community first if an idea is original to avoid wasting time on something that will be be rejected based on prior research. It is thus recommended to open a discussion thread to do this.

In addition to making sure your idea is original, it will be your role as the author to make your idea clear to reviewers and interested parties, as well as inviting editors, developers and community to give feedback on the aforementioned channels. You should try and gauge whether the interest in your CIP is commensurate with both the work involved in implementing it and how many parties will have to conform to it. Negative community feedback will be taken into consideration and may prevent your CIP from moving past the Draft stage.

### Core CIPs

For Core CIPs, given that they require a propietary code implementations approved by Circle's staff, to be considered **Final** (see "CIPs Process" below), you will need to either provide an App for clients or convince clients about the usfullness of your CIP.

The Circle's developer staff discussion will serve as a way for client implementers to do three things. First, to discuss the technical merits of CIPs. Second, to gauge what other clients will be implementing. Third, to coordinate CIP implementation for existing APIs upgrades.

These discussions generally result in a "rough consensus" around what CIPs should be implemented. This "rough consensus" rests on the assumptions that CIPs are technically sound.

*In short, your role as the champion is to write the CIP using the style and format described below, shepherd the discussions in the appropriate forums, and build consensus around the idea.* 

### CIP Process 

Following is the process that a successful non-Core CIP will move along:

```
[ CIP ] -> [ DRAFT ] -> [ LAST CALL ] -> [ FINAL ]
```

Following is the process that a successful Core CIP will move along:

```
[ IDEA ] -> [ DRAFT ] -> [ LAST CALL ] -> [ ACCEPTED ] -> [ FINAL ]
```

Each status change is requested by the CIP author and reviewed by the CIP editors. Use a pull request to update the status. Please include a link to where people should continue discussing your CIP. The CIP editors will process these requests as per the conditions below.

* **Idea** -- Once the champion has asked the Circle staff whether an idea has any chance of support, they will write a draft CIP as a [pull request]. Consider including an implementation if this will aid people in studying the CIP.
  * :arrow_right: Draft -- If agreeable, CIP editor will assign the CIP a number (generally the issue or PR number related to the CIP) and merge your pull request. The CIP editor will not unreasonably deny an CIP.
  * :x: Draft -- Reasons for denying draft status include being too unfocused, too broad, duplication of effort, being technically unsound, not providing proper motivation or addressing backwards compatibility, or not in keeping with the [Ethereum philosophy](https://github.com/ethereum/wiki/wiki/White-Paper#philosophy).
* **Draft** -- Once the first draft has been merged, you may submit follow-up pull requests with further changes to your draft until such point as you believe the CIP to be mature and ready to proceed to the next status. An CIP in draft status must be implemented to be considered for promotion to the next status (ignore this requirement for core EIPs).
  * :arrow_right: Last Call -- If agreeable, the CIP editor will assign Last Call status and set a review end date (`review-period-end`), normally 14 days later.
  * :x: Last Call -- A request for Last Call status will be denied if material changes are still expected to be made to the draft. We hope that EIPs only enter Last Call once, so as to avoid unnecessary noise on the RSS feed.
* **Last Call** -- This CIP will listed prominently on the https://eips.ethereum.org/ website (subscribe via RSS at [last-call.xml](/last-call.xml)).
  * :x: -- A Last Call which results in material changes or substantial unaddressed technical complaints will cause the CIP to revert to Draft.
  * :arrow_right: Accepted (Core EIPs only) -- A successful Last Call without material changes or unaddressed technical complaints will become Accepted.
  * :arrow_right: Final (Non-Core EIPs) -- A successful Last Call without material changes or unaddressed technical complaints will become Final.
* **Accepted (Core EIPs only)** -- This status signals that material changes are unlikely and Ethereum client developers should consider this CIP for inclusion. Their process for deciding whether to encode it into their clients as part of a hard fork is not part of the CIP process.
  * :arrow_right: Draft -- The Core Devs can decide to move this CIP back to the Draft status at their discretion. E.g. a major, but correctable, flaw was found in the CIP.
  * :arrow_right: Rejected -- The Core Devs can decide to mark this CIP as Rejected at their discretion. E.g. a major, but uncorrectable, flaw was found in the CIP.
  * :arrow_right: Final -- Standards Track Core EIPs must be implemented in at least three viable Ethereum clients before it can be considered Final. When the implementation is complete and adopted by the community, the status will be changed to “Final”.
* **Final** -- This CIP represents the current state-of-the-art. A Final CIP should only be updated to correct errata.

Other exceptional statuses include:

* **Active** -- Some Informational and Process EIPs may also have a status of “Active” if they are never meant to be completed. E.g. CIP 1 (this CIP).
* **Abandoned** -- This CIP is no longer pursued by the original authors or it may not be a (technically) preferred option anymore.
  * :arrow_right: Draft -- Authors or new champions wishing to pursue this CIP can ask for changing it to Draft status.
* **Rejected** -- An CIP that is fundamentally broken or a Core CIP that was rejected by the Core Devs and will not be implemented. An CIP cannot move on from this state.
* **Superseded** -- An CIP which was previously Final but is no longer considered state-of-the-art. Another CIP will be in Final status and reference the Superseded CIP. An CIP cannot move on from this state.

## What belongs in a successful CIP?

Each CIP should have the following parts:

- Preamble - RFC 822 style headers containing metadata about the CIP, including the CIP number, a short descriptive title (limited to a maximum of 44 characters), and the author details. See [below](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1.md#eip-header-preamble) for details.
- Abstract - A short (~200 word) description of the technical issue being addressed.
- Motivation (*optional) - The motivation is critical for EIPs that want to change the Ethereum protocol. It should clearly explain why the existing protocol specification is inadequate to address the problem that the CIP solves. CIP submissions without sufficient motivation may be rejected outright.
- Specification - The technical specification should describe the syntax and semantics of any new feature. The specification should be detailed enough to allow competing, interoperable implementations for any of the current Ethereum platforms (cpp-ethereum, go-ethereum, parity, ethereumJ, ethereumjs-lib, [and others](https://github.com/ethereum/wiki/wiki/Clients).
- Rationale - The rationale fleshes out the specification by describing what motivated the design and why particular design decisions were made. It should describe alternate designs that were considered and related work, e.g. how the feature is supported in other languages. The rationale may also provide evidence of consensus within the community, and should discuss important objections or concerns raised during discussion.
- Backwards Compatibility - All EIPs that introduce backwards incompatibilities must include a section describing these incompatibilities and their severity. The CIP must explain how the author proposes to deal with these incompatibilities. CIP submissions without a sufficient backwards compatibility treatise may be rejected outright.
- Test Cases - Test cases for an implementation are mandatory for EIPs that are affecting consensus changes. Other EIPs can choose to include links to test cases if applicable.
- Implementations - The implementations must be completed before any CIP is given status “Final”, but it need not be completed before the CIP is merged as draft. While there is merit to the approach of reaching consensus on the specification and rationale before writing code, the principle of “rough consensus and running code” is still useful when it comes to resolving many discussions of API details.
- Security Considerations - All EIPs must contain a section that discusses the security implications/considerations relevant to the proposed change. Include information that might be important for security discussions, surfaces risks and can be used throughout the life cycle of the proposal. E.g. include security-relevant design decisions, concerns, important discussions, implementation-specific guidance and pitfalls, an outline of threats and risks and how they are being addressed. CIP submissions missing the "Security Considerations" section will be rejected. An CIP cannot proceed to status "Final" without a Security Considerations discussion deemed sufficient by the reviewers.
- Copyright Waiver - All EIPs must be in the public domain. See the bottom of this CIP for an example copyright waiver.

## CIP Formats and Templates

EIPs should be written in [markdown] format.
Image files should be included in a subdirectory of the `assets` folder for that CIP as follows: `assets/eip-N` (where **N** is to be replaced with the CIP number). When linking to an image in the CIP, use relative links such as `../assets/eip-1/image.png`.

## CIP Header Preamble

Each CIP must begin with an [RFC 822](https://www.ietf.org/rfc/rfc822.txt) style header preamble, preceded and followed by three hyphens (`---`). This header is also termed ["front matter" by Jekyll](https://jekyllrb.com/docs/front-matter/). The headers must appear in the following order. Headers marked with "*" are optional and are described below. All other headers are required.

` eip:` *CIP number* (this is determined by the CIP editor)

` title:` *CIP title*

` author:` *a list of the author's or authors' name(s) and/or username(s), or name(s) and email(s). Details are below.*

` * discussions-to:` *a url pointing to the official discussion thread*

` status:` *Draft | Last Call | Accepted | Final | Active | Abandoned | Rejected | Superseded*

`* review-period-end:` *date review period ends*

` type:` *Standards Track | Informational | Meta*

` * category:` *Core | Networking | Interface | ERC* (Standards Track EIPs only)

` created:` *date created on*

` * updated:` *comma separated list of dates*

` * requires:` *CIP number(s)*

` * replaces:` *CIP number(s)*

` * superseded-by:` *CIP number(s)*

` * resolution:` *a url pointing to the resolution of this CIP*

Headers that permit lists must separate elements with commas.

Headers requiring dates will always do so in the format of ISO 8601 (yyyy-mm-dd).

#### `author` header

The `author` header optionally lists the names, email addresses or usernames of the authors/owners of the CIP. Those who prefer anonymity may use a username only, or a first name and a username. The format of the author header value must be:

> Random J. User &lt;address@dom.ain&gt;

or

> Random J. User (@username)

if the email address or GitHub username is included, and

> Random J. User

if the email address is not given.

#### `resolution` header

The `resolution` header is required for Standards Track EIPs only. It contains a URL that should point to an email message or other web resource where the pronouncement about the CIP is made.

#### `discussions-to` header

While an CIP is a draft, a `discussions-to` header will indicate the mailing list or URL where the CIP is being discussed. As mentioned above, examples for places to discuss your CIP include [Ethereum topics on Gitter](https://gitter.im/ethereum/topics), an issue in this repo or in a fork of this repo, [Ethereum Magicians](https://ethereum-magicians.org/) (this is suitable for EIPs that may be contentious or have a strong governance aspect), and [Reddit r/ethereum](https://www.reddit.com/r/ethereum/).

No `discussions-to` header is necessary if the CIP is being discussed privately with the author.

As a single exception, `discussions-to` cannot point to GitHub pull requests.

#### `type` header

The `type` header specifies the type of CIP: Standards Track, Meta, or Informational. If the track is Standards please include the subcategory (core, networking, interface, or ERC).

#### `category` header

The `category` header specifies the CIP's category. This is required for standards-track EIPs only.

#### `created` header

The `created` header records the date that the CIP was assigned a number. Both headers should be in yyyy-mm-dd format, e.g. 2001-08-14.

#### `updated` header

The `updated` header records the date(s) when the CIP was updated with "substantial" changes. This header is only valid for EIPs of Draft and Active status.

#### `requires` header

EIPs may have a `requires` header, indicating the CIP numbers that this CIP depends on.

#### `superseded-by` and `replaces` headers

EIPs may also have a `superseded-by` header indicating that an CIP has been rendered obsolete by a later document; the value is the number of the CIP that replaces the current document. The newer CIP must have a `replaces` header containing the number of the CIP that it rendered obsolete.

## Auxiliary Files

EIPs may include auxiliary files such as diagrams. Such files must be named CIP-XXXX-Y.ext, where “XXXX” is the CIP number, “Y” is a serial number (starting at 1), and “ext” is replaced by the actual file extension (e.g. “png”).

## Transferring CIP Ownership

It occasionally becomes necessary to transfer ownership of EIPs to a new champion. In general, we'd like to retain the original author as a co-author of the transferred CIP, but that's really up to the original author. A good reason to transfer ownership is because the original author no longer has the time or interest in updating it or following through with the CIP process, or has fallen off the face of the 'net (i.e. is unreachable or isn't responding to email). A bad reason to transfer ownership is because you don't agree with the direction of the CIP. We try to build consensus around an CIP, but if that's not possible, you can always submit a competing CIP.

If you are interested in assuming ownership of an CIP, send a message asking to take over, addressed to both the original author and the CIP editor. If the original author doesn't respond to email in a timely manner, the CIP editor will make a unilateral decision (it's not like such decisions can't be reversed :)).

## CIP Editors

The current CIP editors are

` * John Doe (@doe)`

## CIP Editor Responsibilities

For each new CIP that comes in, an editor does the following:

- Read the CIP to check if it is ready: sound and complete. The ideas must make technical sense, even if they don't seem likely to get to final status.
- The title should accurately describe the content.
- Check the CIP for language (spelling, grammar, sentence structure, etc.), markup (GitHub flavored Markdown), code style

If the CIP isn't ready, the editor will send it back to the author for revision, with specific instructions.

Once the CIP is ready for the repository, the CIP editor will:

- Assign an CIP number (generally the PR number or, if preferred by the author, the Issue # if there was discussion in the Issues section of this repository about this CIP)

- Merge the corresponding pull request

- Send a message back to the CIP author with the next step.

Many EIPs are written and maintained by developers with write access to the Ethereum codebase. The CIP editors monitor CIP changes, and correct any structure, grammar, spelling, or markup mistakes we see.

The editors don't pass judgment on EIPs. We merely do the administrative & editorial part.

## Style Guide

When referring to an CIP by number, it should be written in the hyphenated form `CIP-X` where `X` is the CIP's assigned number.


## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
