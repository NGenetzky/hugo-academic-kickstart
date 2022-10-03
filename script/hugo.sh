
hugo_()
{
  docker run -it \
    --volume "$(pwd):/src:rw" \
    --user "1000:1000" \
    jojomi/hugo:latest \
    hugo $@
}
