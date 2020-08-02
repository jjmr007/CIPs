# Circle Improvement Proposals (CIPs)


Circle Improvement Proposals (CIPs) describe standards for the Circle payment api platform, including the propietary protocol specifications, client APIs, and the platform standards.

# Contributing

 1. Review [CIP-1](CIPS/cip-1.md).
 2. Fork the repository by clicking "Fork" in the top right.
 3. Add your CIP to your fork of the repository. There is a [template CIP here](cip-template.md).
 4. Submit a Pull Request to Circle's [CIPs repository](https://github.com/jjmr007/CIPs).

Your first PR should be a first draft of the final CIP. It must meet the formatting criteria enforced by the build (largely, correct metadata in the header). An editor will manually review the first PR for a new CIP and assign it a number before merging it. Make sure you include a `discussions-to` header with the URL to a discussion forum or open GitHub issue where people can discuss the CIP as a whole.

If your cip requires images, the image files should be included in a subdirectory of the `assets` folder for that cip as follows: `assets/cip-N` (where **N** is to be replaced with the CIP number). When linking to an image in the CIP, use relative links such as `../assets/CIP-1/image.png`.

Once your first PR is merged, we have a bot that helps out by automatically merging PRs to draft CIPs. For this to work, it has to be able to tell that you own the draft being edited. Make sure that the 'author' line of your CIP contains either your GitHub username or your email address inside <triangular brackets>. If you use your email address, that address must be the one publicly shown on [your GitHub profile](https://github.com/settings/profile).

When you believe your cip is mature and ready to progress past the draft phase, you should do one of two things:

 - **For a Standards Track CIP of type Core**, ask to have your issue added to the agenda of an upcoming All Core Devs meeting, where it can be discussed for inclusion in a future upgrade of the platform. If implementers agree to include it, the CIP editors will update the state of your CIP to 'Accepted'.
 - **For all other CIPs**, open a PR changing the state of your CIP to 'Final'. An editor will review your draft and ask if anyone objects to its being finalised. If the editor decides there is no rough consensus - for instance, because contributors point out significant issues with the CIP - they may close the PR and request that you fix the issues in the draft before trying again.

# CIP Status Terms

* **Draft** - an CIP that is undergoing rapid iteration and changes.
* **Last Call** - an CIP that is done with its initial iteration and ready for review by a wide audience.
* **Approved** - a core CIP that has been in Last Call for at least 2 weeks and any technical changes that were requested have been addressed by the author. The process for Core Devs to decide whether to encode an CIP into their clients as part of a hard fork is not part of the CIP process. If such a decision is made, the CIP will move to final.
* **Final (non-Core)** - an CIP that has been in Last Call for at least 2 weeks and any technical changes that were requested have been addressed by the author.
* **Final (Core)** - an CIP that the Core Devs have decided to implement and release in a future hard fork or has already been released in a hard fork. 
