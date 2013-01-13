package WebService::FitBit::Response;
use Moo::Role;

sub get_tokens {
    my ( $self, $str, @tokens ) = @_;
    my %data;

    pos($str) = 0;
    while ( pos($str)  != length($str) ) {
        if ( $str =~ /\G([^=]+)=([^&]+)&?/gc ) {
            $data{$1} = $2;
        } else {
            die "Unmatched token in $str at " . substr($str,pos($str),1) . "\n";
        }
    }

    return map { $data{$_} || undef } @tokens;
}

1;
