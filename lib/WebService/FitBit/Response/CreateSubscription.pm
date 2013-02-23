package WebService::FitBit::Response::CreateSubscription;
use Moo;
with 'WebService::FitBit::Response';


for (qw(owner_id subscriber_id owner_type collection_type subscription_id)) {
    has $_ => ( is => "lazy" );
}

sub _build_owner_id        { shift->json->{"ownerId"}; }
sub _build_subscriber_id   { shift->json->{"subscriberId"}; }
sub _build_owner_type      { shift->json->{"ownerType"}; }
sub _build_collection_type { shift->json->{"collectionType"}; }
sub _build_subscription_id { shift->json->{"subscriptionId"}; }

1;
