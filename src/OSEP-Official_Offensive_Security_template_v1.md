---
title: "Offensive Security Experienced Penetration Tester Exam Report"
author: ["student@youremailaddress.com", "OSID: XXXX"]
date: "2021-03-25"
subject: "Markdown"
keywords: [Markdown, Example]
subtitle: "OSEP Exam Report"
lang: "en"
titlepage: true
titlepage-color: "DC143C"
titlepage-text-color: "FFFFFF"
titlepage-rule-color: "FFFFFF"
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

# 192.168.XX.XX / Hostname

## Local.txt / Proof.txt / Secret.txt

Provide the contents of local.txt, proof.txt or secret.txt

## Pre-Compromise Enumeration Steps

Provide relevant techniques and methods used to perform enumeration prior to initial compromise, the steps taken should be able to be easily followed and reproducible if necessary.
Include any custom code or references to public tools.

## Compromise

Provide a description of exploitation steps to compromise the machine and obtain shell access, the steps taken should be able to be easily followed and reproducible if necessary.
Only the steps that ended up working are required.
Include any custom code or references to public tools.

## Post-Exploitation Enumeration Steps

Provide relevant post-exploitation enumeration steps related to the network or local privilege escalation, the steps taken should be able to be easily followed and reproducible if necessary.
Include any custom code or references to public tools.

## Local Privilege Escalation

Provide a description of exploitation steps to escalate privileges on the machine if applicable, the steps taken should be able to be easily followed and reproducible if necessary.
Include any custom code or references to public tools.

## Screenshots

The exam control panel contains a section available to submit your proof files.
The contents of the local.txt, proof.txt and secret.txt files obtained from your exam machines must be submitted in the control panel before your exam has ended.
Note that the control panel will not indicate whether the submitted proof is correct or not.

Each local.txt, proof.txt and secret.txt found must be shown in a screenshot that includes the contents of the file, as well as the IP address of the target by using ipconfig, ifconfig or ip addr.

