package=gmp
$(package)_version=6.2.1
$(package)_file_name=$(package)-$($(package)_version).tar.bz2
$(package)_sha256_hash=eae9326beb4158c386e39a356818031bd28f3124cf915f8c5b1dc4c7a36b4d7c

$(package)_urls += https://gmplib.org/download/gmp/
$(package)_urls += https://ftp.gnu.org/gnu/gmp/

define $(package)_set_vars
$(package)_config_opts=--disable-shared
$(package)_config_opts_mingw32=--enable-mingw
$(package)_config_opts_linux=--with-pic
$(package)_config_opts_darwin=--with-pic
endef

define $(package)_config_cmds
  $($(package)_autoconf)
endef

define $(package)_build_cmds
  $(MAKE)
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install
endef

define $(package)_fetch_cmds
  for i in 1 2 3; do \
    $(call fetch_file,$(package),$($(package)_all_urls))
    echo "GMP download attempt $$i failed, retrying in 5s..."; \
    sleep 5; \
  done
endef
