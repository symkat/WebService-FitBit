package WebService::FitBit::Request::CreateSubscription;
use Moo;
use Scalar::Util qw( looks_like_number );
with 'WebService::FitBit::Request';

has type => ( 
    is => 'ro', 
    default => sub { "POST" } 
);

has endpoint => ( 
    is => 'lazy', 
);

has oauth_consumer_key => (
    is => 'ro',
);

has oauth_consumer_secret => (
    is => 'ro',
);

has format => ( 
    is => 'ro', 
    isa => sub { $_[0] =~ /^(json|xml)$/ }, 
    default => sub { 'json' },
);

has id => (
    is => 'ro',
    isa => sub { looks_like_number($_[0]) },
    required => 1,
);

has collection => (
    is => 'ro',
    isa => sub { ! $_[0] or $_[0] =~ /^(activities|foods|sleep|body)$/ },
    default => sub { "body" },
);

sub _build_endpoint {
    my ( $self ) = @_;

    if ( $self->collection )  {
        return sprintf( "/1/user/-/%s/apiSubscriptions/%d-%s.%s", 
            map { $self->$_ } (qw( collection id collection format )) 
        );
    }
    return sprintf( "/1/user/-/apiSubscriptions/%d.%s", 
        $self->id, $self->format 
    );
}

sub oauth_params {
    return {};
}

sub post_arguments {
    my ( $self ) = @_;

    return [  ];
}

sub as_exception {
    my ( $self ) = @_;

    return {
        type => $self->type,
        endpoint => $self->endpoint,
        oauth_consumer_key => $self->oauth_consumer_key,
        format => $self->format,
        collection => $self->collection,
        id => $self->id,
    };
}

1;
