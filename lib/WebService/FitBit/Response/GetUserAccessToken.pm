package WebService::FitBit::Response::GetUserAccessToken;
use Moo;
with 'WebService::FitBit::Response';
use Devel::Dwarn;

has user_oauth_token => ( is => "lazy" );
has user_oauth_token_secret => ( is => "lazy" );

sub _build_user_oauth_token {
    return shift->body_args->{oauth_token};
}

sub _build_user_oauth_token_secret {
    return shift->body_args->{oauth_token_secret};
}

1;
