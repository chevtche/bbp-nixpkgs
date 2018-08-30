{ stdenv
, boost
, fetchgit
, cmake
, servus
, pkgconfig
, doxygen
}:

stdenv.mkDerivation rec {
  name = "lunchbox";
  version = "1.16.0-dev201806";
  buildInputs = [ stdenv boost pkgconfig servus cmake doxygen];

  src = fetchgit {
    url = "https://github.com/Eyescale/Lunchbox.git";
    rev = "ab0c1e30f0deafaf5b0e97cf625cc7d2ceeb6e61";
    sha256 = "06089lzspvdpc0j17g1bjlw4f1i42j0kjxl76bqcpl2qklnmcs6b";
  };


  cmakeFlags = [ "-DCOMMON_DISABLE_WERROR=TRUE" ];

  propagatedBuildInputs = [ boost servus ];

  enableParallelBuilding = true;

  doCheck = true;

  checkPhase = ''
	export LD_LIBRARY_PATH=''${PWD}/lib/:''${LD_LIBRARY_PATH}
	# disable perf -> too much time and memory
	# disable thread -> will fail when executed on machine with low resource
	ctest -V -E "(perf|Thread|thread)"
  '';

}
