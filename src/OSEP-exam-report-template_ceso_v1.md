---
title: "Offensive Security Experienced Penetration Tester Exam Report"
author: ["foo@bar.com", "OSID: 12345"]
date: "2022-01-25"
subject: "Markdown"
keywords: [Markdown, Example]
subtitle: "OSEP Exam Report"
lang: "en"
titlepage: true
titlepage-color: "DC143C"
titlepage-text-color: "FFFFFF"
titlepage-rule-color: "360049"
titlepage-rule-height: 2
book: true
classoption: oneside
code-block-font-size: \scriptsize
---
# Offensive-Security OSEP Exam Documentation

The Offensive Security OSEP exam documentation contains all efforts that were conducted in order to pass the Offensive Security Experienced Penetration Tester exam.
This report will be graded from a standpoint of correctness and fullness to all aspects of the exam.
The purpose of this report is to ensure that the student has the technical knowledge required to pass the qualifications for the Offensive Security Experienced Penetration Tester certification.

## Objective

The objective of this assessment is to perform an external penetration test against the Offensive Security Exam network.
The student is tasked with following methodical approach in obtaining access to the objective goals.
This test should simulate an actual penetration test and how you would start from beginning to end, including enumeration and post-exploitation.
The exam report is not meant to be a penetration test report, but rather a writeup of the steps taken to locate, enumerate and compromise the network.
Enumeration and post-exploitation actions that lead to subsequent attacks with successful compromises should be included in the report.
An example page has already been created for you at the latter portions of this document that should give you ample information on what is expected to pass this exam.
Use the sample report as a guideline to get you through the reporting.

## Requirements

The student will be required to fill out this exam documentation fully and to include the following sections:

- High level summery of findings, including the depth of compromise.
- Methodology walkthrough and detailed outline of steps taken including enumeration.
- Each finding with included screenshots, walkthrough, sample code or reference.
- Screenshot of any local.txt, proof.txt or secret.txt.

# High-Level Summary

A brief description of the attack chain with machine names, including the depth of compromise should be included here.

## DOMAIN_NETWORK

Server IP Address | Hostname | Compromised | Low-Privilege User | High-Privilege User
------------------|----------|--------------|-------|---------
192.168.X.X    | HOSTNAME   | No | N/A | N/A
192.168.X.X    | HOSTNAME   | Yes | user | root
192.168.X.X    | HOSTNAME   | Yes | N/A | root

The chain of attack followed for getting into the machines from above in the network DOMAIN was as follows:

* 1 -
* 2 -
* 3 -
* 4 -
* N -
* 9 -

## DOMAIN_NETORK_X

### Compromise through VECTOR_X

Briefly description of how the DOMAIN_NETWORK_X was compromised throughout the VECTOR_X.

# Flow of Attack

## DOMAIN_NETWORK

### 192.168.X.X / HOSTNAME - Low & And High Priv. User's

#### Local.txt / Proof.txt

Local.txt

```texinfo
foo
```

Proof.txt

```texinfo
bar
```

#### Pre-Compromise Enumeration Steps

Provide relevant techniques and methods used to perform enumeration prior to initial compromise, the steps taken should be able to be easily followed and reproducible if necessary. Include any reference to public tools, if custom code then reference it in the Appendix, for example "Code for AMSI Bypass in Appendix 4.1".

#### Compromise

Provide a description of exploitation steps to compromise the machine and obtain shell access, the steps taken should be able to be easily followed and reproducible if necessary. Only the steps that ended up working are required. Include any reference to public tools, if custom code then reference it in the Appendix, for example "Code for AMSI Bypass in Appendix 4.1".

\ ![meterpreter reverse shell and flags](img/placeholder-image-300x225.png){ width=70% }

#### Post-Exploitation Enumeration Steps

Provide relevant post-exploitation enumeration steps related to the network or local privilege escalation, the steps taken should be able to be easily followed and reproducible if necessary. Include any reference to public tools, if custom code then reference it in the Appendix, for example "Code for AMSI Bypass in Appendix 4.1".

#### Local Privilege Escalation

Provide a description of exploitation steps to escalate privileges on the machine if applicable, the steps taken should be able to be easily followed and reproducible if necessary. Include any reference to public tools, if custom code then reference it in the Appendix, for example "Code for AMSI Bypass in Appendix 4.1".

\ ![meterpreter reverse shell and flags](img/placeholder-image-300x225.png){ width=70% }

### 192.168.X.X / HOSTNAME - High Priv. User's

#### Proof.txt / Secret.txt

Proof.txt

```texinfo
bar
```

Secret.txt

```texinfo
foobar
```

#### Pre-Compromise Enumeration Steps

Provide relevant techniques and methods used to perform enumeration prior to initial compromise, the steps taken should be able to be easily followed and reproducible if necessary. Include any reference to public tools, if custom code then reference it in the Appendix, for example "Code for AMSI Bypass in Appendix 4.1".

#### Compromise

Provide a description of exploitation steps to compromise the machine and obtain shell access, the steps taken should be able to be easily followed and reproducible if necessary. Only the steps that ended up working are required. Include any reference to public tools, if custom code then reference it in the Appendix, for example "Code for AMSI Bypass in Appendix 4.1".

\ ![meterpreter reverse shell and flags](img/placeholder-image-300x225.png){ width=70% }

#### Post-Exploitation Enumeration Steps

Provide relevant post-exploitation enumeration steps related to the network or local privilege escalation, the steps taken should be able to be easily followed and reproducible if necessary. Include any reference to public tools, if custom code then reference it in the Appendix, for example "Code for AMSI Bypass in Appendix 4.1".

#### Local Privilege Escalation

Local Privilege Escalation doesn't apply as the initial access was already an elevated one.

## DOMAIN_NETWORK_X

### Compromise through VECTOR_X

Detailed explanation of how the DOMAIN_NETWORK_X was obtained throughout the VECTOR_X this section belongs to.

# Additional Items

## Appendix - AMSI Bypass code

## Appendix - Powershell Shellcoderunner

## Appendix - ANOTHER_SHELLCODE_USED Shellcoderunner Code

## Appendix - Proof and Local Contents

Hostname | local.txt Contents | proof.txt Contents
---------------|----------------------------------|---------------------------------
HOSTNAME     | foo | bar
HOSTNAME     | foo | bar

## Appendix - Credentials obtained

### NTLM Hashes

|Username | NTLM Hash | Found in
----------|-----------|------------
Administrator | HASH | HOSTNAME

### Passwords

Found in | Corresponds to | Password
---------|----------------|----------
HOSTNAME|USER BELONGS|`Password123*`

### Credential's files

|Found in|File|Type
---------|----------------|----------
HOSTNAME|FILE FROM WHERE IS IT|Example: SSH Priv. Key

