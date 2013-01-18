package WebService::FitBit::Request::GetUserWeight;
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

has date => (
    is          => 'ro',
    isa         => sub { ref $_[0] eq 'DateTime' },
    default     => sub { DateTime->now },
);

has period => (
    is  => 'ro',
    isa => sub { ! $_[0] or grep { $_[0] eq $_ } ( qw( 1d 7d 30d 1w 1m )) },
    default => sub { undef },
);

has base_date => (
    is => 'ro',
    isa => sub { ! $_[0] or ref $_[0] eq 'DateTime' },
    default => sub { undef },
);

has end_date => (
    is => 'ro',
    isa => sub { ! $_[0] or ref $_[0] eq 'DateTime' },
    default => sub { undef },
);

has endpoint => ( 
    is => 'lazy',
);

sub _build_endpoint {
    my ( $self ) = @_;

    if ( $self->base_date && $self->end_date ) {
        return sprintf( 
            "/1/user/-/body/log/weight/date/%s/%s.%s",
            $self->base_date->ymd,
            $self->end_date->ymd,
            $self->format,
        );
    }

    if ( $self->base_date && $self->period ) {
        return sprintf( 
            "/1/user/-/body/log/weight/date/%s/%s.%s",
            $self->base_date->ymd,
            $self->period,
            $self->format,
        );
    }

    return sprintf( 
        "/1/user/-/body/log/weight/date/%s.%s",
        $self->date->ymd,
        $self->format,
    );
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
        endpoint => $self->endpoint,
        oauth_consumer_key => $self->oauth_consumer_key,
    };
}

1;
