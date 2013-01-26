package WebService::FitBit::Response::GetUserWeightGoal;
use Moo;
with 'WebService::FitBit::Response';
use WebService::FitBit::Response::GetUserWeight::Weight;
use Data::Dumper;

has goal => (
    is => 'lazy',
);

sub _build_goal {
    return $self->json->{goal};
}

1;
