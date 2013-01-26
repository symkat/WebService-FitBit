package WebService::FitBit::Response::GetUserWeightGoal;
use Moo;
with 'WebService::FitBit::Response';
use WebService::FitBit::Response::GetUserWeight::Weight;
use Data::Dumper;

for ( qw( goal_weight goal_start_weight goal_start_date ) ) {
    has $_ => ( is => "lazy" );
}

sub _build_goal_weight {
    return shift->json->{goal}->{weight};
}

sub _build_goal_start_weight {
    return shift->json->{goal}->{startWeight};
}

sub _build_goal_start_date {
    return shift->json->{goal}->{startDate};
}



1;
