package WebService::FitBit::Response;
use Moo::Role;
use JSON qw( decode_json );
use Data::Dumper;

has response => (
    is => 'ro',
    isa => sub { ref $_[0] eq 'LWP::Authen::OAuth' },
);

has json => ( is => 'lazy' );

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

sub _build_json {
    my ( $self ) = @_;

    return decode_json($self->response->content);
}

1;
