---
title: "Offensive Security Exploit Developer Exam Report"
author: ["student@youremailaddress.com", "OSID: XXXX"]
date: "2021-03-25"
subject: "Markdown"
keywords: [Markdown, Example]
subtitle: "OSED Exam Report"
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
# Offensive-Security OSED Exam Documentation

The Offensive Security OSED exam documentation contains all efforts that were conducted in order to pass the Offensive Security Exploit Developer exam.
This report will be graded from a standpoint of correctness and fullness to all aspects of the exam.
The purpose of this report is to ensure that the student has the technical knowledge required to pass the qualifications for the Offensive Security Exploit Developer certification.

## Objective

The objective of this exam is to solve three given assignments as described in the control panel.
The student is tasked with following a methodical approach in analyzing and solving the assignments.
The exam report is meant to be a writeup of the steps taken to solve the assignment, including any analysis performed and code written.
An example page has already been created for you at the latter portions of this document that should give you ample information on what is expected to pass this exam.
Use the sample report as a guideline to get you through the reporting, while removing any headlines that are not relevant to a specific assignment.

## Requirements

The student will be required to fill out this exam documentation fully and to include the following sections:

- High-Level summary of assignment solutions.
- Methodology walkthrough and detailed outline of steps taken through analysis and all written code.
- Each finding with included screenshots, walkthrough, sample code or reference.
- Screenshots of proof.txt.

# High-Level Summary

A brief description of the assignments that were solved, including the overall exploitation steps.

# Assignment X

## Proof.txt

Provide the contents of proof.txt.

## Initial Analysis

Provide relevant techniques and methods used to perform enumeration of the application, including network ports, security mitigations etc.
The steps taken should be reproducible and easy to understand.
Include any custom code or references to public tools.

## Application Analysis

Provide a description of the analysis performed against the application, this includes both dynamic and static analysis.

The analysis should include any reverse engineering performed to understand network protocols or file formats as well as how the application may be triggered to dispatch available commands.

## Vulnerability Discovery

Provide relevant analysis steps to locate vulnerabilities inside the application, this includes both results from static analysis and dynamic analysis.

As part of the documentation, proof of concept Python3 code must be created and explained that triggers the vulnerabilities.
This includes both ASLR bypass and memory corruption vulnerabilities.

Only the steps that ended up working are required.

## Exploit Creation

Provide a description of steps to create the exploit, this includes how to combine vulnerabilities, how to bypass DEP and how to write any custom shellcode.
At the end of this section the full exploit code should be developed while an explanation of each step should be performed.

## Screenshots

The exam control panel contains a section available to submit your proof files.
The contents of the proof.txt files obtained from your exam machines must be submitted in the control panel before your exam has ended.
Note that the control panel will not indicate whether the submitted proof is correct or not.

Each proof.txt found must be shown in a screenshot that includes the contents of the file, as well as the IP address of the target by using ipconfig.
