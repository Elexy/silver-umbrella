# silver-umbrella
Create an ubuntu linux VM in EC2 [using the launch wizzard](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:)

Make sure you create a new ssh keypair name 'football' when asked during the wizard.
Download this key (football.pem) to your local machine.

chmod the key with this command ```chmod 400 football.pem```

once the VM is booted highlight the VM and click the 'connect' button on the top. This shows how to connect to you VM using ssh. Example:
```
ssh -i "football.pem" ubuntu@54.145.154.178
```
(replace the ip with the one assigned to your VM)

install salt master and minion:
```
curl -L https://bootstrap.saltstack.com -o install_salt.sh
```
inspect the downloaded file
```
less install_salt.sh
```
when it looks geniune execute with
```
sudo sh install_salt.sh -P -M
```

create directory:
```
sudo mkdir -p /srv/salt
```

configure the salt master and make sure these lines are included in /etc/salt/master
```
file_roots:
  base:
    - /srv/salt
    - /srv/formulas
```
now configure the minion that is installed on the same machine by making sure this line is present in /etc/salt/minion
```
master: 127.0.0.1
```

## Logger
This script counts all the log files with extension '.log' in /var/log/ and adds the results per file to /root/counts.log along with a datetime.

create a file named logger.sh in /srv/salt and paste these lines in it
```
n=`date`
for i in /var/log/*.log
do
  lines=`wc -l "$i" | awk '{print $1}'`
  printf "%s|%s|%s\n" "$n" "$i" "$lines" >> /root/counts.log
done
```
Now create the logger salt state by creating a file named 'logger.sls' in /srv/salt and paste this in it:
```
/usr/local/bin/logger.sh:
  file.managed:
    - source: salt://logger.sh
    - mode: 755
    - user: root
    - group: root
  cron.present:
    - user: root
    - minute: 30
```
run it: ```sudo salt "*" state.apply logger```

## users
This will create 3 users and add the football.pem public ssh key to the authorized_keys for that users
```
alex:
  user.present:
    - fullname: Alex Knol
    - shell: /bin/bash
    - home: /home/alex
  ssh_auth.present:
    - user: alex
    - source: salt://ssh_keys/thatch.id_rsa.pub
    - config: /%h/.ssh/authorized_keys
donald:
  user.present:
    - fullname: Donald Trump
    - shell: /bin/bash
    - home: /home/donny
  ssh_auth.present:
    - user: donald
    - source: salt://ssh_keys/thatch.id_rsa.pub
    - config: /%h/.ssh/authorized_keys
barack:
  user.present:
    - fullname: Barack Obama
    - shell: /bin/bash
    - home: /home/barack
  ssh_auth.present:
    - user: barack
    - source: salt://ssh_keys/thatch.id_rsa.pub
    - config: /%h/.ssh/authorized_keys
```
create the 'ssh_keys/' directory in /srv/salt:
```
sudo mkdir /srv/salt/ssh_keys
```

now copy the public key from the current user to /srv/salt/ssh_keys/thatch.id_rsa.pub:
```
cat ~/.ssh/authorized_keys >  /srv/salt/ssh_keys/thatch.id_rsa.pub
```
run it:
```
sudo salt "*" state.apply users
```

## My solution
My solution can be accessed running this command from the root of this repo:
```
ssh -i "football.pem" ubuntu@54.145.154.178
```
