package WebService::FitBit::Response::GetUserAuthURL;
use Moo;
with 'WebService::FitBit::Response';


has user_auth_url => (
    is => 'lazy',
);

has oauth_token_secret => (
    is => 'lazy',
);


sub _build_user_auth_url {
    my ( $self ) = @_;

    my ( $token, $secret ) = $self->get_tokens( $self->response->content, "oauth_token" );
    
    return sprintf( "https://www.fitbit.com/oauth/authorize?oauth_token=%s", $token );
}

sub _build_oauth_token_secret {
    my ( $self ) = @_;
    
    my ( $secret ) = $self->get_tokens( $self->response->content, "oauth_token_secret" );

    return $secret;
}

1;
