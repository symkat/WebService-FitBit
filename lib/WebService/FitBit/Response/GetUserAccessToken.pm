package WebService::FitBit::Response::GetUserAccessToken;
use Moo;
with 'WebService::FitBit::Response';

has user_oauth_token => ( is => "lazy" );
has user_oauth_token_secret => ( is => "lazy" );


sub _build_user_oauth_token {
    my ( $self ) = @_;
    return $self->get_tokens( $self->response->content, "oauth_token" );
}

sub _build_user_oauth_token_secret {
    my ( $self ) = @_;
    return $self->get_tokens( $self->response->content, "oauth_token_secret" );
}

1;
