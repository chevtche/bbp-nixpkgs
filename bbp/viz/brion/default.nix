{
 stdenv
, fetchgit
, boost
, cmake
, servus
, lunchbox
, keyv
, vmmlib
, pkgconfig
, hdf5-cpp
, highfive
, zlib
, mvdtool
, pythonPackages
, doxygen
, bbptestdata
}:

stdenv.mkDerivation rec {
    name = "brion-${version}";
    version = "3.0-dev201808";

    buildInputs = [ stdenv pkgconfig mvdtool boost pythonPackages.python
                    pythonPackages.numpy pythonPackages.lxml
                    pythonPackages.sphinx_1_3 cmake vmmlib servus
                    lunchbox keyv hdf5-cpp highfive zlib doxygen bbptestdata ];

    src = fetchgit {
        url = "https://github.com/BlueBrain/Brion.git";
        rev = "5d08797c2af48a414277cf0caf756e2bd83e4e41";
        sha256 = "1z5kp1rfblk0x027r8cpcfsqfan3l6kk66pz65n5hdi0cidy17ak";
    };

    enableParallelBuilding = false; # memory consumption too high for python bindings generation

    cmakeFlags = [ "-DDISABLE_SUBPROJECTS=TRUE" ];

    makeFlags = [ "VERBOSE=1" ];

    propagatedBuildInputs = [ servus vmmlib boost
                              pythonPackages.python pythonPackages.numpy];

    passthru = {
        pythonModule = pythonPackages.python;
    };
}
