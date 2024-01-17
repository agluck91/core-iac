import * as pulumi from "@pulumi/pulumi";
import * as proxmox from "@muhlba91/pulumi-proxmoxve";

type VMConfiguration = {
	name: string;
	ipAddress: string;
	vCpu: 1 | 2 | 3 | 4;
	vmId?: number;
	minMemory?: number;
	maxMemory?: number;
	onBoot?: boolean;
	dataStore?: string;
	diskSize?: number;
  templateId?: number;
	gateway?: string;
}

const config = new pulumi.Config();
const stack = pulumi.getStack();
let node = ''
stack === 'main' ? node = 'pve-main' : node = 'pve';


const provider = new proxmox.Provider('proxmox', {
	virtualEnvironment: {
		endpoint: config.require('PROXMOX_VE_ENDPOINT'),
		insecure: config.requireBoolean('PROXMOX_VE_INSECURE'),
		username: config.require('PROXMOX_VE_USERNAME'),
		password: config.require('PROXMOX_VE_PASSWORD'),
	}
});

export function createVM(configuration: VMConfiguration) {
	const virtualMachine = new proxmox.vm.VirtualMachine(`${configuration.name.replace(/\s+/g, '-').toLowerCase()}`, {
		nodeName: node,
		vmId: configuration.vmId || undefined,
		agent: {
				enabled: true, // toggles checking for ip addresses through qemu-guest-agent
		},
		cpu: {
				cores: configuration.vCpu,
				sockets: 1,
		},
		clone: {
				nodeName: node,
				vmId: configuration.templateId || 900,
				full: true,
		},
		disks: [
				{
						interface: 'scsi0',
						datastoreId: configuration.dataStore || 'fast-storage',
						size: configuration.diskSize || 45,
						ssd: true,
						discard: "on",
				},
		],
		memory: {
				dedicated: configuration.maxMemory || 1024,
				floating: configuration.minMemory || 1024,
		},
		name: configuration.name,
		vga: {
			enabled: true,
		  type: "serial0"
		},
		networkDevices: [
				{
						bridge: 'vmbr0',
						model: 'virtio',
				},
		],
		onBoot: configuration.onBoot || false,
		initialization: {
				type: 'nocloud',
				datastoreId: 'local-lvm',
				ipConfigs: [
						{
								ipv4: {
										address: configuration.ipAddress,
										gateway: configuration.gateway || '10.10.1.1',
								},
						},
				],
				userAccount: {
					username: 'agluck',
					password: config.require('PASSWORD'),
					keys: [
						'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILtnMgEAFNMutvv1/FnR6s4njCGB2RdXt3fD8QbCRLww andrew-macbook-pro',
						'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFpso6EJmgJLnJmCRCKs5HiAC0blLMiKVyGnhI3/Gktj Andrew Mobile'
					]
			},
		},
	},
	{
		provider:provider
	});

}
