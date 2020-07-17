class Masurca < Formula
  # cite Zimin_2013: "https://doi.org/10.1093/bioinformatics/btt476"
  desc "Maryland Super-Read Celera Assembler"
  homepage "https://masurca.blogspot.com/"
  url "https://github.com/alekseyzimin/masurca/releases/download/v3.4.1/MaSuRCA-3.4.1.tar.gz"
  sha256 "a00b941901d8d332c7fa17670ab68eb767cf476a96d8bf721493a37294f5287f"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "16e4787d9289750d0afbddfc178bcc51c1e3f46e2167c4508e49e234fb41e68e" => :x86_64_linux
  end

  depends_on "boost" => :build
  depends_on "brewsci/bio/jellyfish"
  depends_on :linux
  depends_on "parallel"
  depends_on "perl"
  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  def install
    ENV.deparallelize
    # Respect MAKEFLAGS variable
    inreplace "install.sh", "make -j $NUM_THREADS", "make"
    ENV["DEST"] = libexec
    system "./install.sh"

    bin.install_symlink libexec/"bin/masurca"
    pkgshare.install "sr_config_example.txt"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/masurca --version 2>&1")
    system "#{bin}/masurca", "-h"
  end
end
