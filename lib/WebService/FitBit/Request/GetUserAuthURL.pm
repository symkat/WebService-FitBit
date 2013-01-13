package WebService::FitBit::Request::GetUserAuthURL;
use Moo;

has type => ( 
    is => 'ro', 
    default => sub { "POST" } 
);

has endpoint => ( 
    is => 'ro', 
    default => sub { "https://api.fitbit.com/oauth/request_token" } 
);

has oauth_consumer_key => (
    is => 'ro',
);

sub oauth_params {
    return {};
}

sub post_arguments {
    my ( $self ) = @_;

    return [
        oauth_consumer_key => $self->oauth_consumer_key, 
    ];
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
