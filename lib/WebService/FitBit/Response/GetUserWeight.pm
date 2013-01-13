package WebService::FitBit::Response::GetUserWeight;
use Moo;
with 'WebService::FitBit::Response';
use WebService::FitBit::Response::GetUserWeight::Weight;
use Data::Dumper;

has count => (
    is => 'lazy',
);

has first => (
    is => 'lazy',
);

has last => (
    is => 'lazy',
);

has collection => (
    is => 'lazy',
);

sub _build_collection {
    my ( $self ) = @_;

    my @collection;
    
    print Dumper $self->response;

    for my $elem ( @{ $self->json->{weight} } ) {
        push @collection, WebService::FitBit::Response::GetUserWeight::Weight->new(
            bmi    => $elem->{bmi},
            date   => $elem->{date},
            time   => $elem->{time},
            log_id => $elem->{logId},
            weight => $elem->{weight},
        );
    }

    return [ @collection ];
}

sub _build_first {
    return @{shift->collection}[0];
}

sub _build_last {
    return @{shift->collection}[-1];
}

sub _build_count {
    return scalar @{shift->collection};
}

# Are programmers too dumb for map { $_->foo } @{$res->collection}?  No...
# let's remove this before shipping (totally fun to play with though)
sub as_list_of {
    my ( $self, $attribute, $filter ) = @_;
    $self->first->can( $attribute ) or return ();

    my @list = map { $_->$attribute  } @{ $self->collection };

    return ref $filter eq 'CODE' ? $filter->(@list) : [ @list ];
}

1;
