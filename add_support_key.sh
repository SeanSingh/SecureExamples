username="$(whoami)"
id_rsa="$(cat ~/.ssh/$pubkey)"
pubkey="$(curl -L https://raw.githubusercontent.com/Open-NGO/SecureExamples/master/ssh_pubkey_tf)"
#GithubToken="$(~/.Github.Token)"
mkdir -p ~/.ssh && chmod 700 ~/.ssh
echo "$pubkey" >> ~/.ssh/authorized_keys
sudo chmod 600 ~/.ssh/authorized_keys

#Harden the SSH server config:

sudo sed -i 's/#Compression delayed/Compression no/g' /etc/ssh/sshd_config
sudo sed -i 's/Compression yes/Compression no/g' /etc/ssh/sshd_config
sudo sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#RekeyLimit default none/RekeyLimit 120M 300/g' /etc/ssh/sshd_config
sudo sed -i '/# Ciphers and keying/a MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256' /etc/ssh/sshd_config
sudo sed -i '/# Ciphers and keying/a Ciphers aes256-ctr,aes256-gcm@openssh.com,aes192-ctr,aes192-cbc' /etc/ssh/sshd_config
sudo sed -i '/# MACs/a KexAlgorithms ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1' /etc/ssh/sshd_config
sudo sed -i '/# MACs/a HostKeyAlgorithms ssh-rsa,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,ssh-rsa-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp521-cert-v01@openssh.com' /etc/ssh/sshd_config
sudo sed -i 's/HostKey \/etc\/ssh\/ssh_host_ed25519_key/""/g' /etc/ssh/sshd_config
sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i '/PubkeyAuthentication/a PubkeyAcceptedKeyTypes ssh-rsa-cert-v01@openssh.com,ssh-rsa,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp521-cert-v01@openssh.com' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin without-password/g' /etc/ssh/sshd_config
#This disables password based login via SSH, so make sure you have a SSH key set.
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
