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

#echo "Create Opt Directory"
#echo "---------------------------"
#sudo mkdir -p /opt/anjuna/nitro
#sleep 2

echo "Install Binary"
echo "---------------------------"
sudo chmod +x anjuna-runtime-ubuntu-release-$VERSION.bin
sudo ./anjuna-runtime-ubuntu-release-$VERSION.bin
sleep 2

echo "Setup Environment"
echo "---------------------------"
source $ANJ_INSTALL_DIR/anjuna-runtime-ubuntu-release-$VERSION/env.sh
sleep 2

echo "Verification"
echo "---------------------------"
anjuna-sgxrun --version
sleep 2

echo "Installing Redis Server"
echo "---------------------------"
sudo apt update
sudo apt upgrade -y
sudo apt install redis-server -y

echo "Completed"
echo -ne '\n'
