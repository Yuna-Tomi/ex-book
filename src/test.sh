#!/bin/bash
path=$(dirname "$0")
common_dir="${path}/common"
chapter_prefix="${path}/ch"

elixirc --ignore-module-conflict ${common_dir}/mytest.ex ${common_dir}/string_helper.ex
if [ ! "${?}" = "0" ]; then
  echo -e "\033[31;1mCould not compile test module. Please check it.\033[m"
  exit 1
fi

elixir ${common_dir}/mytest_test.exs
echo ""
elixir ${common_dir}/string_helper_test.exs
echo ""

i=1
while [ $i -lt 28 ]; do
  ls -d "${chapter_prefix}${i}" >&/dev/null
  result=$?
  dir="${chapter_prefix}${i}"
  i=$((i + 1))
  if [ ! "${result}" = "0" ]; then
    continue
  fi

  ls ${dir}/mix.exs >&/dev/null
  if [ "${?}" = "0" ]; then
    echo -e "\033[32;1m\`${dir}\`\033[m \033[33mseems to be a Mix project. Use \`mix\` command rather than this \`test.sh\`.\033[m"
    echo ""
    continue
  fi

  ls ${dir}/*.exs >&/dev/null
  declare -a scripts=($(ls ${dir}/*.exs))
  for script in ${scripts[@]}; do
    elixir $script
    echo ""
  done
done

echo -e "\033[36mTests done.\033[m"
echo "Clean up beam bytecodes..."
rm Elixir.*.beam
