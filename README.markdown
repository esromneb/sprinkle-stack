Sprinkle Stack
==============

A customized Rails server install stack based on "passenger-stack" by
Ben Schwarz and some related work by Seth Banks (subimage).

Background
====
Assuming that you have ruby setup correctly on your mac, this script will ssh to a remote server and bring it from a virgin install to a fully funcitoning rails web server running ontop of apache (with passenger 4).

This specific fork is meant for running ontop of Ubuntu in an Amazon ec2 instance.

Steps
====

  - provision new ec2 server using:

`Ubuntu Server 12.04.1 LTS`, specifically I used `"Ubuntu Cloud Guest AMI ID ami-4ac9437a (x86_64)"`

  - ssh to server as user ubuntu with your private key:  
`ssh -i private.pem ubuntu@ec2-1-1-1-1.us-west-1.compute.amazonaws.com`
  - Append the fingerprint from your mac's ssh public key:
  `cat .ssh/id_rsa.pub`
to the remote file located here:  
  `.ssh/authorized_keys`

  - Enable root login using this command:  

`sudo cp /home/ubuntu/.ssh/authorized_keys /root/.ssh/`

  - Edit config.rb (you shouldn't need to)
  - copy deploy.rb.example to deploy.rb
  - Edit deploy.rb and change the remote address of your server

  - Running is as simple as:

    `sprinkle -c -s config/install.rb`

Will set up a brand new Unix system with all required software to run a Rails app.
This installs supporting software and configures a "deploy" user that can deploy 
applications to the new machine. Tested with Ubuntu 12.04.1 LTS on Amazon ec2 `ami-4ac9437a`.

After provisioning, you should:

* Login and change the password of the 'deploy' user
* Disallow root logins via SSH by editing the sshd_config file and setting "PermitRootLogin" to "no"
* `rm -rf /root/.ssh/authorized_keys` to further disallow root login
* Lock down all ports except 80, 443 (web, ssl), 22 (ssh)
