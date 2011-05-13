#!/bin/bash
base_path=`dirname $0`;
gem_opts="--no-ri --no-rdoc"
sudo apt-get update
sudo apt-get install -y ruby-dev libopenssl-ruby rubygems tinc
sudo gem1.8 install $base_path/gems/rubygems-update-1.7.2.gem $gem_opts
gembin_path=`gem env | grep "EXECUTABLE DIRECTORY" | awk '{print $4}'`
if [ ! -e /etc/profile.d/gem.sh ]; then
  cat <<EOF > gem.sh
export PATH=\$PATH:$gembin_path
EOF
  sudo mv gem.sh /etc/profile.d/
fi
# sudo $gembin_path/update_rubygems
sudo gem1.8 install $base_path/gems/facter-1.5.8.gem $gem_opts
sudo gem1.8 install $base_path/gems/puppet-2.6.8.gem $gem_opts
[ "$1" = "master" ] && sh $base_path/02_start_puppetmaster.sh
sh $base_path/01_update.sh
