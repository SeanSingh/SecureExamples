#Add user to CentOS
read -p "What username would you like to add? " NewUserName
NewUserPass="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c16)"
sudo useradd $NewUserName
echo "$NewUserName:$NewUserPass"|sudo chpasswd
echo "Password has been set to: $NewUserPass"
#Uncomment next line to add user to sudoers file:
# echo "$NewUserName    ALL=(ALL)	ALL" | sudo tee --append /etc/sudoers > /dev/null #Add the new user to the sudoers file.

NewHome=$(eval echo "~$NewUserName")    # Gets $NewUserName's home dir.
sudo curl -L https://raw.githubusercontent.com/Open-NGO/SecureExamples/master/ssh_pubkey_tf >> $NewHome/.ssh/authorized_keys
sudo mkdir -p $NewHome/.ssh  #Create the SSH directory
sudo echo "$pubkey" >> $NewHome/.ssh/authorized_keys #Create the authorized keys file.
sudo chmod 600 $NewHome/.ssh/authorized_keys
sudo chmod 700 $NewHome/.ssh
sudo chown -R $NewUserName:$NewUserName $NewHome

#Add user to Ubuntu:
#sudo adduser <username> sudo
