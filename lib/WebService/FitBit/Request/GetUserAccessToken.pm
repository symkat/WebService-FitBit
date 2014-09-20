package WebService::FitBit::Request::GetUserAccessToken;
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

has oauth_verifier => (
    is => 'ro',
);


sub oauth_params {
    my $self = shift;
    return { 
        oauth_verifier     => $self->oauth_verifier,
        oauth_token        => $self->oauth_token,
        oauth_token_secret => $self->oauth_token_secret,
    };
}

sub post_arguments {
    my ( $self ) = @_;

    return [ 
#        oauth_verifier     => $self->oauth_verifier,
#        oauth_token        => $self->oauth_token,
    ];
}

1;
