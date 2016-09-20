# Palo

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'palo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install palo

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


# PALO compilation

OS: Ubuntu 16.04

## Install dependencies

You need at least these:

```shell
sudo apt install cmake
sudo apt install libicu-dev
sudo apt install libboost1.58.0-all-dev
```

Depending on your system or what you want to compile, you might need these.

```shell
sudo apt install libgoogle-perftools-dev
sudo apt install gperf
sudo apt install zlib-dev
sudo apt install subversion
sudo apt install flex
sudo apt install doxygen
```

## Create makefiles

```shell
mkdir build
cd build
cmake .. -DLIB_ICU_ROOT_DIR=/usr/lib/x86_64-linux-gnu -DENABLE_HTTPS=OFF
```

## Fix the links to some libraries

```shell
nano CMakeCache.txt
```

* Set the revision number to match that found hardcoded. If you do not change this then during a server restart palo might not want to restore databases and cubes because there is a version mismatch.
* change the 2 instances of set_revision("0000") to set_revision("5594")

```shell
nano CMakeFiles/palo.dir/link.txt
```

* remove the 3 instances of *-mt by removing the ending '-mt' part of the boost libraries.
* change the 3 instances where for some reason '/lib/Linux/x86_64/' appears in the links.
  this: /usr/lib/x86_64-linux-gnu/lib/Linux/x86_64/libicuuc.so
  into: /usr/lib/x86_64-linux-gnu/libicuuc.so

```shell
nano CMakeFiles/palo.dir/build.make
```

* change the 2 instances where for some reason '/lib/Linux/x86_64/' appears in the links.
  this: /usr/lib/x86_64-linux-gnu/lib/Linux/x86_64/libicuuc.so
  into: /usr/lib/x86_64-linux-gnu/libicuuc.so

## Make

```shell
make
```
