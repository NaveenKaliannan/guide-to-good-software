#### How to format a scala code?
* Set up Scalafmt
```
VERSION=1.5.1
INSTALL_LOCATION=/usr/local/bin/scalafmt-native
curl https://raw.githubusercontent.com/scalameta/scalafmt/master/bin/install-scalafmt-native.sh | \
  bash -s -- $VERSION $INSTALL_LOCATION
scalafmt-native --help # should show version 1.5.1
```
* The home folder's .bashrc file should contain the following bash command, and the home folder should contain the .scalafmt.conf
```
alias scalafmt='/usr/local/bin/scalafmt-native --config /home/naveenk/.scalafmt.conf '
```
* Start the Scalafmt.
```
scalafmt -i home/naveenk/filename.scala # note that the "/" should not be used infront of home
```
