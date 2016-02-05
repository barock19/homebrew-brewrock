# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Librdkafka < Formula
  desc "The Apache Kafka C/C++ library"

  homepage   "https://github.com/edenhill/librdkafka"
  url        "https://github.com/edenhill/librdkafka/archive/0.9.0.tar.gz"
  sha256     "e7d0d5bbaed8c6b163bdcc74274b7c1608b4d8a06522c4fed1856986aee0a71a"

  depends_on "lzlib"
  depends_on "openssl"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--CPPFLAGS=-I/usr/loc/opt/openssl/include",
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
