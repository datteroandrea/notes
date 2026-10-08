# Azure Developer

## Index

- [1. Azure Fundamentals for Developers](#1-azure-fundamentals-for-developers)
  - [1.1 Cloud Computing Concepts](#11-cloud-computing-concepts)
  - [1.2 Azure Global Infrastructure](#12-azure-global-infrastructure)
  - [1.3 Resource Organization](#13-resource-organization)
  - [1.4 Developer Tooling](#14-developer-tooling)
  - [1.5 Azure SDK Fundamentals](#15-azure-sdk-fundamentals)
- [2. Identity and Access for Applications](#2-identity-and-access-for-applications)
  - [2.1 Microsoft Entra ID Fundamentals](#21-microsoft-entra-id-fundamentals)
  - [2.2 Authentication Protocols](#22-authentication-protocols)
  - [2.3 Microsoft Authentication Library (MSAL)](#23-microsoft-authentication-library-msal)
  - [2.4 Managed Identities and Azure Identity Library](#24-managed-identities-and-azure-identity-library)
  - [2.5 Authorization with Azure RBAC](#25-authorization-with-azure-rbac)
  - [2.6 Microsoft Graph](#26-microsoft-graph)
  - [2.7 Customer Identity](#27-customer-identity)
- [3. Azure Compute for Applications](#3-azure-compute-for-applications)
  - [3.1 Azure Virtual Machines for Developers](#31-azure-virtual-machines-for-developers)
  - [3.2 Azure App Service](#32-azure-app-service)
  - [3.3 Azure Functions Fundamentals](#33-azure-functions-fundamentals)
  - [3.4 Advanced Azure Functions](#34-advanced-azure-functions)
  - [3.5 Static Web Apps](#35-static-web-apps)
- [4. Containers on Azure](#4-containers-on-azure)
  - [4.1 Container Fundamentals](#41-container-fundamentals)
  - [4.2 Azure Container Registry](#42-azure-container-registry)
  - [4.3 Azure Container Instances](#43-azure-container-instances)
  - [4.4 Azure Container Apps](#44-azure-container-apps)
  - [4.5 Azure Kubernetes Service for Developers](#45-azure-kubernetes-service-for-developers)
- [5. Azure Storage Solutions](#5-azure-storage-solutions)
  - [5.1 Storage Account Fundamentals](#51-storage-account-fundamentals)
  - [5.2 Azure Blob Storage](#52-azure-blob-storage)
  - [5.3 Secure Storage Access](#53-secure-storage-access)
  - [5.4 Other Storage Services](#54-other-storage-services)
  - [5.5 Storage Data Movement](#55-storage-data-movement)
- [6. Databases and Data Services](#6-databases-and-data-services)
  - [6.1 Azure Cosmos DB Fundamentals](#61-azure-cosmos-db-fundamentals)
  - [6.2 Cosmos DB Data Modeling and Development](#62-cosmos-db-data-modeling-and-development)
  - [6.3 Cosmos DB Server-Side and Change Processing](#63-cosmos-db-server-side-and-change-processing)
  - [6.4 Relational Databases](#64-relational-databases)
  - [6.5 Azure Cache for Redis](#65-azure-cache-for-redis)
- [7. Application Security](#7-application-security)
  - [7.1 Azure Key Vault](#71-azure-key-vault)
  - [7.2 Azure App Configuration](#72-azure-app-configuration)
  - [7.3 Network Security for Applications](#73-network-security-for-applications)
  - [7.4 Secure Development Practices](#74-secure-development-practices)
- [8. API Management and Integration](#8-api-management-and-integration)
  - [8.1 Azure API Management Fundamentals](#81-azure-api-management-fundamentals)
  - [8.2 APIM Policies](#82-apim-policies)
  - [8.3 Securing and Monitoring APIs](#83-securing-and-monitoring-apis)
  - [8.4 Workflow Integration](#84-workflow-integration)
- [9. Event-Based Solutions](#9-event-based-solutions)
  - [9.1 Event-Driven Architecture Concepts](#91-event-driven-architecture-concepts)
  - [9.2 Azure Event Grid](#92-azure-event-grid)
  - [9.3 Azure Event Hubs](#93-azure-event-hubs)
- [10. Message-Based Solutions](#10-message-based-solutions)
  - [10.1 Azure Service Bus Fundamentals](#101-azure-service-bus-fundamentals)
  - [10.2 Advanced Service Bus Features](#102-advanced-service-bus-features)
  - [10.3 Choosing a Messaging Service](#103-choosing-a-messaging-service)
- [11. Monitoring, Troubleshooting, and Optimization](#11-monitoring-troubleshooting-and-optimization)
  - [11.1 Azure Monitor Fundamentals](#111-azure-monitor-fundamentals)
  - [11.2 Application Insights](#112-application-insights)
  - [11.3 Troubleshooting Applications](#113-troubleshooting-applications)
  - [11.4 Performance and Content Delivery](#114-performance-and-content-delivery)
- [12. Infrastructure as Code and DevOps](#12-infrastructure-as-code-and-devops)
  - [12.1 ARM Templates](#121-arm-templates)
  - [12.2 Bicep](#122-bicep)
  - [12.3 Third-Party IaC](#123-third-party-iac)
  - [12.4 CI/CD Pipelines](#124-cicd-pipelines)
  - [12.5 Developer Environments](#125-developer-environments)
- [13. AI and Intelligent Applications](#13-ai-and-intelligent-applications)
  - [13.1 Azure AI Services](#131-azure-ai-services)
  - [13.2 Generative AI on Azure](#132-generative-ai-on-azure)
  - [13.3 Building AI-Powered Apps](#133-building-ai-powered-apps)
- [14. Cloud Architecture Patterns and Best Practices](#14-cloud-architecture-patterns-and-best-practices)
  - [14.1 Resiliency Patterns](#141-resiliency-patterns)
  - [14.2 Data and Messaging Patterns](#142-data-and-messaging-patterns)
  - [14.3 Application Design Patterns](#143-application-design-patterns)
  - [14.4 Azure Well-Architected Framework](#144-azure-well-architected-framework)
  - [14.5 Cost Management for Developers](#145-cost-management-for-developers)

---

<a id="1-azure-fundamentals-for-developers"></a>
## 1. Azure Fundamentals for Developers

<a id="11-cloud-computing-concepts"></a>
### 1.1 Cloud Computing Concepts

#### IaaS vs PaaS vs SaaS vs Serverless

#### Shared Responsibility Model

#### Consumption-Based Pricing

#### High Availability and Scalability

#### Elasticity and Fault Tolerance

<a id="12-azure-global-infrastructure"></a>
### 1.2 Azure Global Infrastructure

#### Regions and Region Pairs

#### Availability Zones

#### Sovereign Clouds

#### Service Level Agreements

#### Data Residency

<a id="13-resource-organization"></a>
### 1.3 Resource Organization

#### Management Groups

#### Subscriptions

#### Resource Groups

#### Resources and Resource Providers

#### Tags and Naming Conventions

#### Azure Resource Manager Overview

<a id="14-developer-tooling"></a>
### 1.4 Developer Tooling

#### Azure Portal

#### Azure CLI

#### Azure PowerShell

#### Azure Cloud Shell

#### Azure Developer CLI (azd)

#### Visual Studio and VS Code Azure Extensions

#### Azure SDKs Overview

<a id="15-azure-sdk-fundamentals"></a>
### 1.5 Azure SDK Fundamentals

#### Client Libraries and Package Conventions

#### Client Options and Retry Policies

#### Pagination and Long-Running Operations

#### Error Handling and Diagnostics

#### Management vs Data Plane Libraries

---

<a id="2-identity-and-access-for-applications"></a>
## 2. Identity and Access for Applications

<a id="21-microsoft-entra-id-fundamentals"></a>
### 2.1 Microsoft Entra ID Fundamentals

#### Tenants and Directories

#### Users, Groups, and Roles

#### App Registrations

#### Service Principals and Enterprise Apps

#### Single-Tenant vs Multi-Tenant Apps

<a id="22-authentication-protocols"></a>
### 2.2 Authentication Protocols

#### OAuth 2.0 Flows

#### OpenID Connect

#### Access, ID, and Refresh Tokens

#### JWT Structure and Validation

#### Scopes, Permissions, and Consent

<a id="23-microsoft-authentication-library-msal"></a>
### 2.3 Microsoft Authentication Library (MSAL)

#### Public vs Confidential Clients

#### Acquiring Tokens Interactively

#### Client Credentials Flow

#### On-Behalf-Of Flow

#### Token Caching

<a id="24-managed-identities-and-azure-identity-library"></a>
### 2.4 Managed Identities and Azure Identity Library

#### System-Assigned Managed Identity

#### User-Assigned Managed Identity

#### DefaultAzureCredential

#### Credential Chains

#### Workload Identity Federation

<a id="25-authorization-with-azure-rbac"></a>
### 2.5 Authorization with Azure RBAC

#### Role Definitions and Assignments

#### Built-In vs Custom Roles

#### Scope Hierarchy

#### Data Plane Roles

#### Least Privilege Principles

<a id="26-microsoft-graph"></a>
### 2.6 Microsoft Graph

#### Graph API Overview

#### Graph SDKs

#### Querying Users and Groups

#### Delta Queries

#### Change Notifications

<a id="27-customer-identity"></a>
### 2.7 Customer Identity

#### Microsoft Entra External ID

#### Azure AD B2C Concepts

#### User Flows and Custom Policies

#### Social Identity Providers

---

<a id="3-azure-compute-for-applications"></a>
## 3. Azure Compute for Applications

<a id="31-azure-virtual-machines-for-developers"></a>
### 3.1 Azure Virtual Machines for Developers

#### VM Sizes and Images

#### Provisioning VMs via CLI and SDK

#### Custom Script Extension

#### Cloud-init

#### Virtual Machine Scale Sets

<a id="32-azure-app-service"></a>
### 3.2 Azure App Service

#### App Service Plans and Tiers

#### Creating and Deploying Web Apps

#### App Settings and Connection Strings

#### Deployment Slots and Swaps

#### Autoscaling Rules

#### Custom Domains and TLS Certificates

#### Diagnostic Logging

#### Built-In Authentication (Easy Auth)

<a id="33-azure-functions-fundamentals"></a>
### 3.3 Azure Functions Fundamentals

#### Serverless Execution Model

#### Hosting Plans (Consumption, Flex, Premium, Dedicated)

#### Triggers and Bindings

#### Isolated Worker Model

#### Function App Configuration

#### Local Development with Core Tools

<a id="34-advanced-azure-functions"></a>
### 3.4 Advanced Azure Functions

#### Durable Functions Orchestrations

#### Activity and Entity Functions

#### Function Chaining and Fan-Out/Fan-In

#### Human Interaction Patterns

#### Cold Start Mitigation

#### Concurrency and Scaling Behavior

<a id="35-static-web-apps"></a>
### 3.5 Static Web Apps

#### Static Web Apps Overview

#### Framework Integration

#### Managed API Functions

#### Routing and Configuration File

#### Preview Environments

---

<a id="4-containers-on-azure"></a>
## 4. Containers on Azure

<a id="41-container-fundamentals"></a>
### 4.1 Container Fundamentals

#### Docker Images and Containers

#### Writing Dockerfiles

#### Multi-Stage Builds

#### Image Tagging Strategies

<a id="42-azure-container-registry"></a>
### 4.2 Azure Container Registry

#### Registry Tiers

#### Pushing and Pulling Images

#### ACR Tasks and Automated Builds

#### Geo-Replication

#### Registry Authentication

<a id="43-azure-container-instances"></a>
### 4.3 Azure Container Instances

#### Container Groups

#### Restart Policies

#### Environment Variables and Secrets

#### Mounting Azure Files Volumes

<a id="44-azure-container-apps"></a>
### 4.4 Azure Container Apps

#### Environments and Revisions

#### Ingress Configuration

#### KEDA-Based Scaling Rules

#### Dapr Integration

#### Container Apps Jobs

#### Secrets and Managed Identity

<a id="45-azure-kubernetes-service-for-developers"></a>
### 4.5 Azure Kubernetes Service for Developers

#### AKS Cluster Basics

#### Deployments, Services, and Ingress

#### ConfigMaps and Secrets

#### Helm Charts

#### Workload Identity on AKS

#### Horizontal Pod Autoscaling

---

<a id="5-azure-storage-solutions"></a>
## 5. Azure Storage Solutions

<a id="51-storage-account-fundamentals"></a>
### 5.1 Storage Account Fundamentals

#### Storage Account Types

#### Redundancy Options (LRS, ZRS, GRS, GZRS)

#### Access Keys and Connection Strings

#### Storage Endpoints

#### Storage Firewalls

<a id="52-azure-blob-storage"></a>
### 5.2 Azure Blob Storage

#### Containers and Blob Types

#### Access Tiers (Hot, Cool, Cold, Archive)

#### Blob SDK Operations

#### Metadata and Properties

#### Lifecycle Management Policies

#### Blob Versioning and Soft Delete

#### Static Website Hosting

<a id="53-secure-storage-access"></a>
### 5.3 Secure Storage Access

#### Shared Access Signatures

#### User Delegation SAS

#### Stored Access Policies

#### Entra ID Authorization for Storage

#### Encryption at Rest and Customer-Managed Keys

<a id="54-other-storage-services"></a>
### 5.4 Other Storage Services

#### Azure Queue Storage

#### Azure Table Storage

#### Azure Files

#### Data Lake Storage Gen2

<a id="55-storage-data-movement"></a>
### 5.5 Storage Data Movement

#### AzCopy

#### Azure Storage Explorer

#### Blob Change Feed

#### Object Replication

---

<a id="6-databases-and-data-services"></a>
## 6. Databases and Data Services

<a id="61-azure-cosmos-db-fundamentals"></a>
### 6.1 Azure Cosmos DB Fundamentals

#### Cosmos DB Resource Model

#### APIs (NoSQL, MongoDB, Cassandra, Gremlin, Table, PostgreSQL)

#### Request Units

#### Provisioned vs Serverless Throughput

#### Global Distribution

<a id="62-cosmos-db-data-modeling-and-development"></a>
### 6.2 Cosmos DB Data Modeling and Development

#### Partition Key Design

#### Consistency Levels

#### CRUD Operations with SDK

#### SQL Query Syntax

#### Indexing Policies

#### Time-To-Live

<a id="63-cosmos-db-server-side-and-change-processing"></a>
### 6.3 Cosmos DB Server-Side and Change Processing

#### Stored Procedures

#### Triggers and User-Defined Functions

#### Transactional Batch

#### Change Feed Processor

#### Change Feed with Azure Functions

<a id="64-relational-databases"></a>
### 6.4 Relational Databases

#### Azure SQL Database

#### Azure Database for PostgreSQL

#### Azure Database for MySQL

#### Connection Pooling and Resiliency

#### Passwordless Database Connections

#### Elastic Pools and Serverless Tier

<a id="65-azure-cache-for-redis"></a>
### 6.5 Azure Cache for Redis

#### Cache Tiers

#### Cache-Aside Pattern

#### Data Expiration and Eviction

#### Session State Caching

#### Redis Pub/Sub

---

<a id="7-application-security"></a>
## 7. Application Security

<a id="71-azure-key-vault"></a>
### 7.1 Azure Key Vault

#### Secrets, Keys, and Certificates

#### Access Policies vs RBAC

#### Key Vault SDK Usage

#### Key Rotation

#### Soft Delete and Purge Protection

#### Key Vault References in App Service

<a id="72-azure-app-configuration"></a>
### 7.2 Azure App Configuration

#### Key-Values and Labels

#### Feature Flags

#### Dynamic Configuration Refresh

#### Key Vault Integration

#### Configuration Snapshots

<a id="73-network-security-for-applications"></a>
### 7.3 Network Security for Applications

#### Virtual Network Integration

#### Private Endpoints

#### Service Endpoints

#### Access Restrictions and IP Filtering

#### Network Security Groups

<a id="74-secure-development-practices"></a>
### 7.4 Secure Development Practices

#### Secret Scanning and Avoiding Hardcoded Credentials

#### Microsoft Defender for Cloud Recommendations

#### CORS Configuration

#### Data Encryption in Transit

---

<a id="8-api-management-and-integration"></a>
## 8. API Management and Integration

<a id="81-azure-api-management-fundamentals"></a>
### 8.1 Azure API Management Fundamentals

#### APIM Components (Gateway, Management Plane, Developer Portal)

#### Service Tiers

#### Products and Subscriptions

#### Importing APIs from OpenAPI

#### API Versions and Revisions

<a id="82-apim-policies"></a>
### 8.2 APIM Policies

#### Policy Structure and Scopes

#### Rate Limiting and Quotas

#### Request and Response Transformation

#### Caching Policies

#### JWT Validation

#### Policy Expressions

<a id="83-securing-and-monitoring-apis"></a>
### 8.3 Securing and Monitoring APIs

#### Subscription Keys

#### OAuth 2.0 Integration

#### Client Certificates

#### APIM Analytics

#### Self-Hosted Gateway

<a id="84-workflow-integration"></a>
### 8.4 Workflow Integration

#### Azure Logic Apps Overview

#### Connectors and Triggers

#### Standard vs Consumption Logic Apps

#### Integrating Logic Apps with Functions

---

<a id="9-event-based-solutions"></a>
## 9. Event-Based Solutions

<a id="91-event-driven-architecture-concepts"></a>
### 9.1 Event-Driven Architecture Concepts

#### Events vs Messages

#### Discrete Events vs Event Streams

#### Publish/Subscribe Pattern

#### Event Schemas and CloudEvents

<a id="92-azure-event-grid"></a>
### 9.2 Azure Event Grid

#### Topics, Subscriptions, and Event Handlers

#### System Topics vs Custom Topics

#### Event Filtering

#### Retry and Dead-Lettering

#### Webhook Validation

#### Event Grid Namespaces and MQTT

<a id="93-azure-event-hubs"></a>
### 9.3 Azure Event Hubs

#### Namespaces and Event Hubs

#### Partitions and Consumer Groups

#### Producers and Consumers with SDK

#### Checkpointing

#### Event Hubs Capture

#### Kafka Endpoint Compatibility

---

<a id="10-message-based-solutions"></a>
## 10. Message-Based Solutions

<a id="101-azure-service-bus-fundamentals"></a>
### 10.1 Azure Service Bus Fundamentals

#### Namespaces and Tiers

#### Queues

#### Topics and Subscriptions

#### Sending and Receiving with SDK

#### Receive Modes (Peek-Lock vs Receive-and-Delete)

<a id="102-advanced-service-bus-features"></a>
### 10.2 Advanced Service Bus Features

#### Sessions and FIFO Ordering

#### Dead-Letter Queues

#### Duplicate Detection

#### Scheduled Messages

#### Subscription Filters and Actions

#### Transactions

<a id="103-choosing-a-messaging-service"></a>
### 10.3 Choosing a Messaging Service

#### Service Bus vs Storage Queues

#### Event Grid vs Event Hubs vs Service Bus

#### Combining Messaging Services

---

<a id="11-monitoring-troubleshooting-and-optimization"></a>
## 11. Monitoring, Troubleshooting, and Optimization

<a id="111-azure-monitor-fundamentals"></a>
### 11.1 Azure Monitor Fundamentals

#### Metrics and Logs

#### Log Analytics Workspaces

#### Kusto Query Language Basics

#### Diagnostic Settings

#### Alerts and Action Groups

<a id="112-application-insights"></a>
### 11.2 Application Insights

#### Instrumentation with OpenTelemetry

#### Requests, Dependencies, and Exceptions

#### Custom Events and Metrics

#### Distributed Tracing

#### Application Map

#### Availability Tests

#### Sampling

<a id="113-troubleshooting-applications"></a>
### 11.3 Troubleshooting Applications

#### Live Metrics

#### Kudu and Log Streaming

#### Snapshot Debugger

#### Profiler

#### Diagnose and Solve Problems Blade

<a id="114-performance-and-content-delivery"></a>
### 11.4 Performance and Content Delivery

#### Azure Front Door

#### Azure CDN Caching Rules

#### Cache Purging

#### Response Compression

#### Performance Testing with Azure Load Testing

---

<a id="12-infrastructure-as-code-and-devops"></a>
## 12. Infrastructure as Code and DevOps

<a id="121-arm-templates"></a>
### 12.1 ARM Templates

#### Template Structure

#### Parameters and Variables

#### Template Functions

#### Deployment Modes

#### Linked and Nested Templates

<a id="122-bicep"></a>
### 12.2 Bicep

#### Bicep Syntax

#### Modules

#### Loops and Conditions

#### Deployment Scopes

#### What-If Deployments

#### Deployment Stacks

<a id="123-third-party-iac"></a>
### 12.3 Third-Party IaC

#### Terraform AzureRM Provider

#### Terraform State in Azure Storage

#### Pulumi on Azure

<a id="124-cicd-pipelines"></a>
### 12.4 CI/CD Pipelines

#### GitHub Actions for Azure

#### Azure Pipelines YAML

#### OIDC Federated Credentials for Pipelines

#### Environment Approvals and Gates

#### Deployment Strategies (Blue-Green, Canary)

<a id="125-developer-environments"></a>
### 12.5 Developer Environments

#### Azure Developer CLI Templates

#### Microsoft Dev Box

#### Azure Deployment Environments

#### GitHub Codespaces with Azure

---

<a id="13-ai-and-intelligent-applications"></a>
## 13. AI and Intelligent Applications

<a id="131-azure-ai-services"></a>
### 13.1 Azure AI Services

#### Azure AI Services Overview

#### Vision and Document Intelligence

#### Speech Services

#### Language Services

#### Content Safety

<a id="132-generative-ai-on-azure"></a>
### 13.2 Generative AI on Azure

#### Azure AI Foundry

#### Model Catalog and Deployments

#### Azure OpenAI Service

#### Prompt Engineering Basics

#### Tokens, Quotas, and Rate Limits

<a id="133-building-ai-powered-apps"></a>
### 13.3 Building AI-Powered Apps

#### Retrieval-Augmented Generation

#### Azure AI Search and Vector Indexes

#### Embeddings

#### Agent Frameworks and Tool Calling

#### Responsible AI Practices

---

<a id="14-cloud-architecture-patterns-and-best-practices"></a>
## 14. Cloud Architecture Patterns and Best Practices

<a id="141-resiliency-patterns"></a>
### 14.1 Resiliency Patterns

#### Retry with Exponential Backoff

#### Circuit Breaker

#### Bulkhead

#### Health Endpoint Monitoring

#### Queue-Based Load Leveling

<a id="142-data-and-messaging-patterns"></a>
### 14.2 Data and Messaging Patterns

#### CQRS

#### Event Sourcing

#### Saga Pattern

#### Competing Consumers

#### Claim Check

#### Materialized View

<a id="143-application-design-patterns"></a>
### 14.3 Application Design Patterns

#### Microservices on Azure

#### Strangler Fig Migration

#### Gateway Aggregation and Offloading

#### Valet Key

#### Sidecar and Ambassador

#### Backends for Frontends

<a id="144-azure-well-architected-framework"></a>
### 14.4 Azure Well-Architected Framework

#### Reliability Pillar

#### Security Pillar

#### Cost Optimization Pillar

#### Operational Excellence Pillar

#### Performance Efficiency Pillar

<a id="145-cost-management-for-developers"></a>
### 14.5 Cost Management for Developers

#### Azure Pricing Calculator

#### Cost Analysis and Budgets

#### Reserved Capacity and Savings Plans

#### Right-Sizing Resources

#### Designing Cost-Efficient Serverless Apps
