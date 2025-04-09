./build.sh

watchexec -w Sources -e .swift -r 'swift run > dist/index.html && browser-sync reload' &
browser-sync start --server dist