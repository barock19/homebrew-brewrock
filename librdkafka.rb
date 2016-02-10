# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Librdkafka < Formula
  desc "The Apache Kafka C/C++ library"

  homepage   "https://github.com/edenhill/librdkafka"
  url "https://github.com/edenhill/librdkafka/archive/0.9.0.99.tar.gz"
  version "0.9.0.99"
  sha256 "5af65838419a1e1069e486a233575df6067fec7c5756f59c56e517b5287041f6"

  depends_on "lzlib"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--CPPFLAGS=-I/usr/local/opt/openssl/include",
                          "--LDFLAGS=-L/usr/local/opt/openssl/lib"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <librdkafka/rdkafka.h>

      int main (int argc, char **argv)
      {
        int partition = RD_KAFKA_PARTITION_UA; /* random */
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lrdkafka", "-lz", "-lpthread", "-o", "test"
    system "./test"
  end
end
