# GitLab CI/CD

## Index

- [1. Foundations of CI/CD and GitLab](#1-foundations-of-cicd-and-gitlab)
  - [1.1 CI/CD Core Concepts](#11-cicd-core-concepts)
  - [1.2 GitLab Platform Overview](#12-gitlab-platform-overview)
  - [1.3 Getting Started with GitLab CI/CD](#13-getting-started-with-gitlab-cicd)
- [2. Pipeline Configuration Fundamentals](#2-pipeline-configuration-fundamentals)
  - [2.1 YAML Essentials for GitLab CI](#21-yaml-essentials-for-gitlab-ci)
  - [2.2 Jobs](#22-jobs)
  - [2.3 Stages](#23-stages)
  - [2.4 Global Defaults and Inheritance](#24-global-defaults-and-inheritance)
- [3. Pipeline Architecture](#3-pipeline-architecture)
  - [3.1 Pipeline Types](#31-pipeline-types)
  - [3.2 Directed Acyclic Graph Pipelines](#32-directed-acyclic-graph-pipelines)
  - [3.3 Parent-Child Pipelines](#33-parent-child-pipelines)
  - [3.4 Multi-Project Pipelines](#34-multi-project-pipelines)
  - [3.5 Triggering Pipelines](#35-triggering-pipelines)
- [4. Job Control and Execution Flow](#4-job-control-and-execution-flow)
  - [4.1 Rules](#41-rules)
  - [4.2 Legacy only/except](#42-legacy-onlyexcept)
  - [4.3 Job Execution Behavior](#43-job-execution-behavior)
  - [4.4 Workflow Control](#44-workflow-control)
  - [4.5 Parallelism and Concurrency](#45-parallelism-and-concurrency)
- [5. Variables and Secrets](#5-variables-and-secrets)
  - [5.1 CI/CD Variables Basics](#51-cicd-variables-basics)
  - [5.2 Variable Types and Protection](#52-variable-types-and-protection)
  - [5.3 Dynamic Variables](#53-dynamic-variables)
  - [5.4 Secrets Management](#54-secrets-management)
- [6. GitLab Runners](#6-gitlab-runners)
  - [6.1 Runner Architecture](#61-runner-architecture)
  - [6.2 Executors](#62-executors)
  - [6.3 Runner Configuration](#63-runner-configuration)
  - [6.4 Autoscaling and Fleet Management](#64-autoscaling-and-fleet-management)
- [7. Docker and Container Workflows](#7-docker-and-container-workflows)
  - [7.1 Using Container Images in Jobs](#71-using-container-images-in-jobs)
  - [7.2 Services](#72-services)
  - [7.3 Building Container Images](#73-building-container-images)
  - [7.4 GitLab Container Registry](#74-gitlab-container-registry)
- [8. Artifacts, Caching and Releases](#8-artifacts-caching-and-releases)
  - [8.1 Job Artifacts](#81-job-artifacts)
  - [8.2 Caching](#82-caching)
  - [8.3 Package Registry](#83-package-registry)
  - [8.4 Releases](#84-releases)
- [9. Reusable and Modular Configuration](#9-reusable-and-modular-configuration)
  - [9.1 Including External Configuration](#91-including-external-configuration)
  - [9.2 Configuration Reuse Patterns](#92-configuration-reuse-patterns)
  - [9.3 CI/CD Components and Catalog](#93-cicd-components-and-catalog)
  - [9.4 Built-in Templates](#94-built-in-templates)
- [10. Testing and Code Quality](#10-testing-and-code-quality)
  - [10.1 Test Reporting](#101-test-reporting)
  - [10.2 Code Coverage](#102-code-coverage)
  - [10.3 Quality Analysis](#103-quality-analysis)
- [11. Security and Compliance (DevSecOps)](#11-security-and-compliance-devsecops)
  - [11.1 Application Security Testing](#111-application-security-testing)
  - [11.2 Vulnerability Management](#112-vulnerability-management)
  - [11.3 Security Policies and Compliance](#113-security-policies-and-compliance)
  - [11.4 Pipeline Security Hardening](#114-pipeline-security-hardening)
- [12. Deployment and Environments](#12-deployment-and-environments)
  - [12.1 Environments](#121-environments)
  - [12.2 Review Apps](#122-review-apps)
  - [12.3 Deployment Strategies](#123-deployment-strategies)
  - [12.4 Deployment Targets](#124-deployment-targets)
  - [12.5 GitOps and Infrastructure as Code](#125-gitops-and-infrastructure-as-code)
  - [12.6 Auto DevOps](#126-auto-devops)
- [13. Pipeline Optimization](#13-pipeline-optimization)
  - [13.1 Speed and Efficiency](#131-speed-and-efficiency)
  - [13.2 Cost and Resource Management](#132-cost-and-resource-management)
  - [13.3 Monorepo Strategies](#133-monorepo-strategies)
- [14. Monitoring, Debugging and Troubleshooting](#14-monitoring-debugging-and-troubleshooting)
  - [14.1 Debugging Pipelines](#141-debugging-pipelines)
  - [14.2 Observability and Metrics](#142-observability-and-metrics)
  - [14.3 Notifications and Integrations](#143-notifications-and-integrations)
- [15. Administration, Automation and Migration](#15-administration-automation-and-migration)
  - [15.1 Instance-Level CI/CD Administration](#151-instance-level-cicd-administration)
  - [15.2 Governance at Scale](#152-governance-at-scale)
  - [15.3 Programmatic Pipeline Management](#153-programmatic-pipeline-management)
  - [15.4 Migrating to GitLab CI/CD](#154-migrating-to-gitlab-cicd)

---

<a id="1-foundations-of-cicd-and-gitlab"></a>
## 1. Foundations of CI/CD and GitLab

<a id="11-cicd-core-concepts"></a>
### 1.1 CI/CD Core Concepts

#### Continuous Integration

#### Continuous Delivery vs Continuous Deployment

#### Pipeline-Driven Development

#### The DevOps Lifecycle

#### Benefits and Trade-offs of CI/CD

<a id="12-gitlab-platform-overview"></a>
### 1.2 GitLab Platform Overview

#### GitLab.com vs Self-Managed vs Dedicated

#### Groups, Subgroups and Projects

#### Repositories, Branches and Merge Requests

#### GitLab Tiers and Feature Availability

#### GitLab Roles and Permissions

<a id="13-getting-started-with-gitlab-cicd"></a>
### 1.3 Getting Started with GitLab CI/CD

#### The .gitlab-ci.yml File

#### Creating a First Pipeline

#### Pipeline Editor

#### CI Lint and Configuration Validation

#### Reading Pipeline and Job Views

---

<a id="2-pipeline-configuration-fundamentals"></a>
## 2. Pipeline Configuration Fundamentals

<a id="21-yaml-essentials-for-gitlab-ci"></a>
### 2.1 YAML Essentials for GitLab CI

#### Scalars, Lists and Maps

#### Multi-line Strings and Block Scalars

#### YAML Anchors and Aliases

#### Merge Keys

#### Common YAML Pitfalls

<a id="22-jobs"></a>
### 2.2 Jobs

#### Job Definition and Naming

#### script Keyword

#### before_script and after_script

#### image Keyword

#### tags Keyword

#### Hidden Jobs

#### Reserved Keywords

<a id="23-stages"></a>
### 2.3 Stages

#### Default Stages

#### Custom Stage Definitions

#### Stage Execution Order

#### .pre and .post Stages

<a id="24-global-defaults-and-inheritance"></a>
### 2.4 Global Defaults and Inheritance

#### default Keyword

#### Global image and services

#### inherit Keyword

#### Job-Level Overrides of Defaults

---

<a id="3-pipeline-architecture"></a>
## 3. Pipeline Architecture

<a id="31-pipeline-types"></a>
### 3.1 Pipeline Types

#### Branch Pipelines

#### Tag Pipelines

#### Merge Request Pipelines

#### Merged Results Pipelines

#### Merge Trains

<a id="32-directed-acyclic-graph-pipelines"></a>
### 3.2 Directed Acyclic Graph Pipelines

#### needs Keyword

#### needs:artifacts

#### Optional Needs

#### Stageless Pipelines

#### Visualizing Job Dependencies

<a id="33-parent-child-pipelines"></a>
### 3.3 Parent-Child Pipelines

#### trigger:include

#### Dynamically Generated Child Pipelines

#### trigger:strategy depend

#### Passing Variables to Child Pipelines

#### Nested Pipeline Limits

<a id="34-multi-project-pipelines"></a>
### 3.4 Multi-Project Pipelines

#### trigger:project

#### Cross-Project Variable Passing

#### Downstream Pipeline Status Mirroring

#### Fetching Artifacts Across Projects

<a id="35-triggering-pipelines"></a>
### 3.5 Triggering Pipelines

#### Manual Pipeline Runs

#### Pipeline Schedules

#### Pipeline Trigger Tokens

#### Triggering via API and Webhooks

#### CI_PIPELINE_SOURCE

---

<a id="4-job-control-and-execution-flow"></a>
## 4. Job Control and Execution Flow

<a id="41-rules"></a>
### 4.1 Rules

#### rules:if

#### rules:changes

#### rules:exists

#### rules:variables

#### rules:needs

#### Rule Evaluation Order

#### Expression Syntax and Operators

<a id="42-legacy-onlyexcept"></a>
### 4.2 Legacy only/except

#### only and except Keywords

#### Limitations of only/except

#### Migrating to rules

<a id="43-job-execution-behavior"></a>
### 4.3 Job Execution Behavior

#### when: on_success, on_failure, always

#### Manual Jobs

#### Delayed Jobs

#### allow_failure and Exit Codes

#### retry Keyword

#### Job timeout

#### interruptible Keyword

<a id="44-workflow-control"></a>
### 4.4 Workflow Control

#### workflow:rules

#### workflow:name

#### Auto-Canceling Redundant Pipelines

#### Avoiding Duplicate Pipelines

#### Switching Between Branch and MR Pipelines

<a id="45-parallelism-and-concurrency"></a>
### 4.5 Parallelism and Concurrency

#### parallel Keyword

#### parallel:matrix

#### Splitting Tests Across Parallel Jobs

#### resource_group

#### Process Modes for Resource Groups

---

<a id="5-variables-and-secrets"></a>
## 5. Variables and Secrets

<a id="51-cicd-variables-basics"></a>
### 5.1 CI/CD Variables Basics

#### Predefined Variables

#### Defining Variables in YAML

#### Project, Group and Instance Variables

#### Variable Precedence

#### Variable Expansion

<a id="52-variable-types-and-protection"></a>
### 5.2 Variable Types and Protection

#### File-Type Variables

#### Masked Variables

#### Hidden Variables

#### Protected Variables

#### Environment-Scoped Variables

#### Raw vs Expanded Values

<a id="53-dynamic-variables"></a>
### 5.3 Dynamic Variables

#### dotenv Report Artifacts

#### Passing Variables Between Jobs

#### Prefilled Variables for Manual Pipelines

#### Pipeline Inputs

<a id="54-secrets-management"></a>
### 5.4 Secrets Management

#### ID Tokens and OIDC Authentication

#### HashiCorp Vault Integration

#### AWS Secrets Manager Integration

#### Azure Key Vault Integration

#### Google Cloud Secret Manager Integration

#### GitLab Secrets Manager

---

<a id="6-gitlab-runners"></a>
## 6. GitLab Runners

<a id="61-runner-architecture"></a>
### 6.1 Runner Architecture

#### How Runners Pick Up Jobs

#### Instance, Group and Project Runners

#### GitLab-Hosted Runners

#### Runner Authentication Tokens and Registration

#### Runner Managers

<a id="62-executors"></a>
### 6.2 Executors

#### Shell Executor

#### Docker Executor

#### Kubernetes Executor

#### Docker Autoscaler Executor

#### Instance Executor

#### VirtualBox and Parallels Executors

#### SSH and Custom Executors

<a id="63-runner-configuration"></a>
### 6.3 Runner Configuration

#### config.toml Structure

#### Concurrency Settings

#### Runner Tags and Untagged Jobs

#### Protected Runners

#### Pre- and Post-Build Hooks

<a id="64-autoscaling-and-fleet-management"></a>
### 6.4 Autoscaling and Fleet Management

#### Fleeting Plugins and Cloud Autoscaling

#### Kubernetes Runner Scaling

#### Runner Fleet Dashboard

#### Monitoring Runners with Prometheus

#### Upgrading and Maintaining Runners

---

<a id="7-docker-and-container-workflows"></a>
## 7. Docker and Container Workflows

<a id="71-using-container-images-in-jobs"></a>
### 7.1 Using Container Images in Jobs

#### Choosing Job Images

#### Overriding Entrypoints

#### Private Registry Authentication

#### Image Pull Policies

<a id="72-services"></a>
### 7.2 Services

#### services Keyword

#### Service Aliases

#### Database Services for Testing

#### Service Networking and Health Checks

<a id="73-building-container-images"></a>
### 7.3 Building Container Images

#### Docker-in-Docker

#### Docker Socket Binding

#### Rootless Builds with Buildah

#### BuildKit

#### Multi-Architecture Builds

#### Layer Caching for Image Builds

<a id="74-gitlab-container-registry"></a>
### 7.4 GitLab Container Registry

#### Pushing Images from CI

#### Image Tagging Strategies

#### Cleanup Policies

#### Dependency Proxy

---

<a id="8-artifacts-caching-and-releases"></a>
## 8. Artifacts, Caching and Releases

<a id="81-job-artifacts"></a>
### 8.1 Job Artifacts

#### artifacts:paths and exclude

#### artifacts:expire_in

#### artifacts:when

#### dependencies Keyword

#### Report Artifacts

#### Browsing and Downloading Artifacts

<a id="82-caching"></a>
### 8.2 Caching

#### Cache vs Artifacts

#### cache:key and cache:key:files

#### Cache Policies: pull, push, pull-push

#### Fallback Cache Keys

#### Distributed Cache with Object Storage

#### Clearing Caches

<a id="83-package-registry"></a>
### 8.3 Package Registry

#### Publishing npm Packages

#### Publishing Maven Packages

#### Publishing PyPI Packages

#### Generic Packages

#### Authenticating with CI_JOB_TOKEN

<a id="84-releases"></a>
### 8.4 Releases

#### release Keyword

#### Creating Releases with glab

#### Release Assets and Links

#### Semantic Versioning in Pipelines

#### Changelog Generation

---

<a id="9-reusable-and-modular-configuration"></a>
## 9. Reusable and Modular Configuration

<a id="91-including-external-configuration"></a>
### 9.1 Including External Configuration

#### include:local

#### include:project

#### include:remote

#### include:template

#### Conditional Includes with rules

#### Include Merge Behavior

<a id="92-configuration-reuse-patterns"></a>
### 9.2 Configuration Reuse Patterns

#### extends Keyword

#### !reference Tags

#### Hidden Job Templates

#### Deep Merge Semantics

<a id="93-cicd-components-and-catalog"></a>
### 9.3 CI/CD Components and Catalog

#### spec:inputs

#### Input Types and Validation

#### Component Project Structure

#### Versioning and Releasing Components

#### CI/CD Catalog

#### Testing Components

<a id="94-built-in-templates"></a>
### 9.4 Built-in Templates

#### Language and Framework Templates

#### Security Scanner Templates

#### Customizing Included Templates

---

<a id="10-testing-and-code-quality"></a>
## 10. Testing and Code Quality

<a id="101-test-reporting"></a>
### 10.1 Test Reporting

#### JUnit Test Reports

#### Test Summary in Merge Requests

#### Unit Test Failure History

#### Flaky Test Detection

<a id="102-code-coverage"></a>
### 10.2 Code Coverage

#### Coverage Regex Parsing

#### Cobertura and JaCoCo Reports

#### Coverage Visualization in Diffs

#### Coverage Check Approval Rules

<a id="103-quality-analysis"></a>
### 10.3 Quality Analysis

#### Code Quality Reports

#### Linting Jobs

#### Accessibility Testing

#### Browser Performance Testing

#### Load Performance Testing

---

<a id="11-security-and-compliance-devsecops"></a>
## 11. Security and Compliance (DevSecOps)

<a id="111-application-security-testing"></a>
### 11.1 Application Security Testing

#### Static Application Security Testing (SAST)

#### Secret Detection

#### Dependency Scanning

#### Container Scanning

#### Infrastructure as Code Scanning

#### Dynamic Application Security Testing (DAST)

#### API Security Testing

#### Coverage-Guided Fuzz Testing

<a id="112-vulnerability-management"></a>
### 11.2 Vulnerability Management

#### Security Widget in Merge Requests

#### Vulnerability Report

#### Security Dashboard

#### Dependency List and SBOM

#### Vulnerability Triage Workflow

<a id="113-security-policies-and-compliance"></a>
### 11.3 Security Policies and Compliance

#### Scan Execution Policies

#### Pipeline Execution Policies

#### Merge Request Approval Policies

#### Compliance Frameworks

#### Audit Events

<a id="114-pipeline-security-hardening"></a>
### 11.4 Pipeline Security Hardening

#### Protected Branches and Tags

#### CI_JOB_TOKEN Scope and Allowlists

#### Least-Privilege Runner Design

#### Securing Pipelines from Forks

#### Artifact Signing with Sigstore

#### SLSA Provenance and Attestation

---

<a id="12-deployment-and-environments"></a>
## 12. Deployment and Environments

<a id="121-environments"></a>
### 12.1 Environments

#### environment Keyword

#### Static vs Dynamic Environments

#### Environment Tiers and URLs

#### Protected Environments

#### Deployment Approvals

#### Environment Dashboard

<a id="122-review-apps"></a>
### 12.2 Review Apps

#### Configuring Review Apps

#### environment:on_stop

#### auto_stop_in

#### Cleaning Up Stale Environments

<a id="123-deployment-strategies"></a>
### 12.3 Deployment Strategies

#### Incremental Rollouts

#### Canary Deployments

#### Blue-Green Deployments

#### Feature Flags

#### Rollbacks and Re-deployments

#### Deployment Safety Settings

<a id="124-deployment-targets"></a>
### 12.4 Deployment Targets

#### GitLab Pages

#### Deploying to Kubernetes with the GitLab Agent

#### Deploying to AWS

#### Deploying to Google Cloud

#### Deploying to Azure

#### SSH-Based Deployments

<a id="125-gitops-and-infrastructure-as-code"></a>
### 12.5 GitOps and Infrastructure as Code

#### GitOps with Flux and the GitLab Agent

#### Terraform and OpenTofu Pipelines

#### GitLab-Managed Terraform State

#### Helm Chart Deployments

#### Infrastructure Plan Review in Merge Requests

<a id="126-auto-devops"></a>
### 12.6 Auto DevOps

#### Auto DevOps Overview

#### Auto DevOps Stages

#### Customizing Auto DevOps

#### Auto Deploy

#### When to Use Auto DevOps

---

<a id="13-pipeline-optimization"></a>
## 13. Pipeline Optimization

<a id="131-speed-and-efficiency"></a>
### 13.1 Speed and Efficiency

#### Analyzing Pipeline Duration

#### GIT_DEPTH and Shallow Clones

#### GIT_STRATEGY Options

#### Fail-Fast Pipeline Design

#### Optimizing Image Size and Pull Time

<a id="132-cost-and-resource-management"></a>
### 13.2 Cost and Resource Management

#### Compute Minutes and Quotas

#### Runner Sizing and Machine Types

#### Job Resource Requests and Limits

#### Reducing Redundant Pipeline Runs

<a id="133-monorepo-strategies"></a>
### 13.3 Monorepo Strategies

#### Path-Based Job Triggering

#### Per-Service Child Pipelines

#### Shared Configuration in Monorepos

#### Sparse and Partial Clones

---

<a id="14-monitoring-debugging-and-troubleshooting"></a>
## 14. Monitoring, Debugging and Troubleshooting

<a id="141-debugging-pipelines"></a>
### 14.1 Debugging Pipelines

#### Reading Job Logs

#### CI_DEBUG_TRACE

#### Collapsible Log Sections

#### Interactive Web Terminals

#### Running Pipelines Locally

#### AI-Assisted Root Cause Analysis

#### Common Configuration Errors

<a id="142-observability-and-metrics"></a>
### 14.2 Observability and Metrics

#### CI/CD Analytics

#### DORA Metrics

#### Value Stream Analytics

#### Pipeline and Coverage Badges

<a id="143-notifications-and-integrations"></a>
### 14.3 Notifications and Integrations

#### Pipeline Email Notifications

#### Slack and Microsoft Teams Integrations

#### Pipeline Webhooks

#### External Commit Status Reporting

---

<a id="15-administration-automation-and-migration"></a>
## 15. Administration, Automation and Migration

<a id="151-instance-level-cicd-administration"></a>
### 15.1 Instance-Level CI/CD Administration

#### Instance CI/CD Settings

#### Pipeline and Job Limits

#### Artifact and Log Object Storage

#### Job Log Retention

#### Instance Template Repository

<a id="152-governance-at-scale"></a>
### 15.2 Governance at Scale

#### Organization-Wide Component Libraries

#### Standardized Pipeline Templates

#### Centralized Runner Strategy

#### Enforcing Pipeline Standards Across Groups

<a id="153-programmatic-pipeline-management"></a>
### 15.3 Programmatic Pipeline Management

#### Pipelines REST API

#### GraphQL API for CI/CD

#### glab CLI

#### Managing GitLab with the Terraform Provider

<a id="154-migrating-to-gitlab-cicd"></a>
### 15.4 Migrating to GitLab CI/CD

#### Migrating from Jenkins

#### Migrating from GitHub Actions

#### Migrating from CircleCI

#### Migrating from Azure DevOps

#### Incremental Migration Strategies
