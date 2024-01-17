import {createVM} from "./createVM"


// Kuberntes Cluster Definition
// VM ID Range 300-399
// Subnet 10.1.1.85-89

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
