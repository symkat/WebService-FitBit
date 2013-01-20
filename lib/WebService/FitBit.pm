package WebService::FitBit;
use Moo;
use LWP::Authen::OAuth;
use Scalar::Util qw( looks_like_number );
use Module::Load;
use Try::Tiny;
use Data::Dumper;

our $VERSION = '0.001000'; # 0.1.0
$VERSION = eval $VERSION;

has oauth_consumer_secret => ( is => 'ro' );
has oauth_consumer_key    => ( is => 'ro' );

has api_base => ( 
    is => 'ro', 
    default => sub { "https://api.fitbit.com" } 
);

has 'user_agent' => ( 
    is => 'ro', 
    default => sub { "WebService::FitBit/$VERSION" },
);

has 'http_timeout' => ( 
    is => 'ro', 
    isa => sub { looks_like_number $_[0] },
    default => sub { 60 } 
);

has ua => ( 
    is => 'lazy', 
    isa => sub { ref $_[0] eq 'LWP::Authen::OAuth' } 
);

sub call {
    my ( $self, $class, $args ) = @_;

    try {
        load("WebService::FitBit::Request::$class");
    } catch {
        $self->_throw_exception(
            msg => "WebService::FitBit::Request::$class wasn't found.",
            line    => __LINE__,
            package => __PACKAGE__,
            args    => [ $class ],
            from    => $_, # The Compile Error.
        );
    };

    # Create Request Object
    my $request = try {
        "WebService::FitBit::Request::$class"->new( $args );
    } catch {
        $self->_throw_exception(
            msg         => "Creating API Request",
            line        => __LINE__,
            package     => __PACKAGE__,
            args        => [ $class, %{ $args } ],
            from        => $_, # Likely a WS::FB::Exception
        );
    };
    
    # Make HTTP Request
    my $http_response = try {
        $self->_do_call( $request );
    } catch {
        $self->_throw_exception(
            msg         => "Making HTTP Call",
            line        => __LINE__,
            package     => __PACKAGE__,
            args        => [ $class, %{ $args } ],
            from        => $_, # Likely a WS::FB::Exception
        );
    };

    # Create Response Object
    my $response = try {
        $self->_create_response( $class, $http_response );
    } catch {
        $self->_throw_exception (
            msg         => "Creating Response Object from API Call",
            line        => __LINE__,
            package     => __PACKAGE__,
            args        => [ $class, %{ $args } ],
            from        => $_, # Likely a WS::FB::Exception
        );
    };

    return $response;
}

sub _throw_exception {
    my ( $self, %args ) = @_;

    die Dumper( \%args );

}

sub _do_call {
    my ( $self, $request ) = @_;

    # Update OAuth Parameters.
    for my $param (qw(oauth_consumer_key oauth_token oauth_token_secret)) {
        $self->ua->$param( $request->$param ) if $request->can($param) && $request->$param;
    }

    my $http_response;

    if ( $request->type eq 'POST' ) {
        $http_response = try { 
            $self->ua->post( $self->api_base . $request->endpoint, $request->post_arguments );
        } catch {
            $self->_throw_exception (
                msg         => "Making HTTP Post",
                line        => __LINE__,
                package     => __PACKAGE__,
                args        => [ $request->as_exception ],
                from        => $_, # Likely a WS::FB::Exception
            );
        };
    } elsif ( $request->type eq 'GET' ) {
        $http_response = try { 
            $self->ua->get( $self->api_base . $request->endpoint, $request->query_params );
        } catch {
            $self->_throw_exception (
                msg         => "Making HTTP Post",
                line        => __LINE__,
                package     => __PACKAGE__,
                args        => [ $request->as_exception ],
                from        => $_, # Likely a WS::FB::Exception
            );
        };
    }

    return $http_response;
}

sub _create_response {
    my ( $self, $class, $http_response ) = @_;

    # Load response object.
    try {
        load("WebService::FitBit::Response::$class");
    } catch {
        $self->_throw_exception(
            msg => "WebService::FitBit::Response::$class wasn't found.",
            line    => __LINE__,
            package => __PACKAGE__,
            args    => [ $class ],
            from    => $_, # The Compile Error.
        );
    };

    # Create Request Object
    my $response = try {
        "WebService::FitBit::Response::$class"->new( { response => $http_response } );
    } catch {
        $self->_throw_exception(
            msg         => "Creating API Response",
            line        => __LINE__,
            package     => __PACKAGE__,
            args        => [ $class, %{ $http_response } ],
            from        => $_, # Likely a WS::FB::Exception
        );
    };

    return $response;
}

sub _build_ua {
    my ( $self ) = @_;

    return LWP::Authen::OAuth->new(
        oauth_consumer_secret => $self->oauth_consumer_secret,
        timeout               => $self->http_timeout,
        agent                   => $self->user_agent,
    );
}

1;
