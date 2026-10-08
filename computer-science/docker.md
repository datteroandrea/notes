# Docker

## Index

- [1. Containerization Fundamentals](#1-containerization-fundamentals)
  - [1.1 Introduction to Containers](#11-introduction-to-containers)
  - [1.2 Linux Foundations of Containers](#12-linux-foundations-of-containers)
  - [1.3 Container Standards and Ecosystem](#13-container-standards-and-ecosystem)
- [2. Docker Architecture and Setup](#2-docker-architecture-and-setup)
  - [2.1 Docker Architecture](#21-docker-architecture)
  - [2.2 Installation and Configuration](#22-installation-and-configuration)
  - [2.3 Docker Objects Overview](#23-docker-objects-overview)
- [3. Working with Containers](#3-working-with-containers)
  - [3.1 Container Lifecycle](#31-container-lifecycle)
  - [3.2 Interacting with Containers](#32-interacting-with-containers)
  - [3.3 Container Configuration](#33-container-configuration)
  - [3.4 Monitoring and Housekeeping](#34-monitoring-and-housekeeping)
- [4. Docker Images](#4-docker-images)
  - [4.1 Image Fundamentals](#41-image-fundamentals)
  - [4.2 Image Management](#42-image-management)
  - [4.3 Image Registries](#43-image-registries)
- [5. Building Images with Dockerfiles](#5-building-images-with-dockerfiles)
  - [5.1 Dockerfile Basics](#51-dockerfile-basics)
  - [5.2 Runtime Instructions](#52-runtime-instructions)
  - [5.3 The Build Process](#53-the-build-process)
  - [5.4 Multi-Stage Builds](#54-multi-stage-builds)
  - [5.5 Dockerfile Best Practices](#55-dockerfile-best-practices)
- [6. Data Persistence and Storage](#6-data-persistence-and-storage)
  - [6.1 Storage Concepts](#61-storage-concepts)
  - [6.2 Volumes](#62-volumes)
  - [6.3 Mounts](#63-mounts)
  - [6.4 Data Management](#64-data-management)
- [7. Docker Networking](#7-docker-networking)
  - [7.1 Networking Fundamentals](#71-networking-fundamentals)
  - [7.2 Network Drivers](#72-network-drivers)
  - [7.3 Container Communication](#73-container-communication)
- [8. Docker Compose](#8-docker-compose)
  - [8.1 Compose Fundamentals](#81-compose-fundamentals)
  - [8.2 Configuring Services](#82-configuring-services)
  - [8.3 Advanced Compose](#83-advanced-compose)
  - [8.4 Compose Workflows](#84-compose-workflows)
- [9. Advanced Builds with BuildKit](#9-advanced-builds-with-buildkit)
  - [9.1 BuildKit and Buildx](#91-buildkit-and-buildx)
  - [9.2 Advanced Build Features](#92-advanced-build-features)
  - [9.3 Multi-Platform and Remote Caching](#93-multi-platform-and-remote-caching)
- [10. Docker Security](#10-docker-security)
  - [10.1 Container Isolation and Hardening](#101-container-isolation-and-hardening)
  - [10.2 Kernel Security Mechanisms](#102-kernel-security-mechanisms)
  - [10.3 Image and Supply Chain Security](#103-image-and-supply-chain-security)
  - [10.4 Secrets Management](#104-secrets-management)
- [11. Resource Management and Performance](#11-resource-management-and-performance)
  - [11.1 Resource Constraints](#111-resource-constraints)
  - [11.2 Performance Optimization](#112-performance-optimization)
- [12. Logging, Monitoring, and Debugging](#12-logging-monitoring-and-debugging)
  - [12.1 Logging](#121-logging)
  - [12.2 Monitoring](#122-monitoring)
  - [12.3 Debugging and Troubleshooting](#123-debugging-and-troubleshooting)
- [13. Docker in Development and CI/CD](#13-docker-in-development-and-cicd)
  - [13.1 Development Workflows](#131-development-workflows)
  - [13.2 Continuous Integration and Delivery](#132-continuous-integration-and-delivery)
- [14. Orchestration and Production](#14-orchestration-and-production)
  - [14.1 Docker Swarm](#141-docker-swarm)
  - [14.2 Docker and Kubernetes](#142-docker-and-kubernetes)
  - [14.3 Production Best Practices](#143-production-best-practices)
- [15. Docker Internals and Extensibility](#15-docker-internals-and-extensibility)
  - [15.1 Engine Internals](#151-engine-internals)
  - [15.2 Extending Docker](#152-extending-docker)

---

<a id="1-containerization-fundamentals"></a>
## 1. Containerization Fundamentals

<a id="11-introduction-to-containers"></a>
### 1.1 Introduction to Containers

#### What Is a Container

#### Containers vs Virtual Machines

#### Benefits of Containerization

#### History of Containers

#### Common Use Cases

<a id="12-linux-foundations-of-containers"></a>
### 1.2 Linux Foundations of Containers

#### Namespaces

#### Control Groups (cgroups)

#### Union File Systems

#### chroot and Process Isolation

#### Linux Capabilities

<a id="13-container-standards-and-ecosystem"></a>
### 1.3 Container Standards and Ecosystem

#### Open Container Initiative (OCI)

#### OCI Image Specification

#### OCI Runtime Specification

#### Container Runtimes Overview

#### Docker Alternatives (Podman, containerd, CRI-O)

---

<a id="2-docker-architecture-and-setup"></a>
## 2. Docker Architecture and Setup

<a id="21-docker-architecture"></a>
### 2.1 Docker Architecture

#### Docker Engine

#### Docker Daemon (dockerd)

#### Docker CLI

#### Docker REST API

#### containerd and runc

#### Client-Server Model

<a id="22-installation-and-configuration"></a>
### 2.2 Installation and Configuration

#### Installing Docker on Linux

#### Docker Desktop for Windows and macOS

#### Docker on WSL2

#### Post-Installation Steps

#### Running Docker Without Root

#### daemon.json Configuration

<a id="23-docker-objects-overview"></a>
### 2.3 Docker Objects Overview

#### Images

#### Containers

#### Volumes

#### Networks

#### Registries

#### Docker Contexts

---

<a id="3-working-with-containers"></a>
## 3. Working with Containers

<a id="31-container-lifecycle"></a>
### 3.1 Container Lifecycle

#### docker run

#### Creating vs Starting Containers

#### Stopping and Killing Containers

#### Pausing and Unpausing

#### Removing Containers

#### Container States

<a id="32-interacting-with-containers"></a>
### 3.2 Interacting with Containers

#### Interactive and Detached Modes

#### docker exec

#### docker attach

#### Copying Files with docker cp

#### Viewing Logs

#### Inspecting Containers

<a id="33-container-configuration"></a>
### 3.3 Container Configuration

#### Environment Variables

#### Port Publishing

#### Naming Containers

#### Restart Policies

#### Working Directory and User

#### Entrypoint and Command Overrides

<a id="34-monitoring-and-housekeeping"></a>
### 3.4 Monitoring and Housekeeping

#### docker ps and Filtering

#### docker stats

#### docker top

#### docker events

#### Pruning Unused Resources

#### Disk Usage with docker system df

---

<a id="4-docker-images"></a>
## 4. Docker Images

<a id="41-image-fundamentals"></a>
### 4.1 Image Fundamentals

#### Image Layers

#### Copy-on-Write

#### Image Tags

#### Image Digests

#### Base Images

#### Pulling and Listing Images

<a id="42-image-management"></a>
### 4.2 Image Management

#### Tagging Images

#### Removing Images

#### Inspecting Image History

#### Saving and Loading Images

#### Exporting and Importing Containers

#### Committing Containers to Images

<a id="43-image-registries"></a>
### 4.3 Image Registries

#### Docker Hub

#### Official and Verified Images

#### Pushing Images

#### Private Registries

#### Cloud Registries (ECR, GCR, ACR, GHCR)

#### Registry Authentication

---

<a id="5-building-images-with-dockerfiles"></a>
## 5. Building Images with Dockerfiles

<a id="51-dockerfile-basics"></a>
### 5.1 Dockerfile Basics

#### Dockerfile Syntax

#### FROM

#### RUN

#### COPY vs ADD

#### WORKDIR

#### ENV and ARG

<a id="52-runtime-instructions"></a>
### 5.2 Runtime Instructions

#### CMD

#### ENTRYPOINT

#### Shell vs Exec Form

#### EXPOSE

#### USER

#### HEALTHCHECK

#### VOLUME

#### LABEL

#### STOPSIGNAL

<a id="53-the-build-process"></a>
### 5.3 The Build Process

#### docker build

#### Build Context

#### .dockerignore

#### Build Cache

#### Cache Invalidation

#### Build Arguments

<a id="54-multi-stage-builds"></a>
### 5.4 Multi-Stage Builds

#### Multi-Stage Concept

#### Builder and Runtime Stages

#### Copying Artifacts Between Stages

#### Targeting Specific Stages

#### Language-Specific Patterns

<a id="55-dockerfile-best-practices"></a>
### 5.5 Dockerfile Best Practices

#### Layer Ordering

#### Minimizing Layers

#### Choosing Minimal Base Images

#### Distroless and Scratch Images

#### Pinning Versions

#### Reducing Image Size

---

<a id="6-data-persistence-and-storage"></a>
## 6. Data Persistence and Storage

<a id="61-storage-concepts"></a>
### 6.1 Storage Concepts

#### Ephemeral Container Filesystem

#### Writable Container Layer

#### Storage Drivers

#### overlay2

<a id="62-volumes"></a>
### 6.2 Volumes

#### Named Volumes

#### Anonymous Volumes

#### Creating and Managing Volumes

#### Volume Drivers

#### Sharing Volumes Between Containers

#### Read-Only Volumes

<a id="63-mounts"></a>
### 6.3 Mounts

#### Bind Mounts

#### tmpfs Mounts

#### --mount vs -v Syntax

#### File Permissions and Ownership

#### Bind Mounts for Development

<a id="64-data-management"></a>
### 6.4 Data Management

#### Backing Up Volumes

#### Restoring Volumes

#### Migrating Data

#### Running Databases in Containers

---

<a id="7-docker-networking"></a>
## 7. Docker Networking

<a id="71-networking-fundamentals"></a>
### 7.1 Networking Fundamentals

#### Container Network Model

#### Network Drivers Overview

#### docker0 Bridge

#### Port Mapping Internals

#### iptables and Docker

<a id="72-network-drivers"></a>
### 7.2 Network Drivers

#### Default Bridge Network

#### User-Defined Bridge Networks

#### Host Network

#### None Network

#### Overlay Network

#### Macvlan and IPvlan

<a id="73-container-communication"></a>
### 7.3 Container Communication

#### Embedded DNS and Service Discovery

#### Network Aliases

#### Connecting Containers to Multiple Networks

#### Network Isolation

#### Troubleshooting Connectivity

---

<a id="8-docker-compose"></a>
## 8. Docker Compose

<a id="81-compose-fundamentals"></a>
### 8.1 Compose Fundamentals

#### What Is Docker Compose

#### Compose V2 Plugin

#### compose.yaml Structure

#### Services

#### Compose CLI Commands

<a id="82-configuring-services"></a>
### 8.2 Configuring Services

#### build vs image

#### Ports and Expose

#### Environment and env_file

#### Volumes in Compose

#### Networks in Compose

#### depends_on and Startup Order

#### Healthchecks in Compose

<a id="83-advanced-compose"></a>
### 8.3 Advanced Compose

#### Variable Interpolation

#### Multiple Compose Files and Overrides

#### Profiles

#### Extends and Include

#### Scaling Services

#### Compose Watch for Development

<a id="84-compose-workflows"></a>
### 8.4 Compose Workflows

#### Local Development Environments

#### Multi-Container Applications

#### Integration Testing with Compose

#### Secrets and Configs in Compose

---

<a id="9-advanced-builds-with-buildkit"></a>
## 9. Advanced Builds with BuildKit

<a id="91-buildkit-and-buildx"></a>
### 9.1 BuildKit and Buildx

#### BuildKit Architecture

#### Enabling BuildKit

#### docker buildx

#### Builder Instances

#### Build Drivers

<a id="92-advanced-build-features"></a>
### 9.2 Advanced Build Features

#### Cache Mounts

#### Secret Mounts

#### SSH Mounts

#### Heredocs in Dockerfiles

#### Dockerfile Frontends and Syntax Directive

<a id="93-multi-platform-and-remote-caching"></a>
### 9.3 Multi-Platform and Remote Caching

#### Multi-Architecture Images

#### Image Manifests and Manifest Lists

#### QEMU Emulation

#### Cross-Compilation

#### Registry and Inline Cache

#### Bake Files

---

<a id="10-docker-security"></a>
## 10. Docker Security

<a id="101-container-isolation-and-hardening"></a>
### 10.1 Container Isolation and Hardening

#### Running as Non-Root

#### Rootless Docker

#### User Namespace Remapping

#### Dropping Capabilities

#### Read-Only Root Filesystem

#### no-new-privileges

<a id="102-kernel-security-mechanisms"></a>
### 10.2 Kernel Security Mechanisms

#### Seccomp Profiles

#### AppArmor

#### SELinux

#### Privileged Containers and Risks

#### Docker Socket Exposure Risks

<a id="103-image-and-supply-chain-security"></a>
### 10.3 Image and Supply Chain Security

#### Vulnerability Scanning

#### Docker Scout

#### Image Signing and Verification

#### Software Bill of Materials (SBOM)

#### Build Provenance and Attestations

#### Trusted Base Images

<a id="104-secrets-management"></a>
### 10.4 Secrets Management

#### Avoiding Secrets in Images

#### Build-Time Secrets

#### Runtime Secrets

#### External Secret Managers

---

<a id="11-resource-management-and-performance"></a>
## 11. Resource Management and Performance

<a id="111-resource-constraints"></a>
### 11.1 Resource Constraints

#### Memory Limits

#### CPU Limits and Shares

#### CPU Pinning

#### Block I/O Limits

#### PID Limits

#### OOM Behavior

<a id="112-performance-optimization"></a>
### 11.2 Performance Optimization

#### Startup Time Optimization

#### Image Pull Performance

#### Storage Driver Performance

#### Networking Performance

#### Docker Desktop Performance Tuning

---

<a id="12-logging-monitoring-and-debugging"></a>
## 12. Logging, Monitoring, and Debugging

<a id="121-logging"></a>
### 12.1 Logging

#### Logging Drivers

#### Log Rotation

#### Centralized Logging

#### Structured Logging Practices

<a id="122-monitoring"></a>
### 12.2 Monitoring

#### Container Metrics

#### cAdvisor

#### Prometheus and Grafana Integration

#### Daemon Metrics Endpoint

<a id="123-debugging-and-troubleshooting"></a>
### 12.3 Debugging and Troubleshooting

#### Debugging Crashed Containers

#### docker debug

#### Exit Codes

#### Debugging Builds

#### Inspecting Network Issues

#### Daemon Logs and Diagnostics

---

<a id="13-docker-in-development-and-cicd"></a>
## 13. Docker in Development and CI/CD

<a id="131-development-workflows"></a>
### 13.1 Development Workflows

#### Containerized Development Environments

#### Dev Containers

#### Hot Reloading

#### Debugging Apps Inside Containers

#### Testcontainers

<a id="132-continuous-integration-and-delivery"></a>
### 13.2 Continuous Integration and Delivery

#### Building Images in CI

#### GitHub Actions for Docker

#### Docker-in-Docker vs Socket Mounting

#### CI Build Caching

#### Image Tagging Strategies

#### Automated Scanning in Pipelines

---

<a id="14-orchestration-and-production"></a>
## 14. Orchestration and Production

<a id="141-docker-swarm"></a>
### 14.1 Docker Swarm

#### Swarm Mode Architecture

#### Managers and Workers

#### Services and Tasks

#### Stacks

#### Rolling Updates and Rollbacks

#### Swarm Secrets and Configs

#### Routing Mesh

<a id="142-docker-and-kubernetes"></a>
### 14.2 Docker and Kubernetes

#### From Compose to Kubernetes

#### Kubernetes Container Runtime Interface

#### dockershim Deprecation

#### Running Docker Images on Kubernetes

#### Local Kubernetes with Docker Desktop

<a id="143-production-best-practices"></a>
### 14.3 Production Best Practices

#### Twelve-Factor Apps and Containers

#### Graceful Shutdown and Signal Handling

#### PID 1 and Init Processes

#### Health Checks and Self-Healing

#### Configuration Management

#### Deploying to Cloud Container Services

---

<a id="15-docker-internals-and-extensibility"></a>
## 15. Docker Internals and Extensibility

<a id="151-engine-internals"></a>
### 15.1 Engine Internals

#### containerd Shims

#### Container Creation Flow

#### Image Store and Content Addressing

#### containerd Image Store

#### Daemon Socket and API Versions

<a id="152-extending-docker"></a>
### 15.2 Extending Docker

#### Docker Engine API and SDKs

#### Docker Plugins

#### Volume and Network Plugins

#### CLI Plugins

#### Docker Desktop Extensions

#### Alternative Runtimes (gVisor, Kata Containers)
