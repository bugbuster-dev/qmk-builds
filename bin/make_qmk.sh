source ~/bin/git_helpers.func

vendor="$VENDOR"
model="$MODEL"
keymap="$KEYMAP"
qmk_target=
target="$vendor/$model:$keymap"
echo "$vendor $model $keymap $target"

binfile="${target//\//_}" # Replace all / with _
binfile="${binfile//:/_}" # Replace all : with _
#echo "$binfile"

rm *${vendor}*.bin *${vendor}*.md5
make $1 "$target"

dirty=""
if [ "$(git_repo_dirty)" = "*" ]; then
  dirty="-dirty"
fi

commit_hash=$(git rev-parse HEAD | cut -c1-8)
fwname=$binfile.${commit_hash}${dirty}

mv $binfile.bin ${fwname}.bin
md5sum ${fwname}.bin > ${fwname}.md5

cp $binfile.* /workspaces/qmk-builds/$vendor/
