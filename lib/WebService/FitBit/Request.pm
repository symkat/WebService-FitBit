package WebService::FitBit::Request;
use Moo::Role;

has oauth_consumer_key => ( is => 'ro' );
has oauth_token_secret => ( is => 'ro' );
has oauth_token        => ( is => 'ro' );

has 'language' => (
    is      => 'rw',
    default => sub { "en_US" },
    isa     => sub { $_[0] =~ /^en_(US|GB|KG)$/ },
);


sub as_exception { return shift; }

1;
