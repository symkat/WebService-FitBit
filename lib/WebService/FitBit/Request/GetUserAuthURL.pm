package WebService::FitBit::Request::GetUserAuthURL;
use Moo;
with 'WebService::FitBit::Request';

has type => ( 
    is => 'ro', 
    default => sub { "POST" } 
);

has endpoint => ( 
    is => 'ro', 
    default => sub { "/oauth/request_token" } 
);

sub oauth_params {
    return {};
}

sub post_arguments {
    my ( $self ) = @_;

    return [ ];
}

sub as_exception {
    my ( $self ) = @_;

    return {
        type => $self->type,
        endpoint => $self->endpoint,
        oauth_consumer_key => $self->oauth_consumer_key,
    };
}

1;
