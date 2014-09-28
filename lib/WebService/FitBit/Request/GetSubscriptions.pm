package WebService::FitBit::Request::GetSubscriptions;
use Moo;
use Scalar::Util qw( looks_like_number );
with 'WebService::FitBit::Request';

has type => ( 
    is => 'ro', 
    default => sub { "GET" } 
);

has endpoint => ( 
    is => 'lazy', 
);

has oauth_consumer_secret => (
    is => 'ro',
);

has format => ( 
    is => 'ro', 
    isa => sub { $_[0] =~ /^(json|xml)$/ }, 
    default => sub { 'json' },
);

has collection => (
    is => 'ro',
    isa => sub { ! $_[0] or $_[0] =~ /^(activities|foods|sleep|body)$/ },
    default => sub { "body" },
);

sub _build_endpoint {
    my ( $self ) = @_;

    if ( $self->collection )  {
        return sprintf( "/1/user/-/%s/apiSubscriptions.%s", 
            $self->collection, $self->format
        );
    }
    return sprintf( "/1/user/-/apiSubscriptions/.%s", $self->format );
}

sub oauth_params {
    return {};
}

sub post_arguments {
    my ( $self ) = @_;

    return [  ];
}

sub query_params {  };
sub as_exception {
    my ( $self ) = @_;

    return {
        type => $self->type,
        endpoint => $self->endpoint,
        oauth_consumer_key => $self->oauth_consumer_key,
        format => $self->format,
        collection => $self->collection,
    };
}

1;
