## Shortcut
alias his="history"
alias h="history"
alias p="python"
alias s="scala"
alias g="grep"
alias gdiff="git difftool -y"
alias ppid="ps -o ppid= -p"

# To create patch.
# 	gpatch > ~/patches/file
# To apply patch
# 	gpatchapply < ~/patches/file
#
# Must be on the git root directory.
alias gpatch="git diff --no-prefix"
alias gpatchapply="patch -p0"


## Python Profiler
pypro() {
  if ! which dot > /dev/null
  then
    echo "run 'sudo yum install graphviz'"
    return 1
  fi

  if ! which gprof2dot > /dev/null
  then
    echo "run activate; pip install gprof2dot'"
    return 1
  fi

  script=`which $1`
  shift
  graph_title="$script $@"
  time=`date +%s`
  python -m cProfile -o /tmp/pypro.$$.pstats $script "$@"
  gprof2dot -f pstats /tmp/pypro.$$.pstats | dot -Tpng -o /tmp/pypro.$time.png -Glabel="$graph_title" -Glabelloc=t
  rm /tmp/pypro.$$.pstats
  gnome-open /tmp/pypro.$time.png
}

openpro() {
  graph_title="$1"
  time=`date +%s`
  gprof2dot -f pstats $1 | dot -Tpng -o /tmp/pypro.$time.png -Glabel="$graph_title" -Glabelloc=t
  gnome-open /tmp/pypro.$time.png
}
