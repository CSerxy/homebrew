require 'formula'

class PdflibLite < Formula
  homepage 'http://www.pdflib.com/download/free-software/pdflib-lite/'
  url 'http://www.pdflib.com/binaries/PDFlib/705/PDFlib-Lite-7.0.5p3.tar.gz'
  version '7.0.5p3'
  sha1 '42e0605ae21f4b6d25fa2d20e78fed6df36fbaa9'

  bottle do
    cellar :any
    revision 1
    sha1 "a3312478c0af40820fc1970a79b85677a64cdf78" => :yosemite
    sha1 "1681c61b3679e8a96dc42266d4a49d092f2798b4" => :mavericks
  end

  def install
    # Without the following substitution, pdflib-lite runs into weird
    # build errors due to bad interactions with the TIFF headers.
    # This workaround comes from the MacPorts.org portfile for pdflib.
    ENV['CPPFLAGS'] = "-isystem#{prefix}"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--without-java",
                          "--without-perl",
                          "--without-py",
                          "--without-tcl",
                          "--without-ruby"
    system "make"
    system "make install"
  end

  def caveats; <<-EOS.undent
    pdflib-lite is not open source software; usage restrictions apply!
    Be sure to understand and obey the license terms, which can be found at:
    http://www.pdflib.com/download/free-software/pdflib-lite-7/pdflib-lite-licensing/
    EOS
  end
end
