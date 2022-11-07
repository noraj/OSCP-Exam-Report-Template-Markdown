---
title: "Offensive Security Defense Analyst Exam Report"
author: ["student@youremailaddress.com", "OSID: XXXX"]
date: "2022-11-08"
subject: "Markdown"
keywords: [Markdown, Example]
subtitle: "OSDA Exam Report"
lang: "en"
titlepage: true
titlepage-color: "FFEF96"
titlepage-text-color: "50394C"
titlepage-rule-color: "50394C"
titlepage-rule-height: 2
book: true
classoption: oneside
code-block-font-size: \scriptsize
---
# Offensive Security OSDA Exam Report

## Introduction

The Offensive Security Exam report contains all efforts that were conducted in order to pass the Offensive Security certification test.
This report should contain all items that were used to pass the exam and it will be graded from a standpoint of correctness and fullness to all aspects of the exam.
The purpose of this report is to ensure that the student has a full understanding of security detection methodologies as well as the technical knowledge to pass the qualifications for the Offensive Security Defense Analyst.

## Objective

The objective of this assessment is to perform detections and analysis on the simulated exam network in order to determine which attacker actions took place in each of the 10 phases.

An example page has already been created for you at the latter portions of this document that should demonstrate the amount of information and detail that is expected in the exam report.
Use the sample report as a guideline to get you through the reporting.

## Requirements

The student will be required to fill out this exam report fully and to include the following sections:

1. Overall High-Level Summary of level of compromise
2. Detailed walkthrough of attacker actions in each phase
3. Each finding with included screenshots, explanations, event / log entries, and KQL queries if applicable.

# High-Level Summary

This report details and documents the attacks observed against the Offensive Security OSDA exam network.

The attacker organization started by performing a brute force against an internet accessible RDP server called APPSRV02 and obtained administrative access. This led to a complete compromise of the server.

Next the attacker performed lateral movement to the internal server APPSRV02 by reusing stolen credentials from APPSRV02, this also led to a complete compromise of APPSRV03.

# Attacker Phases

## Phase 1

### RDP Brute Force

The initial indicator of an attack happening was the triggering of a pre-defined threshold rule called "Possible RDP brute force" as shown below.

![ImgPlaceholder](img/placeholder-image-300x225.png)

By looking at how the rule was defined, it is triggered by more than 100 instances of event ID 4625, which is a failed logon. This could align with a brute force attack where the attacker makes use of a user and/or password list.

When we inspect some of the events that triggered the alert, as shown below, we notice that the server reporting the events is APPSRV02.

![ImgPlaceholder](img/placeholder-image-300x225.png)

Given that an attacker may have attempted to brute force the server, we should search for a subsequent successful log on event to APPSRV02 to determine if they obtained access.

We do this with the following KQL query:

```default
event.code : "4624" and NOT user.name : SYSTEM and NOT user.name : DWM-2
```

From this query we find the following event entry:

![ImgPlaceholder](img/placeholder-image-300x225.png)

This shows that the user Peter did a successful logon to APPSRV02 shortly after the suspected brute force attack.
The source IP of the logon event was 192.168.67.69 which means its not a local logon, but remotely.

At this point we have a strong suspicion that the account with the username Peter was compromised and a malicious actor obtained access to APPSRV02 coming from the IP address 192.168.67.69.
We should escalate this to an incident and contact the user to verify whether this was a legitimate logon.

### Persistence

After suspicion of a compromise, additional investigation should be performed.
One area is looking for persistence and a common way attackers employ is through the registry.

To try and determine if this happed, we can use the KQL query:

```default
process.name : "reg.exe"
```

As a result, we find the following event:

![ImgPlaceholder](img/placeholder-image-300x225.png)

This shows that a registry change was performed. An entry for the Run key was added.
The Run registry key is used when a user logs on to the computer and thus is often used for persistence.

In particular we notice that the file `C:\Windows\System32\update.exe` will be executed when a user logs on to APPSRV02.

We should escalate this to investigate what the file update.exe is.

### Summary

In this phase we have strong suspicions that a malicious actor performed a brute force attack against APPSRV02 and managed to compromise the user account with the username "Peter".
Additionally, we suspect that persistence was set up through a Run key in the registry to execute the file `C:\Windows\System32\update.exe`.

## Phase 2

## Phase 3

## Phase 4

## Phase 5

## Phase 6

## Phase 7

## Phase 8

## Phase 9

## Phase 10
