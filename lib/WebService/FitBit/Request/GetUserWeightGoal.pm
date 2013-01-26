package WebService::FitBit::Request::GetUserWeightGoal;
use Moo;
use DateTime;
with 'WebService::FitBit::Request';

has type => ( 
    is => 'ro', 
    default => sub { "GET" },
);

# Information For HTTP Request

has format => (
    is => 'ro',
    isa => sub { grep { $_[0] eq $_ } (qw( json xml ))  },
    default => sub { "json" },
);

has endpoint => ( 
    is => 'lazy',
);

sub _build_endpoint {
    my ( $self ) = @_;

    return sprintf( "/1/user/-/body/log/weight/goal.%s", $self->format  );
}



# Disregard


sub query_params {
    return "";
};


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
        format => $self->format,
        endpoint => $self->endpoint,
    };
}

1;
