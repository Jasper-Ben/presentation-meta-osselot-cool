
[//]: # SPDX-License-Identifier: CC-BY-4.0

---
title: Integrating OSSelot curation data into OpenEmbedded
subtitle: Using [meta-osselot](https://github.com/iris-GmbH/meta-osselot) to improve license compliance
author:
    - Jasper.Orschulko@iris-sensing.com
aspectratio: 169
colorlinks: true
---

# Licensing and Links

The content of this presentation is licensed under [Creative Commons BY 4.0](https://creativecommons.org/licenses/by/4.0/) and available at [https://github.com/Jasper-Ben/presentation-meta-osselot-cool](https://github.com/Jasper-Ben/presentation-meta-osselot-cool).

Here, you will also be able to access all links mentioned within the presentation.

Feel free to reuse and share in accordance to the license terms. See the Repository README for more details.

# $ whoami

\begin{columns}
    \begin{column}{0.7\textwidth}
        \begin{itemize}
            \item Jasper Orschulko, anno 1994
            \item Bachelor of Computer Science
            \item At Iris since December 2019 as DevOps Engineer
            \item My main topics are:
            \begin{itemize}
                \item Infrastructure Management and Container Orchestration
                \item Product Maintenance, Build \& Release Management
                \item Unifying dev environment
            \end{itemize}
            \item I would describe myself as "the tooling guy"
            \item Automating processes make me go \emoji{smiling-face-with-heart-eyes}
            \item Manual labour makes me go \emoji{anxious-face-with-sweat}
        \end{itemize}
    \end{column}
    \begin{column}{0.3\textwidth}
    \includegraphics[width=\textwidth]{images/me.png}
    \end{column}
\end{columns}

# And a bit about my employer: [iris-GmbH](https://www.iris-sensing.com/) \emoji{office-building}
\begin{columns}
    \begin{column}{0.7\textwidth}
        \begin{itemize}
            \item Berlin (Germany) based with \textgreater 150 employees
            \item We do passenger counting in public transport
utilizing TOF sensors with \textgreater 99\% accuracy
            \item Data used for optimizing schedules, train sizes
and ticket sales distribution, ...
            \item Since 1991, approximately 250,000 of our counting systems have been sold worldwide and installed in more than 80,000 vehicles
            \item Heavily relying on (and contributing to) open source software
            \item We are \href{https://iris-portal.rexx-systems.com/job-offers.html}{hiring}!
        \end{itemize}
    \end{column}
    \begin{column}{0.3\textwidth}
    \includegraphics[height=0.5\textheight]{images/csm_Einbau_comp_01_1_3a6f70562d.jpg}
    \includegraphics[height=0.5\textheight]{images/irma6_r2_imaging.png}
    \end{column}
\end{columns}

# Obligatory Disclaimer \emoji{balance-scale}

- IANAL (I am not a lawyer), take any of my "legal advice" with a grain of salt!

- When in doubt, consult with a lawyer of your confidence before releasing software into the wild. We have a legal department for this

- Note [section 5](https://creativecommons.org/licenses/by-sa/4.0/legalcode.en#s5) of [CC BY SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

# What are OpenEmbedded \& Yocto?

Since you are here, you probably already know what these are. If not, here the brief summary:
\small

- Community projects that allow building custom-tailored Linux-based Operating Systems

- Funded by the non-profit Linux Foundation

- Useful for purpose-built, embedded devices with limited resources, think POS-system, Printer, Router, `re.compile('smart(?!phone).*')`

- A lot of popular software [already packaged](https://layers.openembedded.org/)) for OE, well tested and continuously improved by the community

- Allows developers to focus more on the core functionality of a product and contributing to existing projects rather than reinventing the wheel

# The "Hidden" Costs of (F)OSS Software

(F)OSS software usually reduces costs, as shown in the [results of recent survey](https://project.linuxfoundation.org/hubfs/LF%20Research/Measuring%20the%20Economic%20Value%20of%20Open%20Source%20-%20Report.pdf) commissioned by the LF) but it is not free of costs, e.g.:

- (Usually) no warranties, guarantees or support, thus:

    - Might require more "hands-on" than commercial offerings, thus requiring skilled software engineers or partner companies at hand

    - Might not fulfil certification requirements or certification might need to be paid out of own pocket

    \rightarrow&nbsp;These are topics [OSADL](https://www.osadl.org/) might be able to help you with \emoji{slightly-smiling-face}

- **Fulfilling license obligations, aka License compliance can be a lengthy and expensive process**

    $\Rightarrow$ This is what we will be talking about today with a focus on OpenEmbedded Linux

# (OE) License Compliance obligations (over)simplified
For everything that is shipped to customers:

1. Provide original Source Code for copyleft (e.g. GPL*) licensed Software

2. Provide modifications to Source Code for copyleft licensed Software

3. Provide Copyright notices from Licenses & Source Code

4. Provide License notices from Licenses & Source Code

5. Provide build tooling and scripts ("[…] complete source code means all the source code […] **plus the scripts used to control compilation and installation of the executable**." - GPL* License)

# Using OpenEmbedded's Built-In Compliance Tooling

The "old" workflow: Using the `archiver.bbclass` for creating open-source (/copyleft) source-code archives

\rightarrow&nbsp;Downsides:

- Uses only the licenses declared in OE recipes which usually only contain the "top-level" package license, not licenses defined throughout the project's source code
- Copyright statements for non-copyleft software is missing (unless providing source code for all open-source software)
- Static linked build-time dependencies not included
- Sheer size of these archives
- Does not provide a workable SBOM

# Using OpenEmbedded's Built-In Compliance Tooling

\small
The "new" workflow: Using `create-spdx.bbclass` for creating a SPDX SBOM and optionally source-code archives

- Fixes a lot of issues with the "old" workflow
- Too complex to discuss in detail here, see [Joshua Watt's in-depth video](https://www.youtube.com/watch?v=Q5UQUM6zxVU) for the nitty-gritty

\rightarrow&nbsp;However, some issues remain:

-  Most notably, "bad" license data due to oversimplified license detection (only checking for SPDX headers)
-  Not easy to fix "in code" due to variety in which licenses and copyrights are declared throughout source code

# Taking License Compliance a Step Further

\small
For many use-cases (e.g. consumer-grade products) the OE approach is a good balance between effort and results. Providing the SPDX, together with (F)OSS source code will probably^\emoji{tm}^ be enough to not get sued.

However, sometimes the results from OE's built-in mechanisms are not enough:

- Increased demand for exhaustive SBOMs and License Compliance Clearing Documents throughout the
industry (especially towards component suppliers)
- You want to go the extra mile to improve confidence in your compliance status

\rightarrow&nbsp;In these cases there is no way around inspecting the actual source code files for copyright and license statements

However, manually and repeatedly inspecting source code is tedious work and becomes unmanageable for
small and medium sized companies when distributing large software packages, such as an
embedded Linux system.

# Cue to the [Osselot](https://www.osselot.org/) Project

- Relatively new project (started roughly two years ago)
- Re-uses existing FOSS software (e.g. [FOSSology](https://github.com/fossology/fossology), git)
- Trained curators create and validate high quality SPDX SBOMs for popular open-source software
- Curation data licensed under the CC0 1.0 Universal
- SBOMs made available in [GitHub](https://github.com/Open-Source-Compliance/package-analysis/) and via a REST API

The basic idea: Crowdsource the necessary curation data in a shared effort (true to the open-source spirit)

$\Rightarrow$ The challenge: How to make the data useful in your OE environment?

# Why integrate Osselot into the OE build system?

- Tackle the problem at the root

- Build system includes a lot of useful meta-information

- Reuse existing OpenEmbedded mechanisms (sstate cache, task dependencies, etc.)

- Reuse processes familiar to the OE community

# The meta-osselot OE layer

- Open-source (MIT licensed) OpenEmbedded layer

- Available at [https://github.com/iris-GmbH/meta-osselot](https://github.com/iris-GmbH/meta-osselot)
- Mainly consists of three components:
    - `osselot-package-analysis-native.bb`: recipe instructing OE from where to fetch OSSelot curation data
    - `osselot.bbclass`: The logic for matching OpenEmbedded packages against their OSSelot counterparts
    - `*.bbappends`: Various bbappends for amending recipes from upstream layers for Osselot usage

# Closer look at osselot-package-analysis-native.bb

- Takes a git source repository at a certain refspec (defaults to OSSelot's repository with latest available data on main branch)
- Clones the repository into a work directory
- Searches for available package/version combinations:

    1. Find versions by searching for folders with a "version-" prefix

    \rightarrow&nbsp; package version == version folder stripped of "version-" prefix

    2. Identify the package name via the parent folder name

    \rightarrow&nbsp; package name == package folder name

- Write available packages/versions into JSON file for later consumption

# Design choice: Git repository vs. REST API

Why don't we use the REST API provided by OSSelot for data collection?

- Easier to integrate package curation data that is not upstreamed to OSSelot (yet) using a repository fork

- Follow OpenEmbedded best-practices: Separate data fetching steps from build steps. We can still reproduce the build offline!

- Reduce bandwidth usage and runtime: OpenEmbedded git fetcher will only rerun on changes to the git repository

- More flexibility when using raw data: Package name suggestions on similar matches and reuse during version mismatch (see following slides)

# Closer look at osselot.bbclass
\small
- Decides whether a package should be validated against the OSSelot database (based on configurable parameters)

- Reads JSON file containing available OSSelot packages/versions from osselot-package-analysis-native

- Attempts to find the OpenEmbedded package in list of OSSelot packages
    - On failure: Suggests close package matches and exits

- Attempts to find the given package version within OSSelot
    - On failure: Will reuse closest available version match

- Calculates checksums of source code files within OE package and compares them to corresponding data available in OSSelot SPDX JSON file

- Writes available OSSelot data and corresponding meta file to the OpenEmbedded deploy directory

# Issues matching OE packages to OSSelot data

- Same package might be available under diverging package names / version strings e.g., expat 2.5.0 vs. libexpat R_2_5_0
- OE occasionally uses package release tarballs rather than the "original" git code OSSelot uses or might add patches

    \rightarrow&nbsp;Slight differences in source code possible

- OE ships some packages without point releases, e.g., config files where "source code" is stored
directly within the OE layer repository

$\Rightarrow$ How can we address these issues?

# Closer look at bbappend files

Extends existing recipes from community layers to work better with OSSelot:

- Automatically applied if relevant layer is used during build (using [BBFILES_DYNAMIC](https://docs.yoctoproject.org/singleindex.html#term-BBFILES_DYNAMIC))

- Adjust `OSSELOT_NAME` or `OSSELOT_VERSION` variable on naming scheme mismatch between OpenEmbedded package and OSSelot data

- Ignore packages not relevant for license compliance

- Ignore files/globs within packages not relevant for license compliance

- Define checksum equivalence between file versions, e.g., patched files with no changes to license information

$\Rightarrow$ Fixes many (but not all) issues when matching OE packages to OSSelot data

# Example bbappend file (dbus_%.bbappend)

\Tiny
```
# SPDX-License-Identifier: MIT
# Copyright 2024 iris-GmbH infrared & intelligent sensors
# The release package for dbus which is used by openembedded already
# contains artifacts from a pre-run configure step.
# These are not relevant for license compliance.
OSSELOT_IGNORE_SOURCE_GLOBS += " \
    configure \
    aminclude_static.am \
    Makefile.in \
    config.h.in \
    aclocal.m4 \
    m4/ltversion.m4 \
    m4/ltoptions.m4 \
    m4/libtool.m4 \
    m4/lt~obsolete.m4 \
    m4/ltsugar.m4 \
    doc/Makefile.in \
    test/Makefile.in \
    test/name-test/Makefile.in \
    bus/Makefile.in \
    dbus/Makefile.in \
    tools/Makefile.in \
    build-aux/config.guess \
    build-aux/config.sub \
    build-aux/missing \
    build-aux/install-sh \
    build-aux/tap-driver.sh \
    build-aux/ltmain.sh \
    build-aux/depcomp \
    build-aux/compile \
    cmake/DBus1ConfigVersion.cmake \
    cmake/DBus1Config.cmake \
"
## Define equivalence between unpatched and patched source code files
## Unpatched hashes taken from dbus/1.14.8
# configure.ac
OSSELOT_HASH_EQUIVALENCE += "c84fb14d03d4542d04a34725a41ad28e:7e480ba3a0d09e77c20758a538ddae4d"
```

# Integrating meta-osselot in your build

Enabling meta-osselot is as simple as:

1. Adding the meta-osselot layer to your build configuration (use appropriate release branch)
2. Adding `INHERIT += "osselot"` to your local.conf file

\rightarrow&nbsp;Every bitbake build command will now automatically include all relevant osselot tasks, e.g.: `bitbake core-image-minimal`

\rightarrow&nbsp; Alternatively, only running osselot-relevant tasks: `bitbake core-image-minimal --runonly=populate_osselot`

For more advanced use-cases see the projects README.

# Taking a look at meta-osselots output

Meta-osselot will create folders for all build relevant packages in OEs deploy directory, containing:

1. A package specific meta-file containing information e.g., on:
    a. The OSSelot status on this package (currently: `"ignored"`, `"version_mismatch"`, `"not_found"`, `"found"`)
    b. Ignored source files
    c. Source files checksum mismatches
    d. Applied checksum-equivalence statements
    e. Source files checksum matches
2. If package available: All OSSelot curation files for this particular package

# What is next for (meta-)osselot?
- Currently still many OE relevant packages missing from OSSelot database

    \rightarrow&nbsp; We hope to achieve 100% OSSelot coverage for the poky core-image-minimal reference image for LTS releases $\geq$ kirkstone

- Deal with "OE specific" packages

- Evaluate reusing data from `create-spdx.bbclass` or compiler data for further narrowing down of packages and source code files that are included in target
image

- Work closer with OE maintainers, ideally get OSSelot integration upstreamed

- Anything in the [issue tracker](https://github.com/iris-GmbH/meta-osselot/issues)

- As usual: Time constrains is the biggest issue \emoji{smiling-face-with-tear}

# How can you help?
- Get involved

    - Contribute curation data to OSSelot
    - Improve meta-osselot

- Spread the word

- Talk to us

    - Feedback is always appreciated!

# Demo

\center
\Huge
Demo time! \emoji{technologist}
