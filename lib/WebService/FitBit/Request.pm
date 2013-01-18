package WebService::FitBit::Request;
use Moo::Role;

has oauth_consumer_key => ( is => 'ro' );
has oauth_token_secret => ( is => 'ro' );
has oauth_token        => ( is => 'ro' );


sub as_exception { return shift; }

1;
