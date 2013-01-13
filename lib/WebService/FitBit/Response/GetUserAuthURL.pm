package WebService::FitBit::Response::GetUserAuthURL;
use Moo;
with 'WebService::FitBit::Response';


has user_auth_url => (
    is => 'lazy',
);



sub _build_user_auth_url {
    my ( $self ) = @_;

    my ( $token ) = $self->get_tokens( $self->response->content, "oauth_token" );
    
    return sprintf( "https://www.fitbit.com/oauth/authorize?oauth_token=%s", $token );
}

1;
