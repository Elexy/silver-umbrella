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
