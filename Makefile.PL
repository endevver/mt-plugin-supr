use ExtUtils::MakeMaker;

use YAML::Any qw(LoadFile);
my $file = "plugins/Supr/config.yaml";
my $version = LoadFile($file)->{version} ||
    die "No version found in $file";

WriteMakefile(
    NAME            => 'Supr',
    VERSION         => $version,
    DISTNAME        => 'Supr',
    clean => {
        FILES => 'mt-static *.zip MANIFEST.bak MANIFEST'
    },
    dist => {
        DIST_DEFAULT => 'mt-static manifest zipdist'
#        PREOP => "mkdir -p mt-static/plugins/Supr; cp -pR plugins/Supr/static/* mt-static/plugins/Supr/",
#        POSTOP => "rm -rf mt-static"
    }
);


sub MY::postamble {
    return <<"MAKE_FRAG";
mt-static: 
\tmkdir -p mt-static/plugins/Supr
\tcp -pR plugins/Supr/static/* mt-static/plugins/Supr/
MAKE_FRAG
}
