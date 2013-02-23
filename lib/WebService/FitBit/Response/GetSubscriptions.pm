package WebService::FitBit::Response::GetSubscriptions;
use Moo;
with 'WebService::FitBit::Response';


#for (qw(owner_id subscriber_id owner_type collection_type subscription_id)) {
#    has $_ => ( is => "lazy" );
#}
#
#sub _build_owner_id        { shift->_get_token( "collectionType" ); }
#sub _build_subscriber_id   { shift->_get_token( "ownerId" ); }
#sub _build_owner_type      { shift->_get_token( "ownerType" ); }
#sub _build_collection_type { shift->_get_token( "collectionType" ); }
#sub _build_subscription_id { shift->_get_token( "subscriptionId" ); }

#sub _get_token {
#    my ( $self, $token ) = @_;
#
#    my ( $content ) = $self->get_tokens( $self->response->content, $token );
#    
#    return $content;
#}


1;
