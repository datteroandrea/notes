# Banking for Software Engineers (Treasury Focus)

## Index

- [1. Banking Fundamentals](#1-banking-fundamentals)
  - [1.1 Role and Business Model of Banks](#11-role-and-business-model-of-banks)
  - [1.2 Bank Balance Sheet Anatomy](#12-bank-balance-sheet-anatomy)
  - [1.3 Central Banks and the Monetary System](#13-central-banks-and-the-monetary-system)
  - [1.4 Core Banking Concepts for Engineers](#14-core-banking-concepts-for-engineers)
- [2. Payments, Clearing and Settlement](#2-payments-clearing-and-settlement)
  - [2.1 Payment System Foundations](#21-payment-system-foundations)
  - [2.2 Major Payment Rails](#22-major-payment-rails)
  - [2.3 Securities Settlement](#23-securities-settlement)
- [3. Financial Markets and Instruments](#3-financial-markets-and-instruments)
  - [3.1 Time Value of Money](#31-time-value-of-money)
  - [3.2 Money Market Instruments](#32-money-market-instruments)
  - [3.3 Fixed Income Securities](#33-fixed-income-securities)
  - [3.4 Foreign Exchange](#34-foreign-exchange)
  - [3.5 Derivatives Used in Treasury](#35-derivatives-used-in-treasury)
- [4. The Treasury Function](#4-the-treasury-function)
  - [4.1 Treasury Organization and Mandate](#41-treasury-organization-and-mandate)
  - [4.2 Treasury Desks and Activities](#42-treasury-desks-and-activities)
  - [4.3 Trade Lifecycle](#43-trade-lifecycle)
- [5. Liquidity Management](#5-liquidity-management)
  - [5.1 Liquidity Risk Concepts](#51-liquidity-risk-concepts)
  - [5.2 Cash Flow Forecasting and Positioning](#52-cash-flow-forecasting-and-positioning)
  - [5.3 Intraday Liquidity](#53-intraday-liquidity)
  - [5.4 Liquidity Buffers and Collateral](#54-liquidity-buffers-and-collateral)
- [6. Asset-Liability Management and Interest Rate Risk](#6-asset-liability-management-and-interest-rate-risk)
  - [6.1 ALM Foundations](#61-alm-foundations)
  - [6.2 IRRBB Measurement](#62-irrbb-measurement)
  - [6.3 Hedging the Banking Book](#63-hedging-the-banking-book)
  - [6.4 Funds Transfer Pricing (FTP)](#64-funds-transfer-pricing-ftp)
- [7. Funding and Capital Management](#7-funding-and-capital-management)
  - [7.1 Funding Strategy](#71-funding-strategy)
  - [7.2 Capital Fundamentals](#72-capital-fundamentals)
  - [7.3 Resolution and Loss Absorption](#73-resolution-and-loss-absorption)
- [8. Market and Counterparty Risk in Treasury](#8-market-and-counterparty-risk-in-treasury)
  - [8.1 Market Risk Measurement](#81-market-risk-measurement)
  - [8.2 FX Risk Management](#82-fx-risk-management)
  - [8.3 Counterparty Credit Risk](#83-counterparty-credit-risk)
  - [8.4 Limits Framework](#84-limits-framework)
- [9. Regulatory Framework](#9-regulatory-framework)
  - [9.1 Basel Accords](#91-basel-accords)
  - [9.2 Liquidity Regulation](#92-liquidity-regulation)
  - [9.3 Regulatory Reporting](#93-regulatory-reporting)
  - [9.4 Conduct and Compliance](#94-conduct-and-compliance)
- [10. Corporate Treasury and Cash Management Services](#10-corporate-treasury-and-cash-management-services)
  - [10.1 Corporate Treasury Operations](#101-corporate-treasury-operations)
  - [10.2 Bank Cash Management Products](#102-bank-cash-management-products)
  - [10.3 Trade Finance Basics](#103-trade-finance-basics)
- [11. Quantitative Building Blocks for Treasury Software](#11-quantitative-building-blocks-for-treasury-software)
  - [11.1 Date and Calendar Conventions](#111-date-and-calendar-conventions)
  - [11.2 Yield Curve Construction](#112-yield-curve-construction)
  - [11.3 Pricing and Valuation](#113-pricing-and-valuation)
  - [11.4 Numerical Correctness](#114-numerical-correctness)
- [12. Messaging Standards and Integration](#12-messaging-standards-and-integration)
  - [12.1 SWIFT Network](#121-swift-network)
  - [12.2 ISO 20022](#122-iso-20022)
  - [12.3 Trading and Market Data Protocols](#123-trading-and-market-data-protocols)
  - [12.4 Integration Patterns](#124-integration-patterns)
- [13. Treasury Systems Architecture](#13-treasury-systems-architecture)
  - [13.1 System Landscape](#131-system-landscape)
  - [13.2 Data Architecture](#132-data-architecture)
  - [13.3 Processing Models](#133-processing-models)
  - [13.4 Reconciliation and Controls](#134-reconciliation-and-controls)
- [14. Accounting and Financial Reporting for Treasury](#14-accounting-and-financial-reporting-for-treasury)
  - [14.1 Treasury Accounting](#141-treasury-accounting)
  - [14.2 Hedge Accounting Implementation](#142-hedge-accounting-implementation)
  - [14.3 Management Reporting](#143-management-reporting)
- [15. Engineering Reliable and Secure Treasury Software](#15-engineering-reliable-and-secure-treasury-software)
  - [15.1 Correctness and Testing](#151-correctness-and-testing)
  - [15.2 Resilience and Operations](#152-resilience-and-operations)
  - [15.3 Security](#153-security)
  - [15.4 Change Management in Regulated Banks](#154-change-management-in-regulated-banks)
- [16. Advanced Topics and Emerging Trends](#16-advanced-topics-and-emerging-trends)
  - [16.1 Stress Testing and Scenario Analysis](#161-stress-testing-and-scenario-analysis)
  - [16.2 Real-Time Treasury](#162-real-time-treasury)
  - [16.3 Digital Assets and Tokenization](#163-digital-assets-and-tokenization)
  - [16.4 Case Studies](#164-case-studies)

---

<a id="1-banking-fundamentals"></a>
## 1. Banking Fundamentals

<a id="11-role-and-business-model-of-banks"></a>
### 1.1 Role and Business Model of Banks

#### Financial Intermediation

#### Maturity Transformation

#### Net Interest Margin

#### Fee-Based Income

#### Retail vs Commercial vs Investment Banking

#### Universal Banks and Bank Holding Companies

<a id="12-bank-balance-sheet-anatomy"></a>
### 1.2 Bank Balance Sheet Anatomy

#### Assets: Loans, Securities, Reserves

#### Liabilities: Deposits, Borrowings, Debt Issuance

#### Equity and Retained Earnings

#### Off-Balance-Sheet Exposures

#### Reading a Bank's Annual Report

<a id="13-central-banks-and-the-monetary-system"></a>
### 1.3 Central Banks and the Monetary System

#### Central Bank Mandates

#### Reserve Requirements

#### Policy Rates and Corridors

#### Open Market Operations

#### Quantitative Easing and Tightening

#### Money Creation by Commercial Banks

<a id="14-core-banking-concepts-for-engineers"></a>
### 1.4 Core Banking Concepts for Engineers

#### Accounts and Ledgers

#### Double-Entry Bookkeeping

#### Debits, Credits and Balances

#### Value Date vs Booking Date

#### Business Days and Cut-Off Times

#### Chart of Accounts and General Ledger

---

<a id="2-payments-clearing-and-settlement"></a>
## 2. Payments, Clearing and Settlement

<a id="21-payment-system-foundations"></a>
### 2.1 Payment System Foundations

#### Clearing vs Settlement

#### Gross vs Net Settlement

#### Correspondent Banking

#### Nostro and Vostro Accounts

#### Settlement Finality

#### Payment Lifecycle

<a id="22-major-payment-rails"></a>
### 2.2 Major Payment Rails

#### RTGS Systems (TARGET2/T2, Fedwire, CHAPS)

#### ACH and SEPA Credit Transfers

#### Instant Payments (SCT Inst, FedNow, RTP)

#### Card Schemes Overview

#### CLS for FX Settlement

#### Cross-Border Payments and SWIFT gpi

<a id="23-securities-settlement"></a>
### 2.3 Securities Settlement

#### Central Securities Depositories

#### Delivery vs Payment (DvP)

#### Settlement Cycles (T+1, T+2)

#### Custody and Sub-Custody

#### Settlement Fails and Penalties

#### Central Counterparties (CCPs)

---

<a id="3-financial-markets-and-instruments"></a>
## 3. Financial Markets and Instruments

<a id="31-time-value-of-money"></a>
### 3.1 Time Value of Money

#### Simple vs Compound Interest

#### Present and Future Value

#### Discount Factors

#### Annuities and Amortization

#### Effective vs Nominal Rates

#### Continuous Compounding

<a id="32-money-market-instruments"></a>
### 3.2 Money Market Instruments

#### Interbank Deposits

#### Repo and Reverse Repo

#### Commercial Paper and Certificates of Deposit

#### Treasury Bills

#### Overnight Index Rates (SOFR, €STR, SONIA)

#### IBOR Transition

<a id="33-fixed-income-securities"></a>
### 3.3 Fixed Income Securities

#### Bond Structure and Cash Flows

#### Yield to Maturity

#### Clean vs Dirty Price and Accrued Interest

#### Duration and Convexity

#### Floating Rate Notes

#### Covered Bonds and Securitizations

<a id="34-foreign-exchange"></a>
### 3.4 Foreign Exchange

#### Spot FX and Quote Conventions

#### FX Forwards and Forward Points

#### FX Swaps

#### Covered Interest Rate Parity

#### Non-Deliverable Forwards

#### Cross Rates

<a id="35-derivatives-used-in-treasury"></a>
### 3.5 Derivatives Used in Treasury

#### Interest Rate Swaps

#### Overnight Index Swaps

#### Cross-Currency Swaps

#### Futures and Forward Rate Agreements

#### Caps, Floors and Swaptions

#### Collateral and CSA Agreements

---

<a id="4-the-treasury-function"></a>
## 4. The Treasury Function

<a id="41-treasury-organization-and-mandate"></a>
### 4.1 Treasury Organization and Mandate

#### Bank Treasury vs Corporate Treasury

#### Front, Middle and Back Office

#### ALCO (Asset-Liability Committee)

#### Treasury as Profit Center vs Cost Center

#### Risk Appetite Framework

#### Governance and Segregation of Duties

<a id="42-treasury-desks-and-activities"></a>
### 4.2 Treasury Desks and Activities

#### Money Markets Desk

#### FX Desk

#### Investment Portfolio (Liquidity Buffer)

#### Funding and Issuance Desk

#### Collateral Management Desk

#### Hedging Desk

<a id="43-trade-lifecycle"></a>
### 4.3 Trade Lifecycle

#### Pre-Trade Checks and Limits

#### Trade Capture

#### Confirmation and Affirmation

#### Settlement Instructions (SSIs)

#### Lifecycle Events (Resets, Rolls, Maturities)

#### Trade Amendments and Cancellations

---

<a id="5-liquidity-management"></a>
## 5. Liquidity Management

<a id="51-liquidity-risk-concepts"></a>
### 5.1 Liquidity Risk Concepts

#### Funding Liquidity vs Market Liquidity

#### Sources of Liquidity Risk

#### Behavioral Cash Flows

#### Deposit Stickiness and Run-Off

#### Contingent Liquidity Exposures

#### Historical Bank Runs and Lessons

<a id="52-cash-flow-forecasting-and-positioning"></a>
### 5.2 Cash Flow Forecasting and Positioning

#### Cash Position Management

#### Contractual Maturity Ladders

#### Liquidity Gap Analysis

#### Survival Horizon

#### Forecast Accuracy and Backtesting

<a id="53-intraday-liquidity"></a>
### 5.3 Intraday Liquidity

#### Intraday Liquidity Monitoring

#### Payment Throughput and Queuing

#### Intraday Credit Facilities

#### Critical Payment Prioritization

#### Real-Time Balance Tracking

<a id="54-liquidity-buffers-and-collateral"></a>
### 5.4 Liquidity Buffers and Collateral

#### High-Quality Liquid Assets (HQLA)

#### Haircuts and Eligibility

#### Collateral Optimization

#### Encumbrance Monitoring

#### Central Bank Facilities and Lender of Last Resort

#### Contingency Funding Plans

---

<a id="6-asset-liability-management-and-interest-rate-risk"></a>
## 6. Asset-Liability Management and Interest Rate Risk

<a id="61-alm-foundations"></a>
### 6.1 ALM Foundations

#### Objectives of ALM

#### Repricing Gap Analysis

#### Earnings vs Economic Value Perspective

#### Basis Risk

#### Optionality Risk in Banking Book

#### Yield Curve Risk

<a id="62-irrbb-measurement"></a>
### 6.2 IRRBB Measurement

#### Net Interest Income (NII) Sensitivity

#### Economic Value of Equity (EVE)

#### Standard Rate Shock Scenarios

#### Non-Maturity Deposit Modeling

#### Prepayment Modeling

#### Static vs Dynamic Balance Sheet Simulation

<a id="63-hedging-the-banking-book"></a>
### 6.3 Hedging the Banking Book

#### Hedging Strategies with Swaps

#### Macro vs Micro Hedging

#### Hedge Effectiveness Testing

#### Replicating Portfolios

#### Hedge Accounting Overview

<a id="64-funds-transfer-pricing-ftp"></a>
### 6.4 Funds Transfer Pricing (FTP)

#### Purpose of FTP

#### Matched-Maturity FTP

#### Liquidity Premiums

#### FTP Curve Construction

#### Allocating Margins to Business Lines

#### FTP Systems Design

---

<a id="7-funding-and-capital-management"></a>
## 7. Funding and Capital Management

<a id="71-funding-strategy"></a>
### 7.1 Funding Strategy

#### Funding Mix and Diversification

#### Wholesale vs Retail Funding

#### Debt Issuance Programs (EMTN)

#### Credit Ratings and Funding Costs

#### Intragroup Funding

#### Funding Plans and Budgeting

<a id="72-capital-fundamentals"></a>
### 7.2 Capital Fundamentals

#### Regulatory vs Economic Capital

#### CET1, AT1 and Tier 2

#### Risk-Weighted Assets (RWA)

#### Leverage Ratio

#### Capital Buffers

#### Capital Planning and ICAAP

<a id="73-resolution-and-loss-absorption"></a>
### 7.3 Resolution and Loss Absorption

#### Bail-In Mechanics

#### MREL and TLAC

#### Recovery and Resolution Plans

#### Deposit Insurance Schemes

---

<a id="8-market-and-counterparty-risk-in-treasury"></a>
## 8. Market and Counterparty Risk in Treasury

<a id="81-market-risk-measurement"></a>
### 8.1 Market Risk Measurement

#### Sensitivities and Greeks

#### DV01 and PV01

#### Value at Risk (VaR)

#### Expected Shortfall

#### Historical vs Monte Carlo Simulation

#### P&L Attribution

<a id="82-fx-risk-management"></a>
### 8.2 FX Risk Management

#### Transactional vs Translational FX Risk

#### Structural FX Positions

#### FX Hedging Programs

#### Open Currency Position Limits

<a id="83-counterparty-credit-risk"></a>
### 8.3 Counterparty Credit Risk

#### Exposure Measures (Current, Potential, Expected)

#### Netting Agreements (ISDA)

#### Margining (Initial and Variation)

#### Credit Valuation Adjustment (CVA)

#### Counterparty Limits and Utilization

<a id="84-limits-framework"></a>
### 8.4 Limits Framework

#### Limit Hierarchies

#### Real-Time vs End-of-Day Limit Checks

#### Breach Detection and Escalation

#### Limit Reservation and Release

---

<a id="9-regulatory-framework"></a>
## 9. Regulatory Framework

<a id="91-basel-accords"></a>
### 9.1 Basel Accords

#### Evolution from Basel I to Basel III

#### Basel III Endgame / Basel IV

#### Pillar 1, 2 and 3

#### Regional Implementations (CRR/CRD, US Rules)

<a id="92-liquidity-regulation"></a>
### 9.2 Liquidity Regulation

#### Liquidity Coverage Ratio (LCR)

#### Net Stable Funding Ratio (NSFR)

#### Additional Liquidity Monitoring Metrics (ALMM)

#### ILAAP

#### BCBS 248 Intraday Monitoring

<a id="93-regulatory-reporting"></a>
### 9.3 Regulatory Reporting

#### COREP and FINREP

#### FR 2052a and US Reporting

#### Reporting Taxonomies (XBRL, DPM)

#### Data Lineage Requirements

#### BCBS 239 Risk Data Aggregation

<a id="94-conduct-and-compliance"></a>
### 9.4 Conduct and Compliance

#### AML and KYC Basics

#### Sanctions Screening

#### Market Abuse Regulation

#### Trade Reporting (EMIR, Dodd-Frank)

#### Record-Keeping Obligations

---

<a id="10-corporate-treasury-and-cash-management-services"></a>
## 10. Corporate Treasury and Cash Management Services

<a id="101-corporate-treasury-operations"></a>
### 10.1 Corporate Treasury Operations

#### Working Capital Management

#### Cash Visibility

#### Payment Factories

#### In-House Banks

#### Intercompany Netting

<a id="102-bank-cash-management-products"></a>
### 10.2 Bank Cash Management Products

#### Physical Cash Pooling (Zero Balancing)

#### Notional Pooling

#### Virtual Accounts

#### Sweeps

#### Liquidity Reporting Services

<a id="103-trade-finance-basics"></a>
### 10.3 Trade Finance Basics

#### Letters of Credit

#### Bank Guarantees

#### Supply Chain Finance

#### Documentary Collections

---

<a id="11-quantitative-building-blocks-for-treasury-software"></a>
## 11. Quantitative Building Blocks for Treasury Software

<a id="111-date-and-calendar-conventions"></a>
### 11.1 Date and Calendar Conventions

#### Day Count Conventions (ACT/360, 30/360, ACT/ACT)

#### Business Day Conventions (Following, Modified Following)

#### Holiday Calendars and Joint Calendars

#### Schedule Generation

#### Stub Periods

#### Spot Lag and Settlement Dates

<a id="112-yield-curve-construction"></a>
### 11.2 Yield Curve Construction

#### Curve Instruments Selection

#### Bootstrapping

#### Interpolation Methods

#### Multi-Curve Framework

#### OIS Discounting

#### Curve Versioning and Snapshots

<a id="113-pricing-and-valuation"></a>
### 11.3 Pricing and Valuation

#### Cash Flow Projection

#### Discounting Cash Flows

#### Pricing Swaps and FRAs

#### FX Forward Pricing

#### Mark-to-Market vs Mark-to-Model

#### Using QuantLib and Similar Libraries

<a id="114-numerical-correctness"></a>
### 11.4 Numerical Correctness

#### Decimal vs Floating Point

#### Rounding Rules and Precision

#### Currency Minor Units (ISO 4217)

#### Money Type Design

#### Aggregation Error Accumulation

---

<a id="12-messaging-standards-and-integration"></a>
## 12. Messaging Standards and Integration

<a id="121-swift-network"></a>
### 12.1 SWIFT Network

#### SWIFT Architecture and BICs

#### MT Message Categories (MT103, MT202, MT300, MT940)

#### SWIFT Alliance Interfaces

#### Customer Security Programme (CSP)

<a id="122-iso-20022"></a>
### 12.2 ISO 20022

#### Message Model and Business Domains

#### pacs, pain and camt Messages

#### MT to MX Migration

#### Structured Remittance and Address Data

#### Schema Validation and Usage Guidelines

<a id="123-trading-and-market-data-protocols"></a>
### 12.3 Trading and Market Data Protocols

#### FIX Protocol Basics

#### Market Data Feeds (Bloomberg, Refinitiv)

#### Electronic Trading Platforms

#### FpML for Derivatives

<a id="124-integration-patterns"></a>
### 12.4 Integration Patterns

#### File-Based Integration (SFTP, Batch)

#### Message Queues and Event Streaming

#### Open Banking and Bank APIs

#### Host-to-Host Connectivity

#### Idempotency and Exactly-Once Processing

#### Duplicate Detection

---

<a id="13-treasury-systems-architecture"></a>
## 13. Treasury Systems Architecture

<a id="131-system-landscape"></a>
### 13.1 System Landscape

#### Treasury Management Systems (Murex, Calypso, FIS, Kyriba)

#### Core Banking Systems

#### ALM and Liquidity Engines

#### Risk Engines

#### Build vs Buy Decisions

<a id="132-data-architecture"></a>
### 13.2 Data Architecture

#### Trade and Position Data Models

#### Reference and Static Data Management

#### Market Data Management

#### Golden Source and Data Ownership

#### Bitemporal Data Modeling

#### Event Sourcing for Ledgers

<a id="133-processing-models"></a>
### 13.3 Processing Models

#### End-of-Day Batch Processing

#### Intraday and Real-Time Processing

#### Position Keeping Engines

#### Calculation Grids and Distributed Compute

#### Scenario and Stress Engines

<a id="134-reconciliation-and-controls"></a>
### 13.4 Reconciliation and Controls

#### Cash and Nostro Reconciliation

#### Position and Trade Reconciliation

#### Matching Algorithms

#### Break Management Workflows

#### Four-Eyes Principle and Maker-Checker

#### Audit Trails

---

<a id="14-accounting-and-financial-reporting-for-treasury"></a>
## 14. Accounting and Financial Reporting for Treasury

<a id="141-treasury-accounting"></a>
### 14.1 Treasury Accounting

#### IFRS 9 Classification and Measurement

#### Amortized Cost and Effective Interest Rate

#### Fair Value Hierarchy

#### Accounting Events and Postings

#### Subledger to General Ledger Flow

<a id="142-hedge-accounting-implementation"></a>
### 14.2 Hedge Accounting Implementation

#### Hedge Designation and Documentation

#### Fair Value vs Cash Flow Hedges

#### Effectiveness Calculations

#### Accounting Entries for Hedges

<a id="143-management-reporting"></a>
### 14.3 Management Reporting

#### Liquidity and ALM Dashboards

#### P&L Explain Reports

#### ALCO Reporting Packs

#### Data Quality Controls in Reporting

---

<a id="15-engineering-reliable-and-secure-treasury-software"></a>
## 15. Engineering Reliable and Secure Treasury Software

<a id="151-correctness-and-testing"></a>
### 15.1 Correctness and Testing

#### Domain-Driven Design for Financial Systems

#### Golden Test Datasets

#### Property-Based Testing for Calculations

#### Regression Testing Against Vendor Systems

#### Parallel Runs and Shadow Mode

<a id="152-resilience-and-operations"></a>
### 15.2 Resilience and Operations

#### Operational Resilience Requirements (DORA)

#### High Availability for Payment Systems

#### Disaster Recovery and RTO/RPO

#### Cut-Off Driven Incident Management

#### Observability for Financial Flows

<a id="153-security"></a>
### 15.3 Security

#### Access Control and Entitlements

#### Payment Fraud Prevention

#### Cryptographic Signing of Payment Files

#### HSMs and Key Management

#### Secure SDLC in Regulated Environments

<a id="154-change-management-in-regulated-banks"></a>
### 15.4 Change Management in Regulated Banks

#### Model Risk Management (SR 11-7)

#### Change Approval Boards

#### Release Freezes Around Period Ends

#### Vendor and Third-Party Risk

#### Documentation for Auditors and Regulators

---

<a id="16-advanced-topics-and-emerging-trends"></a>
## 16. Advanced Topics and Emerging Trends

<a id="161-stress-testing-and-scenario-analysis"></a>
### 16.1 Stress Testing and Scenario Analysis

#### Regulatory Stress Tests (EBA, CCAR)

#### Reverse Stress Testing

#### Combined Liquidity and Solvency Stress

#### Scenario Design and Calibration

<a id="162-real-time-treasury"></a>
### 16.2 Real-Time Treasury

#### Real-Time Liquidity Positions

#### Streaming Risk Analytics

#### Predictive Cash Forecasting with Machine Learning

#### Automated Funding Decisions

<a id="163-digital-assets-and-tokenization"></a>
### 16.3 Digital Assets and Tokenization

#### Central Bank Digital Currencies (CBDCs)

#### Tokenized Deposits

#### Stablecoins and Treasury Implications

#### Distributed Ledger Settlement

#### Programmable Money

<a id="164-case-studies"></a>
### 16.4 Case Studies

#### Northern Rock (2007)

#### Lehman Brothers Liquidity Collapse

#### Silicon Valley Bank (2023)

#### Credit Suisse (2023)

#### Lessons for Treasury System Design
