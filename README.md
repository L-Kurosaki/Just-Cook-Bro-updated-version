# Network Topology Project Documentation

**Project:** Comprehensive Network Topology Implementation  
**Tools:** Cisco Packet Tracer 8.2+  
**Date:** 2025  
**Author:** [Your Name]

---

## Table of Contents
- [Project Overview](#project-overview)
- [Topologies Summary](#topologies-summary)
- [Complete IP Address Tables](#complete-ip-address-tables)
- [VLAN Configuration](#vlan-configuration)
- [Server Configuration](#server-configuration)
- [Security Implementation](#security-implementation)
- [Router and Switch Configuration](#router-and-switch-configuration)
- [Testing and Verification](#testing-and-verification)
- [Challenges and Solutions](#challenges-and-solutions)
- [Files in This Repository](#files-in-this-repository)

---

## Project Overview

This project demonstrates the implementation of **six network topologies** using Cisco Packet Tracer:

1. **Bus Topology** - Single backbone with all devices
2. **Mesh Topology** - Full mesh core with OSPF routing
3. **Star Topology** - Centralized switch design
4. **Ring Topology** - Circular configuration with STP
5. **Extended Star Topology** - Hierarchical multi-switch design
6. **Hybrid Topology** - Star + Mesh combination (Star access, Mesh core)

### Key Features Implemented:
✅ **Dual-Stack Networking:** IPv4 and IPv6 on all devices  
✅ **VLAN Segmentation:** Multiple VLANs with proper isolation  
✅ **Server Services:** HTTP, DNS, and DHCP servers  
✅ **Dynamic Routing:** OSPF for automatic path selection  
✅ **Security Measures:** Port security, ACLs, SSH, password encryption  
✅ **Redundancy:** Multiple paths in mesh and hybrid topologies  

---

## Topologies Summary

### 1. Bus Topology
**Design:** All devices connected to a central switch (simulating bus backbone)  
**Devices:**
- 1x Switch 2960 (central)
- 1x Router 2911 (gateway)
- 5x PCs
- 1x Server (optional)

**Characteristics:**
- Single point of failure
- Simple, cost-effective
- Limited scalability
- All traffic on single medium

**VLAN:** 10 (192.168.10.0/24, 2001:db8:10::/64)

---

### 2. Mesh Topology
**Design:** Full mesh core with 4 routers, each connected to all others  
**Devices:**
- 4x Routers 2911
- 6 interconnections between routers
- OSPF dynamic routing enabled

**Characteristics:**
- No single point of failure
- High redundancy
- Multiple paths available
- Expensive/complex
- Automatic failover via OSPF

**Core Networks:**
- Router-to-Router: 10.0.x.0/30 subnets
- Server VLANs: 192.168.50.0/24

---

### 3. Star Topology
**Design:** Centralized switch with all devices connected directly  
**Devices:**
- 1x Switch 2960 (central)
- 1x Router 2911 (gateway)
- 8x PCs
- 1x Server
- 1x Printer

**Characteristics:**
- Easy to manage and troubleshoot
- Scalable design
- Central device is single point of failure
- Standard office network model

**VLAN:** 20 (192.168.20.0/24, 2001:db8:20::/64)

---

### 4. Ring Topology
**Design:** 4 switches connected in circular fashion with Spanning Tree  
**Devices:**
- 4x Switches 2960 (in ring)
- 1x Router 2911 (gateway)
- 4x PCs (one per switch)
- Spanning Tree Protocol enabled

**Characteristics:**
- Predictable path for data
- Failure isolation possible
- STP prevents broadcast storms
- Equal access for all devices

**VLAN:** 30 (192.168.30.0/24, 2001:db8:30::/64)  
**STP:** Rapid PVST+ enabled with designated root

---

### 5. Extended Star Topology
**Design:** Hierarchical with core switch and distribution switches  
**Devices:**
- 1x Core Switch 3560 (top tier)
- 3x Distribution Switches 2960 (middle tier)
- 3x Access Switches 2960 (access tier)
- 12x PCs (4 per access switch)

**Characteristics:**
- Hierarchical structure
- Highly scalable
- Central backbone provides interconnection
- Easy to expand

**VLANs:**
- VLAN 40: 192.168.40.0/24 (2001:db8:40::/64)
- VLAN 41: 192.168.41.0/24 (2001:db8:41::/64)
- VLAN 42: 192.168.42.0/24 (2001:db8:42::/64)

---

### 6. Hybrid Topology (Star + Mesh)
**Design:** Combines Star access layer with Mesh core routing  
**Core Layer (Mesh):**
- 3x Routers 2911 (fully meshed)
- OSPF for dynamic routing
- Redundant paths

**Distribution Layer:**
- 3x Distribution Switches (star topology)
- Connected to core mesh routers

**Access Layer (Star):**
- 3x Access Switches
- 12x PCs (4 per switch)
- 3x Servers

**Characteristics:**
- Enterprise-class design
- High availability and redundancy
- Automatic failover
- Scalable architecture

**VLANs:**
- VLAN 50: 192.168.50.0/24 (Server farm)
- VLAN 60: 192.168.60.0/24 (DEPT_A)
- VLAN 61: 192.168.61.0/24 (DEPT_B)

---

## Complete IP Address Tables

### Topology 1: Bus Topology

| Device | Interface | IPv4 Address | IPv6 Address | Subnet Mask | Gateway |
|--------|-----------|--------------|--------------|-------------|---------|
| PC1 | Fa0 | 192.168.10.10 | 2001:db8:10::10/64 | 255.255.255.0 | 192.168.10.1 |
| PC2 | Fa0 | 192.168.10.11 | 2001:db8:10::11/64 | 255.255.255.0 | 192.168.10.1 |
| PC3 | Fa0 | 192.168.10.12 | 2001:db8:10::12/64 | 255.255.255.0 | 192.168.10.1 |
| PC4 | Fa0 | 192.168.10.13 | 2001:db8:10::13/64 | 255.255.255.0 | 192.168.10.1 |
| PC5 | Fa0 | 192.168.10.14 | 2001:db8:10::14/64 | 255.255.255.0 | 192.168.10.1 |
| Router | Gi0/0 | 192.168.10.1 | 2001:db8:10::1/64 | 255.255.255.0 | N/A |
| Switch | VLAN10 | 192.168.10.2 | 2001:db8:10::2/64 | 255.255.255.0 | 192.168.10.1 |

**VLAN 10 Details:**
- Network: 192.168.10.0/24
- Usable IPs: 192.168.10.1 - 192.168.10.254
- Broadcast: 192.168.10.255
- IPv6: 2001:db8:10::/64

---

### Topology 2: Mesh Topology

#### Core Router Interconnections

| Router | Interface | IPv4 Address | IPv6 Address | Connected To | Subnet |
|--------|-----------|--------------|--------------|--------------|--------|
| R1 | Gi0/0 | 10.0.1.1 | 2001:db8:a::1/64 | R2 | /30 |
| R1 | Gi0/1 | 10.0.2.1 | 2001:db8:b::1/64 | R3 | /30 |
| R1 | Se0/0/0 | 10.0.3.1 | 2001:db8:c::1/64 | R4 | /30 |
| R2 | Gi0/0 | 10.0.1.2 | 2001:db8:a::2/64 | R1 | /30 |
| R2 | Gi0/1 | 10.0.4.1 | 2001:db8:d::1/64 | R3 | /30 |
| R2 | Se0/0/0 | 10.0.5.1 | 2001:db8:e::1/64 | R4 | /30 |
| R3 | Gi0/0 | 10.0.2.2 | 2001:db8:b::2/64 | R1 | /30 |
| R3 | Gi0/1 | 10.0.4.2 | 2001:db8:d::2/64 | R2 | /30 |
| R3 | Se0/0/0 | 10.0.6.1 | 2001:db8:f::1/64 | R4 | /30 |
| R4 | Se0/0/0 | 10.0.3.2 | 2001:db8:c::2/64 | R1 | /30 |
| R4 | Gi0/0 | 10.0.5.2 | 2001:db8:e::2/64 | R2 | /30 |
| R4 | Gi0/1 | 10.0.6.2 | 2001:db8:f::2/64 | R3 | /30 |

#### Mesh Topology - Loopback Addresses

| Router | Loopback IP | IPv6 Loopback | Purpose |
|--------|-------------|---------------|---------|
| R1 | 1.1.1.1/32 | 2001:db8:1::1/128 | OSPF Router ID |
| R2 | 2.2.2.2/32 | 2001:db8:2::2/128 | OSPF Router ID |
| R3 | 3.3.3.3/32 | 2001:db8:3::3/128 | OSPF Router ID |
| R4 | 4.4.4.4/32 | 2001:db8:4::4/128 | OSPF Router ID |

#### Connection Matrix (Full Mesh)

```
    R1 -------- R2
    /\          /\
   /  \        /  \
  /    \      /    \
R3 -------- R4

Connections: 6 (R1-R2, R1-R3, R1-R4, R2-R3, R2-R4, R3-R4)
```

**OSPF Configuration:**
- Process ID: 1
- Router IDs: 1.1.1.1, 2.2.2.2, 3.3.3.3, 4.4.4.4
- Area: 0 (backbone)
- Metric: Cost based on bandwidth

---

### Topology 3: Star Topology

| Device | Interface | IPv4 Address | IPv6 Address | VLAN | Role |
|--------|-----------|--------------|--------------|------|------|
| PC1 | Fa0 | 192.168.20.10 | 2001:db8:20::10/64 | 20 | Client |
| PC2 | Fa0 | 192.168.20.11 | 2001:db8:20::11/64 | 20 | Client |
| PC3 | Fa0 | 192.168.20.12 | 2001:db8:20::12/64 | 20 | Client |
| PC4 | Fa0 | 192.168.20.13 | 2001:db8:20::13/64 | 20 | Client |
| PC5 | Fa0 | 192.168.20.14 | 2001:db8:20::14/64 | 20 | Client |
| PC6 | Fa0 | 192.168.20.15 | 2001:db8:20::15/64 | 20 | Client |
| PC7 | Fa0 | 192.168.20.16 | 2001:db8:20::16/64 | 20 | Client |
| PC8 | Fa0 | 192.168.20.17 | 2001:db8:20::17/64 | 20 | Client |
| Server1 | Fa0 | 192.168.20.5 | 2001:db8:20::5/64 | 20 | HTTP/DNS |
| Printer1 | Fa0 | 192.168.20.100 | 2001:db8:20::100/64 | 20 | Printer |
| Router | Gi0/0 | 192.168.20.1 | 2001:db8:20::1/64 | N/A | Gateway |
| Switch | VLAN20 | 192.168.20.2 | 2001:db8:20::2/64 | 20 | Management |

**VLAN 20 Details:**
- Network: 192.168.20.0/24
- Gateway: 192.168.20.1
- DNS: 192.168.20.5
- DHCP Pool: 192.168.20.20 - 192.168.20.99
- IPv6: 2001:db8:20::/64

**Switch Port Assignment:**
- Fa0/1-8: PCs
- Fa0/10: Server
- Fa0/11: Printer
- Gi0/1: Router uplink

---

### Topology 4: Ring Topology

| Device | Interface | IPv4 Address | IPv6 Address | VLAN | Connected To |
|--------|-----------|--------------|--------------|------|--------------|
| Switch1 | VLAN30 | 192.168.30.2 | 2001:db8:30::2/64 | 30 | Ring node 1 |
| Switch2 | VLAN30 | 192.168.30.3 | 2001:db8:30::3/64 | 30 | Ring node 2 |
| Switch3 | VLAN30 | 192.168.30.4 | 2001:db8:30::4/64 | 30 | Ring node 3 |
| Switch4 | VLAN30 | 192.168.30.5 | 2001:db8:30::5/64 | 30 | Ring node 4 |
| Router | Gi0/0 | 192.168.30.1 | 2001:db8:30::1/64 | N/A | Gateway |
| PC1 | Fa0 | 192.168.30.10 | 2001:db8:30::10/64 | 30 | Client |
| PC2 | Fa0 | 192.168.30.11 | 2001:db8:30::11/64 | 30 | Client |
| PC3 | Fa0 | 192.168.30.12 | 2001:db8:30::12/64 | 30 | Client |
| PC4 | Fa0 | 192.168.30.13 | 2001:db8:30::13/64 | 30 | Client |

#### Ring Connection Details

| Link | Switch1 | Port | Switch2 | Port | Status |
|------|---------|------|---------|------|--------|
| 1 | Switch1 | Fa0/23 | Switch2 | Fa0/23 | Active |
| 2 | Switch2 | Fa0/24 | Switch3 | Fa0/23 | Active |
| 3 | Switch3 | Fa0/24 | Switch4 | Fa0/23 | Active |
| 4 | Switch4 | Fa0/24 | Switch1 | Fa0/24 | **Blocked by STP** |

**Spanning Tree Information:**
- Mode: Rapid PVST+
- Root Bridge: Switch1 (Priority 4096)
- Root Path Cost: 0 on root bridge
- Blocked Port: Switch4 Fa0/24 (prevents loop)

**VLAN 30 Details:**
- Network: 192.168.30.0/24
- Gateway: 192.168.30.1
- IPv6: 2001:db8:30::/64
- DHCP Pool: 192.168.30.100 - 192.168.30.200

---

### Topology 5: Extended Star Topology

#### Core Switch Configuration

| Device | Interface | IPv4 Address | IPv6 Address | VLAN | Role |
|--------|-----------|--------------|--------------|------|------|
| Core-Switch | VLAN40 | 192.168.40.1 | 2001:db8:40::1/64 | 40 | Core gateway |
| Core-Switch | VLAN41 | 192.168.41.1 | 2001:db8:41::1/64 | 41 | Core gateway |
| Core-Switch | VLAN42 | 192.168.42.1 | 2001:db8:42::1/64 | 42 | Core gateway |

#### Distribution Switches

| Device | Interface | IPv4 Address | IPv6 Address | VLAN | Uplink |
|--------|-----------|--------------|--------------|------|--------|
| Dist-SW1 | VLAN40 | 192.168.40.2 | 2001:db8:40::2/64 | 40 | Core Gi0/0 |
| Dist-SW2 | VLAN41 | 192.168.41.2 | 2001:db8:41::2/64 | 41 | Core Gi0/1 |
| Dist-SW3 | VLAN42 | 192.168.42.2 | 2001:db8:42::2/64 | 42 | Core Gi1/0 |

#### Access Layer - VLAN 40 (DEPT_A)

| Device | Interface | IPv4 Address | IPv6 Address | Gateway |
|--------|-----------|--------------|--------------|---------|
| PC1 | Fa0 | 192.168.40.10 | 2001:db8:40::10/64 | 192.168.40.1 |
| PC2 | Fa0 | 192.168.40.11 | 2001:db8:40::11/64 | 192.168.40.1 |
| PC3 | Fa0 | 192.168.40.12 | 2001:db8:40::12/64 | 192.168.40.1 |
| PC4 | Fa0 | 192.168.40.13 | 2001:db8:40::13/64 | 192.168.40.1 |

#### Access Layer - VLAN 41 (DEPT_B)

| Device | Interface | IPv4 Address | IPv6 Address | Gateway |
|--------|-----------|--------------|--------------|---------|
| PC5 | Fa0 | 192.168.41.10 | 2001:db8:41::10/64 | 192.168.41.1 |
| PC6 | Fa0 | 192.168.41.11 | 2001:db8:41::11/64 | 192.168.41.1 |
| PC7 | Fa0 | 192.168.41.12 | 2001:db8:41::12/64 | 192.168.41.1 |
| PC8 | Fa0 | 192.168.41.13 | 2001:db8:41::13/64 | 192.168.41.1 |

#### Access Layer - VLAN 42 (DEPT_C)

| Device | Interface | IPv4 Address | IPv6 Address | Gateway |
|--------|-----------|--------------|--------------|---------|
| PC9 | Fa0 | 192.168.42.10 | 2001:db8:42::10/64 | 192.168.42.1 |
| PC10 | Fa0 | 192.168.42.11 | 2001:db8:42::11/64 | 192.168.42.1 |
| PC11 | Fa0 | 192.168.42.12 | 2001:db8:42::12/64 | 192.168.42.1 |
| PC12 | Fa0 | 192.168.42.13 | 2001:db8:42::13/64 | 192.168.42.1 |

---

### Topology 6: Hybrid Topology (Star + Mesh)

#### Core Layer (Mesh Routers)

| Router | Interface | IPv4 Address | IPv6 Address | Connected To | Subnet |
|--------|-----------|--------------|--------------|--------------|--------|
| Core-R1 | Gi0/0 | 10.0.1.1 | 2001:db8:a::1/64 | Core-R2 | /30 |
| Core-R1 | Gi0/1 | 10.0.2.1 | 2001:db8:b::1/64 | Core-R3 | /30 |
| Core-R1 | Lo0 | 1.1.1.1 | 2001:db8:1::1/128 | OSPF Router ID | N/A |
| Core-R2 | Gi0/0 | 10.0.1.2 | 2001:db8:a::2/64 | Core-R1 | /30 |
| Core-R2 | Gi0/1 | 10.0.3.1 | 2001:db8:c::1/64 | Core-R3 | /30 |
| Core-R2 | Lo0 | 2.2.2.2 | 2001:db8:2::2/128 | OSPF Router ID | N/A |
| Core-R3 | Gi0/0 | 10.0.2.2 | 2001:db8:b::2/64 | Core-R1 | /30 |
| Core-R3 | Gi0/1 | 10.0.3.2 | 2001:db8:c::2/64 | Core-R2 | /30 |
| Core-R3 | Lo0 | 3.3.3.3 | 2001:db8:3::3/128 | OSPF Router ID | N/A |

#### Distribution Layer (Star Topology)

| Device | Interface | IPv4 Address | IPv6 Address | VLAN | Connected To |
|--------|-----------|--------------|--------------|------|--------------|
| Dist-SW1 | VLAN50 | 192.168.50.2 | 2001:db8:50::2/64 | 50 | Core-R1 Gi0/0 |
| Dist-SW1 | VLAN60 | 192.168.60.2 | 2001:db8:60::2/64 | 60 | Access layer |
| Dist-SW2 | VLAN50 | 192.168.50.3 | 2001:db8:50::3/64 | 50 | Core-R2 Gi0/0 |
| Dist-SW2 | VLAN61 | 192.168.61.2 | 2001:db8:61::2/64 | 61 | Access layer |
| Dist-SW3 | VLAN50 | 192.168.50.4 | 2001:db8:50::4/64 | 50 | Core-R3 Gi0/0 |
| Dist-SW3 | VLAN60 | 192.168.60.4 | 2001:db8:60::4/64 | 60 | Access layer |

#### Access Layer (Star Topology)

**Access-SW1 (Connected to Dist-SW1, VLAN 60):**

| Device | IPv4 Address | IPv6 Address | Gateway |
|--------|--------------|--------------|---------|
| PC1 | 192.168.60.10 | 2001:db8:60::10/64 | 192.168.60.1 |
| PC2 | 192.168.60.11 | 2001:db8:60::11/64 | 192.168.60.1 |
| PC3 | 192.168.60.12 | 2001:db8:60::12/64 | 192.168.60.1 |
| PC4 | 192.168.60.13 | 2001:db8:60::13/64 | 192.168.60.1 |

**Access-SW2 (Connected to Dist-SW2, VLAN 61):**

| Device | IPv4 Address | IPv6 Address | Gateway |
|--------|--------------|--------------|---------|
| PC5 | 192.168.61.10 | 2001:db8:61::10/64 | 192.168.61.1 |
| PC6 | 192.168.61.11 | 2001:db8:61::11/64 | 192.168.61.1 |
| PC7 | 192.168.61.12 | 2001:db8:61::12/64 | 192.168.61.1 |
| PC8 | 192.168.61.13 | 2001:db8:61::13/64 | 192.168.61.1 |

**Access-SW3 (Connected to Dist-SW3, VLAN 60):**

| Device | IPv4 Address | IPv6 Address | Gateway |
|--------|--------------|--------------|---------|
| PC9 | 192.168.60.20 | 2001:db8:60::20/64 | 192.168.60.1 |
| PC10 | 192.168.60.21 | 2001:db8:60::21/64 | 192.168.60.1 |
| PC11 | 192.168.60.22 | 2001:db8:60::22/64 | 192.168.60.1 |
| PC12 | 192.168.60.23 | 2001:db8:60::23/64 | 192.168.60.1 |

#### Server Farm (VLAN 50)

| Device | IPv4 Address | IPv6 Address | Service |
|--------|--------------|--------------|---------|
| Server1 | 192.168.50.10 | 2001:db8:50::10/64 | HTTP Server |
| Server2 | 192.168.50.11 | 2001:db8:50::11/64 | DNS Server |
| Server3 | 192.168.50.12 | 2001:db8:50::12/64 | DHCP Server |

#### Hybrid Topology Connection Summary

```
                [Server Farm VLAN 50]
                /        |        \
            [HTTP]    [DNS]     [DHCP]
              |         |         |
        [Core Mesh Layer - OSPF Dynamic Routing]
        R1 -------- R2
         \  \    /  /
          \  \  /  /
           \ Mesh /
           /  \  \
          /    \  \
        R3 ----------
         |     |    |
    [Dist-SW1][Dist-SW2][Dist-SW3]  <- Star Distribution
         |         |         |
      [Star]    [Star]    [Star]      <- Access Layer
    PC1-PC4    PC5-PC8    PC9-PC12
```

---

## VLAN Configuration

### All VLANs Overview

| VLAN ID | Name | Network (IPv4) | Network (IPv6) | Purpose | Topology |
|---------|------|----------------|----------------|---------|----------|
| 10 | BUS_NET | 192.168.10.0/24 | 2001:db8:10::/64 | Bus Topology | Bus |
| 20 | STAR_NET | 192.168.20.0/24 | 2001:db8:20::/64 | Star Topology | Star |
| 30 | RING_NET | 192.168.30.0/24 | 2001:db8:30::/64 | Ring Topology | Ring |
| 40 | DEPT_A | 192.168.40.0/24 | 2001:db8:40::/64 | Extended Star - Dept A | Extended Star |
| 41 | DEPT_B | 192.168.41.0/24 | 2001:db8:41::/64 | Extended Star - Dept B | Extended Star |
| 42 | DEPT_C | 192.168.42.0/24 | 2001:db8:42::/64 | Extended Star - Dept C | Extended Star |
| 50 | SERVERS | 192.168.50.0/24 | 2001:db8:50::/64 | Server Farm | Hybrid |
| 60 | DEPT_A_HY | 192.168.60.0/24 | 2001:db8:60::/64 | Hybrid - Dept A | Hybrid |
| 61 | DEPT_B_HY | 192.168.61.0/24 | 2001:db8:61::/64 | Hybrid - Dept B | Hybrid |
| 99 | MANAGEMENT | 192.168.99.0/24 | 2001:db8:99::/64 | Switch Management | All |

### VLAN Details

#### VLAN 10 (Bus Topology)
- Network: 192.168.10.0/24
- Gateway: 192.168.10.1
- DHCP Pool: 192.168.10.100 - 192.168.10.200
- IPv6: 2001:db8:10::/64

#### VLAN 20 (Star Topology)
- Network: 192.168.20.0/24
- Gateway: 192.168.20.1
- DNS Server: 192.168.20.5
- DHCP Pool: 192.168.20.20 - 192.168.20.99
- IPv6: 2001:db8:20::/64

#### VLAN 30 (Ring Topology)
- Network: 192.168.30.0/24
- Gateway: 192.168.30.1
- DHCP Pool: 192.168.30.100 - 192.168.30.200
- IPv6: 2001:db8:30::/64

#### VLAN 40, 41, 42 (Extended Star)
- VLAN 40: 192.168.40.0/24 | Gateway: 192.168.40.1 | IPv6: 2001:db8:40::/64
- VLAN 41: 192.168.41.0/24 | Gateway: 192.168.41.1 | IPv6: 2001:db8:41::/64
- VLAN 42: 192.168.42.0/24 | Gateway: 192.168.42.1 | IPv6: 2001:db8:42::/64

#### VLAN 50, 60, 61 (Hybrid Topology)
- VLAN 50 (Servers): 192.168.50.0/24 | Gateway: 192.168.50.100 | IPv6: 2001:db8:50::/64
- VLAN 60 (DEPT_A): 192.168.60.0/24 | Gateway: 192.168.60.1 | IPv6: 2001:db8:60::/64
- VLAN 61 (DEPT_B): 192.168.61.0/24 | Gateway: 192.168.61.1 | IPv6: 2001:db8:61::/64

---

## Server Configuration

### HTTP Server (All Topologies)

**Device Type:** Server-PT  
**Service:** HTTP/HTTPS

#### Star Topology HTTP Server
- **IPv4:** 192.168.20.5
- **IPv6:** 2001:db8:20::5/64
- **Gateway:** 192.168.20.1
- **DNS:** 192.168.20.5
- **Port:** 80 (HTTP), 443 (HTTPS)

**Configuration Steps:**
1. Desktop → IP Configuration
2. Set Static IPv4: 192.168.20.5 / 255.255.255.0
3. Set IPv6: 2001:db8:20::5/64
4. Services → HTTP → Enable
5. Edit index.html with content

**Sample HTML Content:**
```html
<html>
<head><title>Star Topology Server</title></head>
<body>
<h1>Welcome to Star Network</h1>
<p><b>HTTP Server</b></p>
<p>Server IP: 192.168.20.5</p>
<p>IPv6: 2001:db8:20::5</p>
<p>Topology: Star</p>
</body>
</html>
```

#### Hybrid Topology HTTP Server
- **IPv4:** 192.168.50.10
- **IPv6:** 2001:db8:50::10/64
- **Gateway:** 192.168.50.100
- **VLAN:** 50 (Server VLAN)

**HTML Content:**
```html
<html>
<head><title>Hybrid Network Server</title></head>
<body>
<h1>Welcome to Hybrid Topology Network</h1>
<p><b>Star + Mesh Configuration</b></p>
<p>Server IP: 192.168.50.10</p>
<p>IPv6: 2001:db8:50::10</p>
<p>Services: HTTP, DNS, DHCP</p>
<hr>
<h3>Network Information</h3>
<p>Core Layer: OSPF Mesh (3 Routers)</p>
<p>Distribution Layer: Star (3 Switches)</p>
<p>Access Layer: Star (12 PCs)</p>
</body>
</html>
```

---

### DNS Server Configuration

**Service:** Domain Name System

#### Star Topology DNS
- **IPv4:** 192.168.20.5
- **IPv6:** 2001:db8:20::5/64
- **Domain:** star.local

**DNS Records (Star):**
| Name | Type | IPv4 Address | IPv6 Address |
|------|------|-------------|-------------|
| www.star.local | A | 192.168.20.5 | N/A |
| www.star.local | AAAA | N/A | 2001:db8:20::5 |
| server.star.local | A | 192.168.20.5 | N/A |
| printer.star.local | A | 192.168.20.100 | N/A |

#### Hybrid Topology DNS
- **IPv4:** 192.168.50.11
- **IPv6:** 2001:db8:50::11/64
- **Domain:** hybrid.local

**DNS Records (Hybrid):**
| Name | Type | IPv4 Address | IPv6 Address |
|------|------|-------------|-------------|
| www.hybrid.local | A | 192.168.50.10 | N/A |
| www.hybrid.local | AAAA | N/A | 2001:db8:50::10 |
| server.hybrid.local | A | 192.168.50.10 | N/A |
| dns.hybrid.local | A | 192.168.50.11 | N/A |
| dhcp.hybrid.local | A | 192.168.50.12 | N/A |

**Configuration Steps:**
1. Services → DNS → Enable DNS Service
2. Add A Record: Enter name, select A, enter IPv4
3. Add AAAA Record: Enter name, select AAAA, enter IPv6
4. Configure clients to use DNS server

---

### DHCP Server Configuration

**Service:** Dynamic Host Configuration Protocol

#### Star Topology DHCP

**Pool Name:** STAR_POOL
- Network: 192.168.20.0/24
- Pool Start: 192.168.20.20
- Pool End: 192.168.20.99
- Subnet Mask: 255.255.255.0
- Default Gateway: 192.168.20.1
- DNS Server: 192.168.20.5
- Lease Time: 7 days

**Configuration (Router):**
```
Router(config)# ip dhcp pool STAR_POOL
Router(dhcp-config)# network 192.168.20.0 255.255.255.0
Router(dhcp-config)# default-router 192.168.20.1
Router(dhcp-config)# dns-server 192.168.20.5
Router(dhcp-config)# lease 7
Router(dhcp-config)# exit

Router(config)# ip dhcp excluded-address 192.168.20.1 192.168.20.19
```

#### Hybrid Topology DHCP

**Pool 1 - DEPT_A (VLAN 60):**
- Network: 192.168.60.0/24
- Pool Start: 192.168.60.100
- Default Gateway: 192.168.60.1
- DNS Server: 192.168.50.11

**Pool 2 - DEPT_B (VLAN 61):**
- Network: 192.168.61.0/24
- Pool Start: 192.168.61.100
- Default Gateway: 192.168.61.1
- DNS Server: 192.168.50.11

**Configuration (Router on Stick):**
```
! VLAN 60 Pool
Router(config)# ip dhcp pool DEPT_A_POOL
Router(dhcp-config)# network 192.168.60.0 255.255.255.0
Router(dhcp-config)# default-router 192.168.60.1
Router(dhcp-config)# dns-server 192.168.50.11
Router(dhcp-config)# lease 7
Router(dhcp-config)# exit

! VLAN 61 Pool
Router(config)# ip dhcp pool DEPT_B_POOL
Router(dhcp-config)# network 192.168.61.0 255.255.255.0
Router(dhcp-config)# default-router 192.168.61.1
Router(dhcp-config)# dns-server 192.168.50.11
Router(dhcp-config)# lease 7
Router(dhcp-config)# exit

! Exclude gateway and server IPs
Router(config)# ip dhcp excluded-address 192.168.60.1 192.168.60.10
Router(config)# ip dhcp excluded-address 192.168.61.1 192.168.61.10
```

---

## Security Implementation

### 1. Port Security

**Purpose:** Prevent unauthorized devices from accessing network

**Configuration:**
```
! Enable port security on access ports
Switch(config)# interface range fa0/1-20
Switch(config-if-range)# switchport mode access
Switch(config-if-range)# switchport port-security
Switch(config-if-range)# switchport port-security maximum 2
Switch(config-if-range)# switchport port-security mac-address sticky
Switch(config-if-range)# switchport port-security violation restrict
Switch(config-if-range)# exit

! Verify configuration
Switch# show port-security
Switch# show port-security address
```

**Violation Actions:**
- **Shutdown:** Port goes down (default)
- **Restrict:** Packets dropped, violations logged
- **Protect:** Packets silently dropped

---

### 2. VLAN Security

**Native VLAN Change:**
```
Switch(config)# interface gi0/1
Switch(config-if)# switchport trunk native vlan 99
Switch(config-if)# exit

! Verify trunk configuration
Switch# show interfaces trunk
```

**Disable Unused Ports:**
```
Switch(config)# interface range fa0/21-24
Switch(config-if-range)# shutdown
Switch(config-if-range)# exit
```

---

### 3. Password Security

**Basic Configuration:**
```
Switch(config)# hostname Core-Switch
Core-Switch(config)# service password-encryption

! Enable secret (encrypted password)
Core-Switch(config)# enable secret Cisco123!

! Console line password
Core-Switch(config)# line console 0
Core-Switch(config-line)# password Console123!
Core-Switch(config-line)# login
Core-Switch(config-line)# exit

! VTY line password (Telnet/SSH)
Core-Switch(config)# line vty 0 4
Core-Switch(config-line)# password VTY123!
Core-Switch(config-line)# login
Core-Switch(config-line)# exit
```

---

### 4. SSH Configuration (Secure Remote Access)

**Enable SSH:**
```
Router(config)# ip domain-name company.local
Router(config)# crypto key generate rsa
! When prompted, choose 1024 bits

Router(config)# ip ssh version 2
Router(config)# ip ssh timeout 60
Router(config)# ip ssh authentication-retries 3

! Create local user account
Router(config)# username admin privilege 15 secret Admin123!

! Configure VTY for SSH only
Router(config)# line vty 0 4
Router(config-line)# transport input ssh
Router(config-line)# login local
Router(config-line)# exec-timeout 15 0
Router(config-line)# exit

Router(config)# exit
Router# write memory
```

---

### 5. Access Control Lists (ACLs)

**Standard ACL - Filter by source IP:**
```
Router(config)# access-list 10 permit 192.168.20.0 0.0.0.255
Router(config)# access-list 10 permit 192.168.30.0 0.0.0.255
Router(config)# access-list 10 deny any

Router(config)# interface gi0/0
Router(config-if)# ip access-group 10 in
Router(config-if)# exit
```

**Extended ACL - Allow HTTP/HTTPS to Server:**
```
Router(config)# access-list 100 permit tcp any host 192.168.20.5 eq 80
Router(config)# access-list 100 permit tcp any host 192.168.20.5 eq 443
Router(config)# access-list 100 permit icmp any any echo-request
Router(config)# access-list 100 deny ip any any

Router(config)# interface gi0/1
Router(config-if)# ip access-group 100 in
Router(config-if)# exit
```

**Verify ACLs:**
```
Switch# show access-lists
Switch# show ip access-lists
```

---

## Router and Switch Configuration

### Basic Router Setup

**Initial Configuration:**
```
Router> enable
Router# configure terminal
Router(config)# hostname Core-Router

! Set domain name
Core-Router(config)# ip domain-name company.local

! Enable IPv6 routing
Core-Router(config)# ipv6 unicast-routing

! Save configuration
Core-Router(config)# exit
Core-Router# write memory
```

### Interface Configuration (Single VLAN)

**For Star Topology:**
```
Star-Router(config)# interface gi0/0
Star-Router(config-if)# ip address 192.168.20.1 255.255.255.0
Star-Router(config-if)# ipv6 address 2001:db8:20::1/64
Star-Router(config-if)# no shutdown
Star-Router(config-if)# exit
```

### Router-on-a-Stick (Inter-VLAN Routing)

**For Extended Star and Hybrid Topologies:**
```
Router(config)# interface gi0/0
Router(config-if)# no shutdown
Router(config-if)# exit

! Subinterface for VLAN 40
Router(config)# interface gi0/0.40
Router(config-subif)# encapsulation dot1Q 40
Router(config-subif)# ip address 192.168.40.1 255.255.255.0
Router(config-subif)# ipv6 address 2001:db8:40::1/64
Router(config-subif)# exit

! Subinterface for VLAN 41
Router(config)# interface gi0/0.41
Router(config-subif)# encapsulation dot1Q 41
Router(config-subif)# ip address 192.168.41.1 255.255.255.0
Router(config-subif)# ipv6 address 2001:db8:41::1/64
Router(config-subif)# exit

! Subinterface for VLAN 42
Router(config)# interface gi0/0.42
Router(config-subif)# encapsulation dot1Q 42
Router(config-subif)# ip address 192.168.42.1 255.255.255.0
Router(config-subif)# ipv6 address 2001:db8:42::1/64
Router(config-subif)# exit
```

**Switch Trunk Configuration:**
```
Switch(config)# interface gi0/1
Switch(config-if)# switchport trunk encapsulation dot1q
Switch(config-if)# switchport mode trunk
Switch(config-if)# switchport trunk allowed vlan 40,41,42
Switch(config-if)# exit
```

### OSPF Configuration (Mesh Topology)

**Router 1:**
```
R1(config)# router ospf 1
R1(config-router)# router-id 1.1.1.1
R1(config-router)# network 10.0.1.0 0.0.0.3 area 0
R1(config-router)# network 10.0.2.0 0.0.0.3 area 0
R1(config-router)# network 10.0.3.0 0.0.0.3 area 0
R1(config-router)# exit

! OSPFv3 for IPv6
R1(config)# ipv6 router ospf 1
R1(config-rtr)# router-id 1.1.1.1
R1(config-rtr)# exit

R1(config)# interface gi0/0
R1(config-if)# ipv6 ospf 1 area 0
R1(config-if)# exit

R1(config)# interface gi0/1
R1(config-if)# ipv6 ospf 1 area 0
R1(config-if)# exit
```

**Verify OSPF:**
```
R1# show ip ospf neighbor
R1# show ip ospf interface brief
R1# show ip route ospf
R1# show ipv6 ospf neighbor
```

### Spanning Tree Protocol (Ring Topology)

**Enable Rapid PVST+:**
```
Switch(config)# spanning-tree mode rapid-pvst

! Set root bridge priority
Switch(config)# spanning-tree vlan 30 priority 4096

! Enable BPDU Guard on access ports
Switch(config)# interface range fa0/1-20
Switch(config-if-range)# spanning-tree portfast
Switch(config-if-range)# spanning-tree bpduguard enable
Switch(config-if-range)# exit

! Verify STP status
Switch# show spanning-tree vlan 30
Switch# show spanning-tree summary
```

---

## Testing and Verification

### Connectivity Tests

#### 1. Ping Test (IPv4)
```
PC> ping 192.168.20.1
PC> ping 192.168.20.5
PC> ping 192.168.30.11
```

**Expected Results:**
- Reply from destination
- 0% packet loss
- Round-trip time < 10ms

#### 2. Ping Test (IPv6)
```
PC> ping 2001:db8:20::1
PC> ping 2001:db8:20::5
PC> ping 2001:db8:30::11
```

#### 3. Traceroute Test
```
PC> tracert 192.168.50.10
PC> tracert 2001:db8:50::10
```

**Expected:** Shows all hops from source to destination

#### 4. DNS Resolution
```
PC> nslookup www.star.local
PC> nslookup www.hybrid.local
PC> nslookup server.hybrid.local
```

#### 5. DHCP Verification
```
PC> ipconfig /release
PC> ipconfig /renew
PC> ipconfig /all
```

**Check for:**
- IP in correct VLAN subnet
- Correct subnet mask
- Gateway assigned
- DNS server assigned

#### 6. HTTP Access
- Open web browser
- Navigate to: `http://192.168.20.5`
- Navigate to: `http://www.star.local`
- Verify webpage loads

### Switch Verification Commands

```
! View all VLANs
Switch# show vlan brief

! View trunk ports
Switch# show interfaces trunk

! View port security
Switch# show port-security
Switch# show port-security address

! View spanning tree
Switch# show spanning-tree
Switch# show spanning-tree vlan 30

! View MAC address table
Switch# show mac-address-table
```

### Router Verification Commands

```
! View interface status
Router# show ip interface brief
Router# show ipv6 interface brief

! View routing table
Router# show ip route
Router# show ipv6 route

! View OSPF information
Router# show ip ospf neighbor
Router# show ip ospf interface
Router# show ip ospf database

! View DHCP bindings
Router# show ip dhcp binding

! View ACLs
Router# show access-lists
Router# show ip access-lists

! View configuration
Router# show running-config
Router# show startup-config
```

---

## Troubleshooting Guide

### Issue 1: DHCP Not Assigning Addresses

**Problem:** PCs getting 169.254.x.x (APIPA) addresses

**Solution:**
```
! Check DHCP pool configuration
Router# show ip dhcp pool

! Verify DHCP is enabled
Router# show ip dhcp statistics

! Check if helper address is needed
Router(config)# interface gi0/0
Router(config-if)# ip helper-address 192.168.50.12
```

### Issue 2: No Connectivity Between VLANs

**Problem:** PCs in different VLANs cannot communicate

**Solution:**
```
! Verify router subinterfaces exist
Router# show ip interface brief

! Check trunk port configuration
Switch# show interfaces trunk

! Verify routing protocol is working
Router# show ip route
```

### Issue 3: OSPF Not Forming Adjacency

**Problem:** OSPF neighbors not showing in mesh topology

**Solution:**
```
! Verify OSPF is enabled
Router# show ip ospf process

! Check OSPF interface configuration
Router# show ip ospf interface

! Verify network is advertised
Router# show ip ospf database

! Check for MTU mismatch
Router# show ip interface gi0/0
```

### Issue 4: Spanning Tree Loop

**Problem:** Broadcast storm in ring topology

**Solution:**
```
! Verify STP is running
Switch# show spanning-tree summary

! Check blocked ports
Switch# show spanning-tree detail

! Verify PortFast on access ports
Switch# show spanning-tree interface portfast
```

### Issue 5: IPv6 Not Working

**Problem:** IPv6 addresses configured but no connectivity

**Solution:**
```
! Enable IPv6 routing on router
Router(config)# ipv6 unicast-routing

! Verify IPv6 is enabled on interface
Router# show ipv6 interface brief

! Check IPv6 routes
Router# show ipv6 route

! Enable IPv6 on OSPF
Router(config)# ipv6 router ospf 1
```

---

## Challenges and Solutions Encountered

### Challenge 1: Clock Rate on Serial Interfaces

**Problem:** Serial interface wouldn't come up in mesh topology

**Error Message:** "Interface is down"

**Root Cause:** Serial interfaces need clock rate configuration on DCE (Data Communications Equipment) side

**Solution:**
```
! On DCE side (Router1 Serial)
Router1(config)# interface serial 0/0/0
Router1(config-if)# clock rate 64000
Router1(config-if)# no shutdown
```

---

### Challenge 2: VLAN Routing Not Working

**Problem:** PCs in different VLANs couldn't ping each other

**Root Cause:** Router subinterface wasn't created or trunk port wasn't configured

**Solution:**
- Created subinterfaces on router for each VLAN
- Configured switch port as trunk
- Ensured encapsulation type matched (dot1Q)
- Verified VLAN was allowed on trunk

---

### Challenge 3: OSPF Neighbors Not Forming

**Problem:** "show ip ospf neighbor" showed empty table

**Root Cause:** Network statements weren't matching connected interfaces

**Solution:**
- Double-checked IP addresses on serial/gigabit interfaces
- Verified network statements in OSPF configuration
- Checked for routing protocol process was running
- Ensured all interfaces had "no shutdown" enabled

---

### Challenge 4: DNS Not Resolving

**Problem:** nslookup commands failed

**Root Cause:** DNS server not enabled or DNS address not configured on clients

**Solution:**
- Enabled DNS service on server
- Added DNS records (A and AAAA)
- Configured clients to use correct DNS server IP
- Tested with nslookup command

---

### Challenge 5: Port Security Blocking Legitimate Devices

**Problem:** Valid devices getting disconnected

**Root Cause:** Maximum MAC addresses set too low (sticky learning)

**Solution:**
```
! Adjusted maximum MAC addresses
Switch(config-if)# switchport port-security maximum 3

! Used restrict violation instead of shutdown
Switch(config-if)# switchport port-security violation restrict
```

---

## Performance Metrics

### Expected Latency by Topology

| Topology | Expected RTT | Notes |
|----------|-------------|-------|
| Bus | < 5ms | Single hop |
| Mesh | < 10ms | Multiple redundant paths |
| Star | < 5ms | Central switch |
| Ring | < 8ms | Depends on STP blocked ports |
| Extended Star | < 10ms | Multi-hop through hierarchy |
| Hybrid | < 15ms | Multiple layers, but optimized |

### Packet Loss

**Expected:** 0% packet loss on all topologies under normal operation

### Convergence Time (for failures)

| Topology | Convergence Time |
|----------|-----------------|
| Bus | N/A (no redundancy) |
| Mesh (OSPF) | 5-15 seconds |
| Ring (STP) | 30-50 seconds |
| Hybrid (OSPF) | 5-15 seconds |

---

## Files in This Repository

```
network-topology-project/
│
├── README.md                          # This file
│
├── configurations/
│   ├── bus-topology.txt               # Bus topology CLI commands
│   ├── mesh-topology.txt              # Mesh topology OSPF config
│   ├── star-topology.txt              # Star topology configuration
│   ├── ring-topology.txt              # Ring topology STP config
│   ├── extended-star-topology.txt     # Extended star configuration
│   └── hybrid-topology.txt            # Hybrid star+mesh config
│
├── ip-tables/
│   ├── bus-ip-table.csv               # Bus topology IPs
│   ├── mesh-ip-table.csv              # Mesh topology IPs
│   ├── star-ip-table.csv              # Star topology IPs
│   ├── ring-ip-table.csv              # Ring topology IPs
│   ├── extended-star-ip-table.csv     # Extended star IPs
│   ├── hybrid-ip-table.csv            # Hybrid topology IPs
│   └── all-vlan-summary.csv           # Complete VLAN table
│
├── packet-tracer-files/
│   ├── bus-topology.pkt               # Packet Tracer file
│   ├── mesh-topology.pkt              # Packet Tracer file
│   ├── star-topology.pkt              # Packet Tracer file
│   ├── ring-topology.pkt              # Packet Tracer file
│   ├── extended-star-topology.pkt     # Packet Tracer file
│   └── hybrid-topology.pkt            # Packet Tracer file
│
├── screenshots/
│   ├── topology1_bus_overview.png     # Bus topology diagram
│   ├── topology2_mesh_routing.png     # Mesh with OSPF
│   ├── topology3_star_vlan.png        # Star with VLAN config
│   ├── topology4_ring_stp.png         # Ring with STP
│   ├── topology5_extended_star.png    # Extended star hierarchy
│   ├── topology6_hybrid_full.png      # Hybrid complete view
│   ├── ping_test_ipv4.png             # IPv4 connectivity test
│   ├── ping_test_ipv6.png             # IPv6 connectivity test
│   ├── http_server_test.png           # HTTP server access
│   ├── dns_resolution_test.png        # DNS testing
│   ├── ospf_neighbor_table.png        # OSPF neighbors
│   ├── spanning_tree_status.png       # STP blocking info
│   ├── dhcp_binding_table.png         # DHCP assignments
│   ├── port_security_config.png       # Port security settings
│   └── acl_configuration.png          # ACL rules
│
├── scripts/
│   ├── test-connectivity.sh           # Bash script for testing
│   ├── verify-config.sh               # Configuration verification
│   └── generate-report.sh             # Automated report generator
│
└── docs/
    ├── VLAN-SEGMENTATION.md           # VLAN design details
    ├── ROUTING-PROTOCOLS.md           # OSPF configuration guide
    ├── SECURITY-POLICIES.md           # Security implementation
    ├── TROUBLESHOOTING.md             # Troubleshooting guide
    └── BEST-PRACTICES.md              # Network design best practices
```

---

## How to Use This Documentation

### For Students
1. Read the topology overview section
2. Study the IP address tables for your topology
3. Follow the step-by-step Packet Tracer configuration
4. Test connectivity using provided commands
5. Document your findings with screenshots

### For Implementation
1. Access the configuration files directory
2. Copy commands from relevant topology file
3. Paste into Packet Tracer CLI
4. Verify using provided test commands
5. Take screenshots for documentation

### For Troubleshooting
1. Check if connectivity works (ping test)
2. Review verification commands section
3. Check challenges and solutions
4. Review troubleshooting guide
5. Examine sample configurations

---

## Key Takeaways

✅ **Bus Topology:** Simple but limited; single point of failure  
✅ **Mesh Topology:** Highly redundant; expensive but reliable  
✅ **Star Topology:** Industry standard; easy to manage  
✅ **Ring Topology:** Predictable but requires STP to prevent loops  
✅ **Extended Star:** Hierarchical and scalable  
✅ **Hybrid:** Best of both worlds; enterprise-ready  

All topologies support:
- Dual-stack IPv4/IPv6
- VLAN segmentation
- Server services (HTTP/DNS/DHCP)
- Security measures (port security, ACLs, SSH)
- Dynamic routing (OSPF where applicable)

---

## References

- Cisco IOS Command Summary: https://www.cisco.com
- IPv6 Documentation: https://www.iana.org
- RFC Standards for Network Protocols
- Cisco Packet Tracer Documentation

---

## Author Notes

**Created:** 2025  
**Packet Tracer Version:** 8.2+  
**Last Updated:** 2025  

This documentation covers all aspects of implementing six network topologies with comprehensive IPv4/IPv6 configuration, VLAN segmentation, and security measures. Each topology serves different use cases and demonstrates various networking concepts.

For questions or clarifications, refer to the troubleshooting section or review the Packet Tracer configuration files provided.
