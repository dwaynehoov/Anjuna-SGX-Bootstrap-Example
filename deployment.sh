if [ -f .env ]; then
  export $(echo $(cat .env | sed 's/#.*//g'| xargs) | envsubst)
fi

cat << "EOF"
 ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄        ▄  ▄▄▄▄▄▄▄▄▄▄▄     ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ 
▐░░░░░░░░░░░▌▐░░▌      ▐░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░▌      ▐░▌▐░░░░░░░░░░░▌   ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
▐░█▀▀▀▀▀▀▀█░▌▐░▌░▌     ▐░▌ ▀▀▀▀▀█░█▀▀▀ ▐░▌       ▐░▌▐░▌░▌     ▐░▌▐░█▀▀▀▀▀▀▀█░▌    ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌
▐░▌       ▐░▌▐░▌▐░▌    ▐░▌      ▐░▌    ▐░▌       ▐░▌▐░▌▐░▌    ▐░▌▐░▌       ▐░▌        ▐░▌     ▐░▌       ▐░▌
▐░█▄▄▄▄▄▄▄█░▌▐░▌ ▐░▌   ▐░▌      ▐░▌    ▐░▌       ▐░▌▐░▌ ▐░▌   ▐░▌▐░█▄▄▄▄▄▄▄█░▌        ▐░▌     ▐░▌       ▐░▌
▐░░░░░░░░░░░▌▐░▌  ▐░▌  ▐░▌      ▐░▌    ▐░▌       ▐░▌▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌        ▐░▌     ▐░▌       ▐░▌
▐░█▀▀▀▀▀▀▀█░▌▐░▌   ▐░▌ ▐░▌      ▐░▌    ▐░▌       ▐░▌▐░▌   ▐░▌ ▐░▌▐░█▀▀▀▀▀▀▀█░▌        ▐░▌     ▐░▌       ▐░▌
▐░▌       ▐░▌▐░▌    ▐░▌▐░▌      ▐░▌    ▐░▌       ▐░▌▐░▌    ▐░▌▐░▌▐░▌       ▐░▌        ▐░▌     ▐░▌       ▐░▌
▐░▌       ▐░▌▐░▌     ▐░▐░▌ ▄▄▄▄▄█░▌    ▐░█▄▄▄▄▄▄▄█░▌▐░▌     ▐░▐░▌▐░▌       ▐░▌ ▄  ▄▄▄▄█░█▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌
▐░▌       ▐░▌▐░▌      ▐░░▌▐░░░░░░░▌    ▐░░░░░░░░░░░▌▐░▌      ▐░░▌▐░▌       ▐░▌▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
 ▀         ▀  ▀        ▀▀  ▀▀▀▀▀▀▀      ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀  ▀         ▀  ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ 
EOF

echo "Download Binary"
echo "---------------------------"
wget https://api.downloads.anjuna.io/v1/releases/anjuna-runtime-ubuntu-release-$VERSION.bin \
  --header="X-Anjuna-Auth-Token:$APIKEY"
sleep 2

echo "Install Binary"
echo "---------------------------"
chmod +x anjuna-runtime-ubuntu-release-$VERSION.bin
./anjuna-runtime-ubuntu-release-$VERSION.bin
sleep 2

echo "Setup Environment - add this to your .bash_profile"
echo "---------------------------"
source $ANJ_INSTALL_DIR/anjuna-runtime-ubuntu-release-$VERSION/env.sh
sleep 2

echo "Verification"
echo "---------------------------"
anjuna-sgxrun --version
sleep 2

#update for desired application
echo "Installing Redis Server"
echo "---------------------------"
sudo apt update
sudo apt upgrade -y
sudo apt install redis-server -y
sudo /etc/init.d/redis-server stop

#update manifest file here
echo "Creating Enclave Manifest File"
echo "---------------------------"

echo "Setup Environment - add this to your .bash_profile"
echo "---------------------------"
source $ANJ_INSTALL_DIR/anjuna-runtime-ubuntu-release-$VERSION/env.sh
sleep 2

echo "Completed"
echo -ne '\n'
