sudo apt install -y git python3-pip

python3 -m pip install --user qmk
qmk || echo 'PATH="$HOME/.local/bin:$PATH"' >> $HOME/.bashrc && source $HOME/.bashrc

qmk setup -H $(pwd)
