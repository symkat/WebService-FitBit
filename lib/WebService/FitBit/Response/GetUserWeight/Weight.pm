package WebService::FitBit::Response::GetUserWeight::Weight;
use Moo;

for my $attribute  (qw( bmi date log_id time weight )) {
    has $attribute => ( is => 'ro' );
}

has weight_lbs    => ( is => 'lazy' );
has weight_stones => ( is => 'lazy' );

sub _build_weight_lbs {
    return shift->weight * 2.20462;
}

sub _build_weight_stones {
    return shift->weight * 0.157473
}

1;
