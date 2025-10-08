# Network Topology Project Documentation

## Project Overview
This project demonstrates the implementation of five fundamental network topologies (Bus, Mesh, Star, Ring, and Extended Star) and one Hybrid topology using Cisco Packet Tracer. Each topology is configured with dual-stack networking (IPv4 and IPv6), VLAN segmentation, server services, and basic security measures.

**Tools Used:** Cisco Packet Tracer 8.2+

---

## Table of Contents
- [Topologies Implemented](#topologies-implemented)
- [IP Address Tables](#ip-address-tables)
- [VLAN Configuration](#vlan-configuration)
- [Server Configuration](#server-configuration)
- [Security Implementation](#security-implementation)
- [Router and Switch Configuration](#router-and-switch-configuration)
- [Testing and Verification](#testing-and-verification)
- [Screenshots](#screenshots)
- [Challenges and Solutions](#challenges-and-solutions)

---

## Topologies Implemented

### 1. Bus Topology
**Description:** All devices connected to a single central cable using a switch to simulate bus behavior.

**Devices Used:**
- 1x Switch (2960)
- 5x PCs
- Straight-through cables

**Configuration:**
- All PCs connected to single switch
- VLAN 10 (192.168.10.0/24)
- No redundancy (simulates traditional bus limitations)

**Use Case:** Small office network with limited budget

---

### 2. Mesh Topology
**Description:** Full mesh with every router connected to every other router for maximum redundancy.

**Devices Used:**
- 4x Routers (2911)
- Connections between each router pair (6 total connections)

**Configuration:**
- Router1: 10.1.0.1/30 (to R2), 10.2.0.1/30 (to R3), 10.3.0.1/30 (to R4)
- Router2: 10.1.0.2/30 (to R1), 10.4.0.1/30 (to R3), 10.5.0.1/30 (to R4)
- Router3: 10.2.0.2/30 (to R1), 10.4.0.2/30 (to R2), 10.6.0.1/30 (to R4)
- Router4: 10.3.0.2/30 (to R1), 10.5.0.2/30 (to R2), 10.6.0.2/30 (to R3)
- Dynamic routing: OSPF enabled

**Use Case:** Enterprise core network requiring high availability

---

### 3. Star Topology
**Description:** Central switch with all devices connected directly to it.

**Devices Used:**
- 1x Central Switch (2960)
- 8x PCs
- 1x Server
- 1x Printer

**Configuration:**
- Central Switch: Core-Switch-01
- VLAN 20 (192.168.20.0/24)
- All devices connect to single switch

**Use Case:** Standard office or lab network

---

### 4. Ring Topology
**Description:** Devices connected in a circular configuration using switches.

**Devices Used:**
- 4x Switches (2960)
- 4x PCs (one per switch)
- Serial connections forming ring

**Configuration:**
- Switch1 → Switch2 → Switch3 → Switch4 → Switch1
- VLAN 30 configured across all switches
- Spanning Tree Protocol enabled to prevent loops

**Use Case:** Building floor network with redundancy

---

### 5. Extended Star Topology
**Description:** Hierarchical design with central core switch and multiple distribution switches.

**Devices Used:**
- 1x Core Switch (3560)
- 3x Distribution Switches (2960)
- 12x PCs (4 per distribution switch)

**Configuration:**
- Core switch connects to 3 distribution switches
- Each distribution switch serves 4 endpoints
- VLANs: 40, 41, 42 for each distribution switch

**Use Case:** Multi-department organization

---

### 6. Hybrid Topology
**Description:** Integrated topology combining Star (user access), Mesh (core routing), and Ring (backup paths).

**Components:**
- **Star Component:** 3 access switches with 4 PCs each
- **Mesh Component:** 3 core routers fully meshed
- **Ring Component:** Distribution switches in ring configuration

**Devices Used:**
- 3x Core Routers (2911) - Full mesh
- 4x Distribution Switches (2960) - Ring
- 3x Access Switches (2960) - Star
- 12x PCs
- 3x Servers

**Use Case:** Enterprise campus network

---

## IP Address Tables

### Topology 1: Bus Topology
| Device | Interface | IPv4 Address | IPv6 Address | Subnet Mask | Default Gateway |
|--------|-----------|--------------|--------------|-------------|-----------------|
| PC1 | Fa0 | 192.168.10.10 | 2001:db8:10::10/64 | 255.255.255.0 | 192.168.10.1 |
| PC2 | Fa0 | 192.168.10.11 | 2001:db8:10::11/64 | 255.255.255.0 | 192.168.10.1 |
| PC3 | Fa0 | 192.168.10.12 | 2001:db8:10::12/64 | 255.255.255.0 | 192.168.10.1 |
| PC4 | Fa0 | 192.168.10.13 | 2001:db8:10::13/64 | 255.255.255.0 | 192.168.10.1 |
| PC5 | Fa0 | 192.168.10.14 | 2001:db8:10::14/64 | 255.255.255.0 | 192.168.10.1 |
| Switch1 | VLAN10 | 192.168.10.1 | 2001:db8:10::1/64 | 255.255.255.0 | - |

### Topology 2: Mesh Topology
| Device | Interface | IPv4 Address | IPv6 Address | Subnet |
|--------|-----------|--------------|--------------|--------|
| Router1 | Gi0/0 (to R2) | 10.1.0.1 | 2001:db8:1::1/64 | /30 |
| Router1 | Gi0/1 (to R3) | 10.2.0.1 | 2001:db8:2::1/64 | /30 |
| Router1 | Gi0/2 (to R4) | 10.3.0.1 | 2001:db8:3::1/64 | /30 |
| Router2 | Gi0/0 (to R1) | 10.1.0.2 | 2001:db8:1::2/64 | /30 |
| Router2 | Gi0/1 (to R3) | 10.4.0.1 | 2001:db8:4::1/64 | /30 |
| Router2 | Gi0/2 (to R4) | 10.5.0.1 | 2001:db8:5::1/64 | /30 |
| Router3 | Gi0/0 (to R1) | 10.2.0.2 | 2001:db8:2::2/64 | /30 |
| Router3 | Gi0/1 (to R2) | 10.4.0.2 | 2001:db8:4::2/64 | /30 |
| Router3 | Gi0/2 (to R4) | 10.6.0.1 | 2001:db8:6::1/64 | /30 |
| Router4 | Gi0/0 (to R1) | 10.3.0.2 | 2001:db8:3::2/64 | /30 |
| Router4 | Gi0/1 (to R2) | 10.5.0.2 | 2001:db8:5::2/64 | /30 |
| Router4 | Gi0/2 (to R3) | 10.6.0.2 | 2001:db8:6::2/64 | /30 |

### Topology 3: Star Topology
| Device | Interface | IPv4 Address | IPv6 Address | VLAN | Default Gateway |
|--------|-----------|--------------|--------------|------|-----------------|
| PC1 | Fa0 | 192.168.20.10 | 2001:db8:20::10/64 | 20 | 192.168.20.1 |
| PC2 | Fa0 | 192.168.20.11 | 2001:db8:20::11/64 | 20 | 192.168.20.1 |
| PC3 | Fa0 | 192.168.20.12 | 2001:db8:20::12/64 | 20 | 192.168.20.1 |
| PC4 | Fa0 | 192.168.20.13 | 2001:db8:20::13/64 | 20 | 192.168.20.1 |
| Server1 | Fa0 | 192.168.20.5 | 2001:db8:20::5/64 | 20 | 192.168.20.1 |
| Printer1 | Fa0 | 192.168.20.100 | 2001:db8:20::100/64 | 20 | 192.168.20.1 |
| Router1 | Gi0/0 | 192.168.20.1 | 2001:db8:20::1/64 | - | - |

### Topology 4: Ring Topology
| Device | Interface | IPv4 Address | VLAN | Connected To |
|--------|-----------|--------------|------|--------------|
| Switch1 | VLAN30 | 192.168.30.2 | 30 | - |
| Switch1 | Fa0/1 | - | Trunk | Switch2 |
| Switch2 | VLAN30 | 192.168.30.3 | 30 | - |
| Switch2 | Fa0/1 | - | Trunk | Switch3 |
| Switch3 | VLAN30 | 192.168.30.4 | 30 | - |
| Switch3 | Fa0/1 | - | Trunk | Switch4 |
| Switch4 | VLAN30 | 192.168.30.5 | 30 | - |
| Switch4 | Fa0/1 | - | Trunk | Switch1 |
| PC1 | Fa0 | 192.168.30.10 | 30 | 192.168.30.1 |
| PC2 | Fa0 | 192.168.30.11 | 30 | 192.168.30.1 |
| PC3 | Fa0 | 192.168.30.12 | 30 | 192.168.30.1 |
| PC4 | Fa0 | 192.168.30.13 | 30 | 192.168.30.1 |

### Topology 5: Extended Star Topology
| Device | Interface | IPv4 Address | IPv6 Address | VLAN | Gateway |
|--------|-----------|--------------|--------------|------|---------|
| Core-Switch | VLAN40 | 192.168.40.1 | 2001:db8:40::1/64 | 40 | - |
| Core-Switch | VLAN41 | 192.168.41.1 | 2001:db8:41::1/64 | 41 | - |
| Core-Switch | VLAN42 | 192.168.42.1 | 2001:db8:42::1/64 | 42 | - |
| Dist-SW1 | VLAN40 | 192.168.40.2 | 2001:db8:40::2/64 | 40 | 192.168.40.1 |
| Dist-SW2 | VLAN41 | 192.168.41.2 | 2001:db8:41::2/64 | 41 | 192.168.41.1 |
| Dist-SW3 | VLAN42 | 192.168.42.2 | 2001:db8:42::2/64 | 42 | 192.168.42.1 |
| PC1-PC4 | Fa0 | 192.168.40.10-13 | 2001:db8:40::10-13/64 | 40 | 192.168.40.1 |
| PC5-PC8 | Fa0 | 192.168.41.10-13 | 2001:db8:41::10-13/64 | 41 | 192.168.41.1 |
| PC9-PC12 | Fa0 | 192.168.42.10-13 | 2001:db8:42::10-13/64 | 42 | 192.168.42.1 |

### Topology 6: Hybrid Topology
| Device | Interface | IPv4 Address | IPv6 Address | VLAN/Area | Notes |
|--------|-----------|--------------|--------------|-----------|-------|
| Core-R1 | Gi0/0 | 10.0.1.1/30 | 2001:db8:a::1/64 | OSPF Area 0 | To Core-R2 |
| Core-R1 | Gi0/1 | 10.0.2.1/30 | 2001:db8:b::1/64 | OSPF Area 0 | To Core-R3 |
| Core-R2 | Gi0/0 | 10.0.1.2/30 | 2001:db8:a::2/64 | OSPF Area 0 | To Core-R1 |
| Core-R2 | Gi0/1 | 10.0.3.1/30 | 2001:db8:c::1/64 | OSPF Area 0 | To Core-R3 |
| Core-R3 | Gi0/0 | 10.0.2.2/30 | 2001:db8:b::2/64 | OSPF Area 0 | To Core-R1 |
| Core-R3 | Gi0/1 | 10.0.3.2/30 | 2001:db8:c::2/64 | OSPF Area 0 | To Core-R2 |
| HTTP-Server | Fa0 | 192.168.50.10 | 2001:db8:50::10/64 | VLAN 50 | Web Server |
| DNS-Server | Fa0 | 192.168.50.11 | 2001:db8:50::11/64 | VLAN 50 | DNS Server |
| DHCP-Server | Fa0 | 192.168.50.12 | 2001:db8:50::12/64 | VLAN 50 | DHCP Server |

---

## VLAN Configuration

### VLAN Table
| VLAN ID | Name | Network (IPv4) | Network (IPv6) | Purpose |
|---------|------|----------------|----------------|---------|
| 10 | BUS_NET | 192.168.10.0/24 | 2001:db8:10::/64 | Bus Topology |
| 20 | STAR_NET | 192.168.20.0/24 | 2001:db8:20::/64 | Star Topology |
| 30 | RING_NET | 192.168.30.0/24 | 2001:db8:30::/64 | Ring Topology |
| 40 | DEPT_A | 192.168.40.0/24 | 2001:db8:40::/64 | Extended Star - Dept A |
| 41 | DEPT_B | 192.168.41.0/24 | 2001:db8:41::/64 | Extended Star - Dept B |
| 42 | DEPT_C | 192.168.42.0/24 | 2001:db8:42::/64 | Extended Star - Dept C |
| 50 | SERVERS | 192.168.50.0/24 | 2001:db8:50::/64 | Server Farm |
| 99 | MANAGEMENT | 192.168.99.0/24 | 2001:db8:99::/64 | Switch Management |

### Switch VLAN Configuration Example
```
! Create VLANs
Switch(config)# vlan 10
Switch(config-vlan)# name BUS_NET
Switch(config-vlan)# exit

Switch(config)# vlan 20
Switch(config-vlan)# name STAR_NET
Switch(config-vlan)# exit

Switch(config)# vlan 50
Switch(config-vlan)# name SERVERS
Switch(config-vlan)# exit

! Assign ports to VLANs
Switch(config)# interface range fa0/1-10
Switch(config-if-range)# switchport mode access
Switch(config-if-range)# switchport access vlan 10
Switch(config-if-range)# exit

! Configure trunk port
Switch(config)# interface gi0/1
Switch(config-if)# switchport mode trunk
Switch(config-if)# switchport trunk allowed vlan 10,20,50
Switch(config-if)# exit
```

---

## Server Configuration

### HTTP Server Configuration
**Device:** Server-PT  
**IPv4:** 192.168.50.10  
**IPv6:** 2001:db8:50::10

**Steps in Packet Tracer:**
1. Click on Server → Desktop → IP Configuration
2. Set Static IP: 192.168.50.10 / 255.255.255.0
3. Gateway: 192.168.50.1
4. IPv6: 2001:db8:50::10/64
5. Go to Services → HTTP
6. Enable HTTP and HTTPS
7. Edit index.html with custom content:
```html
<html>
<head><title>Company Intranet</title></head>
<body>
<h1>Welcome to Our Network</h1>
<p>This is a demonstration HTTP server.</p>
</body>
</html>
```

### DNS Server Configuration
**Device:** Server-PT  
**IPv4:** 192.168.50.11  
**IPv6:** 2001:db8:50::11

**DNS Records:**
| Name | Type | Address |
|------|------|---------|
| www.company.local | A | 192.168.50.10 |
| www.company.local | AAAA | 2001:db8:50::10 |
| dns.company.local | A | 192.168.50.11 |
| dhcp.company.local | A | 192.168.50.12 |

**Steps in Packet Tracer:**
1. Services → DNS → Enable DNS Service
2. Add A Record: www.company.local → 192.168.50.10
3. Add AAAA Record: www.company.local → 2001:db8:50::10
4. Set DNS server on clients to 192.168.50.11

### DHCP Server Configuration
**Device:** Server-PT or Router  
**IPv4:** 192.168.50.12

**DHCP Pools:**
```
! On Router
Router(config)# ip dhcp pool VLAN10
Router(dhcp-config)# network 192.168.10.0 255.255.255.0
Router(dhcp-config)# default-router 192.168.10.1
Router(dhcp-config)# dns-server 192.168.50.11
Router(dhcp-config)# lease 7
Router(dhcp-config)# exit

Router(config)# ip dhcp pool VLAN20
Router(dhcp-config)# network 192.168.20.0 255.255.255.0
Router(dhcp-config)# default-router 192.168.20.1
Router(dhcp-config)# dns-server 192.168.50.11
Router(dhcp-config)# exit

! Exclude static addresses
Router(config)# ip dhcp excluded-address 192.168.10.1 192.168.10.20
Router(config)# ip dhcp excluded-address 192.168.20.1 192.168.20.20
```

**On Server-PT:**
1. Services → DHCP → Enable DHCP
2. Pool Name: VLAN10-POOL
3. Default Gateway: 192.168.10.1
4. DNS Server: 192.168.50.11
5. Start IP: 192.168.10.100
6. Subnet Mask: 255.255.255.0
7. Max Users: 50

---

## Security Implementation

### 1. Port Security
**Purpose:** Prevent unauthorized devices from connecting

```
! Configure port security on access ports
Switch(config)# interface fa0/1
Switch(config-if)# switchport mode access
Switch(config-if)# switchport port-security
Switch(config-if)# switchport port-security maximum 2
Switch(config-if)# switchport port-security mac-address sticky
Switch(config-if)# switchport port-security violation restrict
Switch(config-if)# exit

! Apply to multiple ports
Switch(config)# interface range fa0/1-20
Switch(config-if-range)# switchport port-security
Switch(config-if-range)# switchport port-security maximum 1
Switch(config-if-range)# switchport port-security violation shutdown
```

### 2. VLAN Security
**Purpose:** Segment network traffic

```
! Disable unused ports
Switch(config)# interface range fa0/21-24
Switch(config-if-range)# shutdown
Switch(config-if-range)# exit

! Change native VLAN
Switch(config)# interface gi0/1
Switch(config-if)# switchport trunk native vlan 99
Switch(config-if)# exit
```

### 3. Password Security
```
! Enable password encryption
Switch(config)# service password-encryption

! Set enable secret
Switch(config)# enable secret Cisco123!

! Console password
Switch(config)# line console 0
Switch(config-line)# password Console123!
Switch(config-line)# login
Switch(config-line)# exit

! VTY (Telnet/SSH) password
Switch(config)# line vty 0 4
Switch(config-line)# password VTY123!
Switch(config-line)# login
Switch(config-line)# exit

! Set hostname and domain
Switch(config)# hostname Core-Switch
Core-Switch(config)# ip domain-name company.local
```

### 4. SSH Configuration (Instead of Telnet)
```
! Generate RSA keys
Router(config)# crypto key generate rsa
! Choose 1024 bits when prompted

! Configure SSH
Router(config)# ip ssh version 2
Router(config)# line vty 0 4
Router(config-line)# transport input ssh
Router(config-line)# login local
Router(config-line)# exit

! Create local user
Router(config)# username admin privilege 15 secret Admin123!
```

### 5. Access Control Lists (ACLs)
```
! Standard ACL - Block specific network
Router(config)# access-list 10 deny 192.168.99.0 0.0.0.255
Router(config)# access-list 10 permit any
Router(config)# interface gi0/0
Router(config-if)# ip access-group 10 in

! Extended ACL - Allow only HTTP/HTTPS to server
Router(config)# access-list 100 permit tcp any host 192.168.50.10 eq 80
Router(config)# access-list 100 permit tcp any host 192.168.50.10 eq 443
Router(config)# access-list 100 deny ip any host 192.168.50.10
Router(config)# access-list 100 permit ip any any
Router(config)# interface gi0/1
Router(config-if)# ip access-group 100 in
```

---

## Router and Switch Configuration

### Basic Router Configuration
```
! Set hostname
Router> enable
Router# configure terminal
Router(config)# hostname R1

! Configure interface
R1(config)# interface gi0/0
R1(config-if)# ip address 192.168.10.1 255.255.255.0
R1(config-if)# ipv6 address 2001:db8:10::1/64
R1(config-if)# no shutdown
R1(config-if)# exit

! Enable IPv6 routing
R1(config)# ipv6 unicast-routing

! Save configuration
R1# copy running-config startup-config
```

### OSPF Configuration (for Mesh Topology)
```
! Enable OSPF on Router1
Router1(config)# router ospf 1
Router1(config-router)# router-id 1.1.1.1
Router1(config-router)# network 10.1.0.0 0.0.0.3 area 0
Router1(config-router)# network 10.2.0.0 0.0.0.3 area 0
Router1(config-router)# network 10.3.0.0 0.0.0.3 area 0
Router1(config-router)# exit

! Enable OSPFv3 for IPv6
Router1(config)# ipv6 router ospf 1
Router1(config-rtr)# router-id 1.1.1.1
Router1(config-rtr)# exit

Router1(config)# interface gi0/0
Router1(config-if)# ipv6 ospf 1 area 0
```

### Inter-VLAN Routing (Router-on-a-Stick)
```
! Configure subinterfaces on router
Router(config)# interface gi0/0
Router(config-if)# no shutdown
Router(config-if)# exit

Router(config)# interface gi0/0.10
Router(config-subif)# encapsulation dot1Q 10
Router(config-subif)# ip address 192.168.10.1 255.255.255.0
Router(config-subif)# ipv6 address 2001:db8:10::1/64
Router(config-subif)# exit

Router(config)# interface gi0/0.20
Router(config-subif)# encapsulation dot1Q 20
Router(config-subif)# ip address 192.168.20.1 255.255.255.0
Router(config-subif)# ipv6 address 2001:db8:20::1/64
Router(config-subif)# exit

! Configure switch trunk port
Switch(config)# interface gi0/1
Switch(config-if)# switchport mode trunk
Switch(config-if)# switchport trunk allowed vlan 10,20,50
```

### Spanning Tree Protocol (for Ring Topology)
```
! Enable Rapid PVST+
Switch(config)# spanning-tree mode rapid-pvst

! Set root bridge priority
Switch(config)# spanning-tree vlan 30 priority 4096

! Configure PortFast on access ports
Switch(config)# interface range fa0/1-10
Switch(config-if-range)# spanning-tree portfast
Switch(config-if-range)# spanning-tree bpduguard enable
```

---

## Testing and Verification

### Connectivity Tests

#### 1. Ping Tests (IPv4 and IPv6)
```
PC> ping 192.168.10.1
PC> ping 2001:db8:10::1
PC> ping www.company.local
```

**Expected Results:**
- ✅ Reply from destination
- ✅ 0% packet loss
- ✅ Round-trip time < 10ms

#### 2. Traceroute
```
PC> tracert 192.168.50.10
PC> tracert www.company.local
```

#### 3. DHCP Verification
```
PC> ipconfig /release
PC> ipconfig /renew
PC> ipconfig /all
```

**Check for:**
- IP address in correct range
- Correct subnet mask
- Default gateway assigned
- DNS server assigned

#### 4. DNS Resolution
```
PC> nslookup www.company.local
PC> nslookup dns.company.local
```

#### 5. HTTP Server Access
- Open web browser on PC
- Navigate to: http://192.168.50.10
- Navigate to: http://www.company.local
- Verify webpage loads correctly

### Switch Verification Commands
```
Switch# show vlan brief
Switch# show interfaces trunk
Switch# show port-security
Switch# show port-security address
Switch# show spanning-tree
Switch# show mac address-table
```

### Router Verification Commands
```
Router# show ip interface brief
Router# show ipv6 interface brief
Router# show ip route
Router# show ipv6 route
Router# show ip ospf neighbor
Router# show ip dhcp binding
Router# show access-lists
```

---

## Screenshots

### Required Screenshots Checklist
- [ ] All 6 topology diagrams (full network view)
- [ ] IP configuration on PCs (ipconfig output)
- [ ] VLAN configuration on switches (show vlan brief)
- [ ] Trunk configuration (show interfaces trunk)
- [ ] Router interface status (show ip int brief)
- [ ] OSPF neighbor relationships (show ip ospf neighbor)
- [ ] DHCP bindings (show ip dhcp binding)
- [ ] DNS server records configuration
- [ ] HTTP server webpage loaded in browser
- [ ] Successful ping tests (IPv4 and IPv6)
- [ ] Port security configuration (show port-security)
- [ ] ACL configuration (show access-lists)
- [ ] Spanning tree topology (show spanning-tree)

**Screenshot Naming Convention:**
- `topology1_bus_overview.png`
- `topology2_mesh_routing.png`
- `topology3_star_vlan_config.png`
- `topology4_ring_stp.png`
- `topology5_extended_star.png`
- `topology6_hybrid_full.png`
- `server_http_config.png`
- `server_dns_records.png`
- `dhcp_binding_table.png`
- `ping_test_ipv4.png`
- `ping_test_ipv6.png`

---

## Challenges and Solutions

### Challenge 1: IPv6 Not Working
**Problem:** IPv6 addresses configured but no connectivity

**Solution:**
```
! Enable IPv6 routing on router
Router(config)# ipv6 unicast-routing

! Verify interface has IPv6 enabled
Router# show ipv6 interface brief
```

### Challenge 2: VLAN Communication Issues
**Problem:** Devices in different VLANs cannot communicate

**Solution:**
- Configured router-on-a-stick for inter-VLAN routing
- Created subinterfaces for each VLAN
- Set switch port to trunk mode

### Challenge 3: DHCP Not Assigning Addresses
**Problem:** PCs not receiving IP addresses from DHCP

**Solution:**
```
! Verify DHCP pool configuration
Router# show ip dhcp pool

! Check excluded addresses don't overlap with pool
Router# show ip dhcp binding

! Ensure interface has 'ip helper-address' if DHCP server is remote
Router(config-if)# ip helper-address 192.168.50.12
```

### Challenge 4: Spanning Tree Loop
**Problem:** Broadcast storm in ring topology

**Solution:**
```
! Enabled Rapid PVST+
Switch(config)# spanning
