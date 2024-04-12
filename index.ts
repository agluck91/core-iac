import {createVM} from "./createVM"


// Kuberntes Cluster Definition
// VM ID Range 300-399
// Subnet 10.1.1.85-89
createVM({
  name: "k3s-node-1",
  vmId: 300,
  templateId: 900,
  vCpu: 4,
  diskSize: 100,
  maxMemory: 4096,
  minMemory: 2048,
  ipAddress: "10.10.1.85/24"
})

createVM({
  name: "k3s-node-2",
  vmId: 301,
  templateId: 900,
  vCpu: 4,
  diskSize: 100,
  maxMemory: 4096,
  minMemory: 2048,
  ipAddress: "10.10.1.86/24"
})

createVM({
  name: "k3s-node-3",
  vmId: 302,
  templateId: 900,
  vCpu: 4,
  diskSize: 100,
  maxMemory: 4096,
  minMemory: 2048,
  ipAddress: "10.10.1.87/24"
})

//Test VM
//ID Range: 600-699
//IP range: 90-99
createVM({
  name: "test-vm-1",
  vmId: 600,
  templateId: 900,
  vCpu: 4,
  diskSize: 50,
  maxMemory: 8192,
  minMemory: 2048,
  ipAddress: "10.10.1.70/24"
})
