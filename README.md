# vagrant-janus-debian

`vagrant-janus-debian` is a simple vagrant project that simplifies the provision of a Janus WebRTC Gateway into a Debian machine. It can be useful if you want to prepare this kind of scenario quickly.

## Components:
* Vagrant Box: `debian/jessie64`
* Janus WebRTC Gateway version: `master`

## Requirements:
* `VirtualBox 5.0.*`
* `Vagrant 1.8.*`

## Usage:
Install `vagrant-vbguest` plugin. It installs the host's VirtualBox Guest Additions on the guest system.
```bash
vagrant plugin install vagrant-vbguest
```

Create and configure the machine:
```bash
vagrant up
```

Now, you are ready to play with your Janus
```bash
service janus status
```

Here the output:
```bash
janus.service - LSB: Janus
   Loaded: loaded (/etc/init.d/janus)
   Active: active (running)
```

## License
MIT
