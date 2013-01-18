package WebService::FitBit::Request::GetUserAuthURL;
use Moo;
with 'WebService::FitBit::Request';

has type => ( 
    is => 'ro', 
    default => sub { "POST" } 
);

has endpoint => ( 
    is => 'ro', 
    default => sub { "/oauth/access_token" } 
);


sub oauth_params {
    return {};
}

sub post_arguments {
    my ( $self ) = @_;

    return [
        oauth_consumer_key => $self->oauth_consumer_key, 
        oauth_token        => $self->oauth_verifier, 
        oauth_verifier     => $self->oauth_verifier, 
    ];
}

1;
