collectd: build/collectd build/collectd/collectd-5.3.0
	rsync -a --delete pkg/collectd/debian/ build/collectd/collectd-5.3.0/debian/
	(cd build/collectd/collectd-5.3.0 && debuild -S)

build/collectd:
	mkdir build/collectd

build/collectd/collectd-5.3.0: build/collectd/collectd_5.3.0.orig.tar.gz
	(cd build/collectd && tar xf collectd_5.3.0.orig.tar.gz)

build/collectd/collectd_5.3.0.orig.tar.gz: pkg/collectd/srcurl
	echo $@
	curl $(shell cat pkg/collectd/srcurl) > $@

ruby1.9.2: build/ruby1.9.2 build/ruby1.9.2/ruby-1.9.2p290
	rsync -a --delete pkg/ruby1.9.2/debian/ build/ruby1.9.2/ruby-1.9.2p290/debian/
	(cd build/ruby1.9.2/ruby-1.9.2p290 && debuild -S)

build/ruby1.9.2:
	mkdir build/ruby1.9.2

build/ruby1.9.2/ruby-1.9.2p290: build/ruby1.9.2/ruby_1.9.2p290.orig.tar.gz
	(cd build/ruby1.9.2 && tar zxf ruby_1.9.2p290.orig.tar.gz \
	                    && mv ruby-1.9.2-p290 ruby-1.9.2p290)

build/ruby1.9.2/ruby_1.9.2p290.orig.tar.gz: pkg/ruby1.9.2/srcurl
	echo $@
	curl $(shell cat pkg/ruby1.9.2/srcurl) > $@

clean:
	rm -rf build/*

fullclean: clean
	rm -f *.build *.changes *.deb *.ddeb

.PHONY: collectd ruby1.9.2 clean fullclean
