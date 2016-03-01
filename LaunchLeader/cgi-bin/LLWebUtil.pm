## LLWebUtil class
package LLWebUtil;

use strict;
use Data::Dumper;
use HTTP::Cookies;
use LWP::UserAgent;
use HTTP::Request::Common;
use LWP::Protocol::http;

=head1 NAME

LLWebUtil

This class contains few Utility functions that needs to use very frequently

=head1 SYNOPSIS

=over
    use LLWebUtil;
    LLWebUtil->getContent('http://www.google.com', \$content);

=back

=head1 METHODS

=over

=cut

=item B<new>

Constructor for the LLWebUtil class. This class has below fields
Fields: NetworkErrorSleep       - Number of seconds to wait after a network error detect
        NetworkRetryThreshold   - Number of times need to retry for any kind of network error
        HttpTimeout             - Number of seconds for timeout at LWP $ua->timeout(??)
        HttpUserAgent           - Useragent string for LWP $ua->agent(??)
        HttpUrl                 - This is the url from where the HTML source will retrive
        HttpReferer             - The referer url for HTTP request
        HttpParam               - Value for POST parameter, if the value is set, it will be POST method
        HttpCookie              - The cookie for the HTTP request
        UseHttpCookieJar        - if 0, cookie jar will not use, if 1, cookie jar will use.
                                    If file provided, it will use the file
                                    default is not to use the cookie-jar
        HttpContentType         - The content type for LWP
        HttpHeader              - The header hash key => value format, for HTTP request
        ContentFormat           - Define the format of the content, html/xml/rss/plain
        FollowRedirect          - Whether it will follow the redirection at get content
        IfUseProxy              - Define where LWP will use proxy or not.
        CGIPassPhrase           - Define the password string for CGI access
        BlockExpression         - Define the block expression, for example for captcha
                                it takes a set of expression as array
        ContentErrorExpression  - Define the custom has content error expression, for example for example
                                internal server error msg inside the HTML code
        StatusRetryHash         - This hash will contain the retry time for each status code
                                for example, 1 time retry for 500, 2 times retry for 404

Returns: An object of LLWebUtil class.

=cut
sub new {
    ## Get all the fields of the LLWebUtil class
    my ($class) = @_;
    ## Define all the fields for LLWebUtil Class
    my $self = {
        NetworkErrorSleep      => 1,
        NetworkRetryThreshold  => 3,
        HttpTimeout            => 10,
        HttpUserAgent          => 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:24.0) Gecko/20100101 Firefox/24.0',
        HttpUrl                => undef,
        HttpReferer            => undef,
        HttpParam              => '',
        HttpCookie             => undef,
        UseHttpCookieJar       => 0,
        HttpContentType        => 'application/x-www-form-urlencoded',
        HttpHeader             => undef,
        ContentFormat          => 'text/plain',
        FollowRedirect         => 7,
        IfUseProxy             => 0,
        CGIPassPhrase          => "",
        BlockExpression        => (),
        ContentErrorExpression => (),
        StatusRetryHash        => {'404' => 2, '500' => 1}
    };
    ## make $self as the reference of Expression class
    bless $self, $class;

    ## Return the reference, so it will use as an object
    return $self;
}

=item B<setNetworkErrorSleep>

Set the value of NetworkErrorSleep, for number of seconds to wait after a network error

Args    : $_timeout  - number of seconds to wait in second

=cut
sub setNetworkErrorSleep {

    ## Get all the fields of the WebContent class, and the timeout
    my ( $self, $_timeout ) = @_;
    $self->{NetworkErrorSleep} = $_timeout if defined($_timeout);
}


=item B<getNetworkErrorSleep>

Get the value of NetworkErrorSleep from the class

Args    : no params

Returns :The NetworkErrorSleep in seconds

=cut
sub getNetworkErrorSleep {

    ## Get all the fields of the WebContent class, and the timeout
    my ( $self ) = @_;
    if( defined( $self->{NetworkErrorSleep} ) ){
        return $self->{NetworkErrorSleep};
    }
    return 1;
}

=item B<setNetworkRetryThreshold>

Set the value of NetworkRetryThreshold, for number of times to retry for network error

Args    : $retry_count - number of times to retry for network error

=cut
sub setNetworkRetryThreshold {

    my ( $self, $retry_count ) = @_;
    $self->{NetworkRetryThreshold} = $retry_count if defined($retry_count);
}


=item B<getNetworkRetryThreshold>

Get the value of NetworkRetryThreshold from the class

Args    : no params

Returns : NetworkRetryThreshold

=cut
sub getNetworkRetryThreshold {

    my ( $self ) = @_;
    if( defined( $self->{NetworkRetryThreshold} ) ){
        return $self->{NetworkRetryThreshold};
    }
    return 2;
}

=item B<setHttpTimeout>

Set the value of HttpTimeout, for number of seconds for LWP to connect remote server

Args    : $__timeout - number of seconds to wait to connect at remot server

=cut
sub setHttpTimeout {

    my ( $self, $__timeout ) = @_;
    $self->{HttpTimeout} = $__timeout if defined($__timeout);
}

=item B<getHttpTimeout>

Get the value of HttpTimeout from the class

Args    : no params

Returns : HttpTimeout

=cut
sub getHttpTimeout {

    my ( $self ) = @_;
    if( defined( $self->{HttpTimeout} ) ){
        return $self->{HttpTimeout};
    }
    return 10;
}

=item B<setHttpUserAgent>

Set the value of HttpUserAgent, the agent string for LWP

Args    : $agent - the agent string

=cut
sub setHttpUserAgent {

    my ( $self, $agent ) = @_;
    $self->{HttpUserAgent} = $agent if defined($agent);
}


=item B<getHttpUserAgent>

Get the value of HttpUserAgent from the class

Args    : no params

Returns : HttpUserAgent

=cut
sub getHttpUserAgent {

    my ( $self ) = @_;
    if( defined( $self->{HttpUserAgent} ) ){
        return $self->{HttpUserAgent};
    }
    return "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:24.0) Gecko/20100101 Firefox/24.0";
}

=item B<setHttpUrl>

Set the value of HttpUrl, the spider url

Args    : $url - the url string

=cut
sub setHttpUrl {

    my ( $self, $url ) = @_;
    $self->{HttpUrl} = $url if defined($url);
}


=item B<getHttpUrl>

Get the value of HttpUrl from the class

Args    : no params

Returns : HttpUrl

=cut
sub getHttpUrl {

    my ( $self ) = @_;
    if( defined( $self->{HttpUrl} ) ){
        return $self->{HttpUrl};
    }
    return "";
}

=item B<setHttpReferer>

Set the value of HttpReferer, the spider referer url

Args    : $url - the referer string

=cut
sub setHttpReferer {

    my ( $self, $url ) = @_;
    $self->{HttpReferer} = $url if defined($url);
}


=item B<getHttpReferer>

Get the value of HttpReferer from the class

Args    : no params

Returns : HttpReferer

=cut
sub getHttpReferer {

    my ( $self ) = @_;
    if( defined( $self->{HttpReferer} ) ){
        return $self->{HttpReferer};
    }
    return "";
}

=item B<setHttpParam>

Set the value of HttpParam, the spider referer url

Args    : $param - the HTTP POST parameter string

=cut
sub setHttpParam {

    my ( $self, $param ) = @_;
    $self->{HttpParam} = $param if defined($param);
}

=item B<getHttpParam>

Get the value of HttpParam from the class

Args    : no params

Returns : HttpParam

=cut
sub getHttpParam {

    my ( $self ) = @_;
    if( defined( $self->{HttpParam} ) ){
        return $self->{HttpParam};
    }
    return "";
}

=item B<setHttpCookie>

Set the value of HttpCookie

Args    : $cookie - the HTTP cookie string

=cut
sub setHttpCookie {

    my ( $self, $cookie ) = @_;
    $self->{HttpCookie} = $cookie if defined($cookie);
}

=item B<getHttpCookie>

Get the value of HttpCookie from the class

Args    : no params

Returns : HttpCookie

=cut
sub getHttpCookie {

    my ( $self ) = @_;
    if( defined( $self->{HttpCookie} ) ){
        return $self->{HttpCookie};
    }
    return "";
}

=item B<setUseHttpCookieJar>

Set the value of UseHttpCookieJar

Args    : $is_cookie_jar - the HTTP cookie string

=cut
sub setUseHttpCookieJar {

    my ( $self, $is_cookie_jar ) = @_;
    $self->{UseHttpCookieJar} = $is_cookie_jar if defined($is_cookie_jar);
}

=item B<getUseHttpCookieJar>

Get the value of UseHttpCookieJar from the class

Args    : no params

Returns : UseHttpCookieJar

=cut
sub getUseHttpCookieJar {

    my ( $self ) = @_;
    if( defined( $self->{UseHttpCookieJar} ) ){
        return $self->{UseHttpCookieJar};
    }
    return 0;
}

=item B<setHttpContentType>

Set the value of HttpContentType

Args    : $type - the HTTP request content type

=cut
sub setHttpContentType {

    my ( $self, $type ) = @_;
    $self->{HttpContentType} = $type if defined($type);
}

=item B<getHttpContentType>

Get the value of HttpContentType from the class

Args    : no params

Returns : HttpContentType

=cut
sub getHttpContentType {

    my ( $self ) = @_;
    if( defined( $self->{HttpContentType} ) ){
        return $self->{HttpContentType};
    }
    return "application/x-www-form-urlencoded";
}

=item B<setContentFormat>

Set the value of ContentFormat, can be html, xml, rss, plain

Args    : $format - the HTTP request content type

=cut
sub setContentFormat {

    my ( $self, $format ) = @_;
    $self->{ContentFormat} = $format if defined($format);
}

=item B<setContentFormat>

Get the value of ContentFormat from the class

Args    : no params

Returns : ContentFormat

=cut
sub getContentFormat {

    my ( $self ) = @_;
    if( defined( $self->{ContentFormat} ) ){
        return $self->{ContentFormat};
    }
    return "";
}

=item B<addHttpHeader>

Add a header to the hash of HttpHeader

Args    : $key      - the key part of the header
          $value    - the value part of the header

=cut
sub addHttpHeader {

    my ( $self, $key, $value ) = @_;
    if( defined($key) && defined($value) ){
        $self->{HttpHeader}{"$key"} = $value;
    }
}


=item B<removeHttpHeader>

takes a key value as parameter, and remove the key from the HttpHeader

Args    : $key      - the key part of the header that needs to remove

=cut
sub removeHttpHeader {

    my ( $self, $key ) = @_;
    if( defined($key) && defined( $self->{HttpHeader}{"$key"} ) ){
        $self->{HttpHeader}{"$key"} = undef;
    }
}

=item B<getHttpHeader>

takes a key value as parameter, and return the current value of the key

Args    : $key      - the key part of the header

Return  : The value of that particular key

=cut
sub getHttpHeader {

    my ( $self, $key ) = @_;
    if( defined($key) ){
        return $self->{HttpHeader}{"$key"};
    }
    return "";
}

=item B<getAllHttpHeaders>

Return all the http headers as hash

Args    : no parms require

Return  : The HttpHeader hash

=cut
sub getAllHttpHeaders {

    my ( $self ) = @_;
    if( defined( $self->{HttpHeader}) ){
        return $self->{HttpHeader};
    }
    return ();
}

=item B<setFollowRedirect>

Set the value of FollowRedirect, either to 0 or 1

Args    : $set - the value that needs to set

=cut
sub setFollowRedirect {

    my ( $self, $set ) = @_;
    $self->{FollowRedirect} = $set if defined($set);
}

=item B<getFollowRedirect>

Get the value of FollowRedirect from the class

Args    : no params

Returns : FollowRedirect

=cut
sub getFollowRedirect {

    my ( $self ) = @_;
    if( defined( $self->{FollowRedirect} ) ){
        return $self->{FollowRedirect};
    }
    return 0;
}

=item B<setIfUseProxy>

Set the value of IfUseProxy, either to 0 or 1

Args    : $set - the value that needs to set

=cut
sub setIfUseProxy {

    my ( $self, $set ) = @_;
    $self->{IfUseProxy} = $set if defined($set);
}

=item B<getIfUseProxy>

Get the value of IfUseProxy from the class

Args    : no params

Returns : IfUseProxy

=cut
sub getIfUseProxy {

    my ( $self ) = @_;
    if( defined( $self->{IfUseProxy} ) ){
        return $self->{IfUseProxy};
    }
    return 0;
}

=item B<setCGIPassPhrase>

Set the value of CGIPassPhrase, either to 0 or 1

Args    : $set - the value that needs to set

=cut
sub setCGIPassPhrase {

    my ( $self, $set ) = @_;
    $self->{CGIPassPhrase} = $set if defined($set);
}

=item B<getCGIPassPhrase>

Get the value of CGIPassPhrase from the class

Args    : no params

Returns : CGIPassPhrase

=cut
sub getCGIPassPhrase {

    my ( $self ) = @_;
    if( defined( $self->{CGIPassPhrase} ) ){
        return $self->{CGIPassPhrase};
    }
    return 0;
}

=item B<setBlockExpression>

Set the value of BlockExpression, If no expression passed, it will set the array as undef
Otherwise it will push the expression inside the array

Args    : $set - the value that needs to set

=cut
sub setBlockExpression {

    my ( $self, $set ) = @_;
    if( defined($set) && $set ne ""){
        push( @{ $self->{BlockExpression} }, $set);
    }
    ## if no expression passed, that case undef the whole field
    else{
        $self->{BlockExpression} = undef;
    }
}

=item B<getBlockExpression>

Get the value of BlockExpression from the class

Args    : no params

Returns : BlockExpression

=cut
sub getBlockExpression {

    my ( $self ) = @_;
    if( defined( $self->{BlockExpression} ) ){
        return $self->{BlockExpression};
    }
    return ();
}

=item B<setStatusRetryHash>

Set the value of StatusRetryHash, If no hash key is passed, it will set the hash as undef
Otherwise it will add the key at hash with provided value

Args    : $key   - the value that needs to set
Args    : $value - the value that needs to set

=cut
sub setStatusRetryHash {

    my ( $self, $key, $value ) = @_;
    if( defined($key) && $key ne "" && $value ne ""){
        ${ $self->{StatusRetryHash} }{"$key"} = $value;
    }
    ## if no expression passed, that case undef the whole field
    else{
        %{ $self->{StatusRetryHash} } = ();
    }
}

=item B<getStatusRetryHash>

Get the value of StatusRetryHash from the class using key

Args    : key

Returns : value of provided key from StatusRetryHash

=cut
sub getStatusRetryHash {

    my ( $self, $key ) = @_;
    if( defined( ${ $self->{StatusRetryHash} }{"$key"} ) ){
        return ${ $self->{StatusRetryHash} }{"$key"};
    }
    return 1;
}

=item B<setContentErrorExpression>

Set the value of ContentErrorExpression, If no expression passed, it will set the array as undef
Otherwise it will push the expression inside the array

Args    : $exp  - the block expression
        : $stat - 1 to check with content, 0 to check with status line
        : retry - number or retry increment after match


=cut
sub setContentErrorExpression {

    my ( $self, $exp, $stat, $retry ) = @_;
    $stat = 1 if($stat eq '');
    $retry = 1 if($retry eq '');
    $stat = $stat * 1;
    $retry = $retry * 1;
    if( defined($exp) && $exp ne ""){
        my @set = ($exp, $stat, $retry);
        push( @{ $self->{ContentErrorExpression} }, \@set);
    }
    ## if no expression passed, that case undef the whole field
    else{
        $self->{ContentErrorExpression} = undef;
    }
}

=item B<getContentErrorExpression>

Get the value of ContentErrorExpression from the class

Args    : no params

Returns : ContentErrorExpression

=cut
sub getContentErrorExpression {

    my ( $self ) = @_;
    if( defined( $self->{ContentErrorExpression} ) ){
        return $self->{ContentErrorExpression};
    }
    return ();
}

=item B<getHttpContent>

Get the HTML source using the current variables from the class,
If the major variables are not provided, for example the URL, function return 0
But inside the hash reference required values will exist

Args    : Hash reference
            - content       = HTML source
            - header        = response header
            - status_code   = http status code
            - status_line   = status of response

Returns : FollowRedirect

=cut
sub getHttpContent {

    my ( $self, $hash ) = @_;

    my $ua = LWP::UserAgent->new();

    ## use cookie-jar, if it is asked to use
    if( $self->getUseHttpCookieJar() ){
        my $cookie_jar;
        ## if a digit is defined, then use default cookie, otherwise use a cookie fike
        if( $self->getUseHttpCookieJar() =~ /^\d$/ ){
            $cookie_jar = HTTP::Cookies->new();
        }
        else{
            $cookie_jar = HTTP::Cookies->new( file => $self->getUseHttpCookieJar() );
        }
        $ua->cookie_jar($cookie_jar);
    }

    ## clear the fields
    $$hash{'content'} = undef;
    $$hash{'status_code'} = undef;
    $$hash{'status_line'} = undef;
    $$hash{'header'} = undef;

    ## if timeout defined
    if( defined( $self->getHttpTimeout()) ){
        # print $self->getHttpTimeout() . "\n";
        $ua->timeout( $self->getHttpTimeout() );
    }

    ## set useragent
    if( defined( $self->getHttpUserAgent()) ){
        # print $self->getHttpUserAgent() . "\n";
        $ua->agent( $self->getHttpUserAgent() );
    }

    ## make a HTTP::Request object
    my $http_url = "";
    if(defined( $self->getHttpUrl()) ){
        # print $self->getHttpUrl() . "\n";
        $http_url = $self->getHttpUrl();
    }
    else{
        ## LLLogger->WARN("No URL provided");
        $$hash{'content'} = "";
        $$hash{'status_code'} = "400";
        $$hash{'status_line'} = "400 No URL Provided";
        $$hash{'header'} = "";
        return 0;
    }

    ## default is get method
    my $req = HTTP::Request->new(GET => $http_url);

    ## if any parameter passed, then its a post method, add the post param
    if( defined( $self->getHttpParam() ) && $self->getHttpParam() ne ""){
        $req = HTTP::Request->new(POST => $http_url);
        # print $self->getHttpParam() . "\n";
        $req->content( $self->getHttpParam() );
    }

    ## gzip is must if available
    $req->header('Accept-Encoding' => 'gzip');
    
    ## set the referer
    if(defined( $self->getHttpReferer() ) ){
        # print $self->getHttpReferer() . "\n";
        $req->header('referer' => $self->getHttpReferer() );
    }

    ## set the cookie
    if(defined( $self->getHttpCookie() ) ){
        # print $self->getHttpCookie() . "\n";
        $req->header('cookie' => $self->getHttpCookie() );
    }

    ## set the http request content type
    if(defined( $self->getHttpContentType() )){
        # print $self->getHttpContentType() . "\n";
        $req->content_type( $self->getHttpContentType() );
    }

    ## handle if follow request assigned
    if(defined( $self->getFollowRedirect() )){
        # print $self->getFollowRedirect() . "\n";
        $ua->max_redirect( $self->getFollowRedirect() );
    }

    if( ref( $self->getAllHttpHeaders() ) =~ /hash/i ){
        ## Adding the HTTP::Request header
        while( my($key, $val) = each( %{ $self->getAllHttpHeaders() } ) ){
            if( defined($key) && defined($val) ){
                $req->header($key => $val);
            }
        }
    }

    ## retry until the retry threshold, and the content is not valid
    my $retry = 0;
    my $return_flag = 0;
    do{
        if( $self->getIfUseProxy() != 0 ){
            ## $proxy_ipaddr = $self->getProxyIP();
            ## if( $proxy_ipaddr eq ""){
            ##    return -1;
            ## }
            ## change the proxy IP address
            ## $ua->proxy( ['http'] => "http://$local_ipaddr/" );
        }
        
        ## retry only for second time
        if( $retry > 0){
            my $time = $self->getNetworkErrorSleep();
            sleep( $time );
        }
        my $res = $ua->request($req);
    
        ## takes content
        $$hash{'content'} = $res->decoded_content(charset => 'none');
        ## takes status line
        $$hash{'status_line'} = $res->status_line();
        ## takes status code
        $$hash{'status_code'} = $res->code();
        ## takes header
        $$hash{'header'} = $res->headers();
    
    ## do-until the page has error, and I'm well inside the retry threshold 
    } while(($return_flag = $self->hasContentError($hash, \$retry) ) && $retry < $self->getNetworkRetryThreshold() );

    ## if the flag is 0, return 1
    ## if the flag is 1, return 0
    return (++$return_flag % 2);
}

=item B<checkIsBlockedBySite>

Take the expression from {BlockExpressio},
Match with fetched content, if expression matched, it will mark the IP as blocked

Args    : Hash reference
            - content       = HTML source
            - header        = response header
            - status_code   = status of response
            - status_line   = status of response
Returns ; 1 = if site blocked, 0 =  if not blocked

=cut
sub checkIsBlockedBySite{
    my ( $self, $hash ) = @_;
    
    my $expression = $self->getBlockExpression();
    for(@$expression){
        if( $_ ne "" && $$hash{'content'} =~ /$_/ims){
            return 1;
        }
    }
    return 0;
}


=item B<hasContentError>

Takes the HTML, header, and status line inside the hash reference,
check whether there are any errors inside the HTML source,
return 0 if any error, otherwise 1

Args    : Hash reference
            - content       = HTML source
            - header        = response header
            - status_line   = status of response

Returns : FollowRedirect

=cut
sub hasContentError {
    my ( $self, $hash, $retry ) = @_;

    ## xml/rss/html/plain
    my $format = $self->getContentFormat();
    
    if (!defined($$hash{'content'} )) {
        ## LLLogger->WARN( "Can't get required url");
        $$retry++;
        return 1;
    }
    if($$hash{'status_line'} =~ /404 Not Found/i) {
        ## LLLogger->WARN( "404 Not Found");
        $$retry += $self->getStatusRetryHash(404);
        return 1;
    }
    if($$hash{'status_line'} =~ /500 Can't connect/i) {
        ## LLLogger->WARN("500 Can't connect");
        $$retry += $self->getStatusRetryHash(500);
        return 1;
    }
    if($$hash{'status_line'} =~ /500 read timeout/i) {
        ## LLLogger->WARN( "500 read timeout");
        $$retry += $self->getStatusRetryHash(500);
        return 1;
    }

    if($$hash{'status_line'} !~ /^30\d/ && $$hash{'status_line'} !~ /^200/) {
        ## LLLogger->WARN( "ERROR STATUS LINE:".$$hash{'status_line'});
    }

    if( $format =~ /rss/i && $$hash{'content'} !~ /<\/rss>/i ){
        ## LLLogger->DEBUG( "Incomplete RSS");
        $$retry++;
        return 1;
    }
    if( $format =~ /html/i && $$hash{'content'} !~ /<\/html>/i ){
        ## LLLogger->DEBUG( "Incomplete HTML");
        $$retry++;
        return 1;
    }
    
    ## checking for XML, and plain is not used

    ## checking for custom error expression by matching
    my $expression = $self->getContentErrorExpression();
    foreach my $arr_ref(@$expression){
        my $exp  = $$arr_ref[0];
        my $stat = $$arr_ref[1];
        my $local_retry  = $$arr_ref[2];
        ## checking with content
        if($stat){
            if($exp ne "" && $$hash{'content'} =~ /$exp/ims){
                ## LLLogger->WARN("Custom hascontenterror expression matched [$exp]");
                ## LLLogger->WARN("URL:[".$self->{HttpUrl}."]");
                $$retry += $local_retry;
                return 1;
            }
        }
        ## else match with status-line
        else{
            if($exp ne "" && $$hash{'status_line'} =~ /$exp/i){
                ## LLLogger->WARN("Custom hascontenterror statusline matched [$exp]");
                ## LLLogger->WARN("URL:[".$self->{HttpUrl}."]");
                $$retry += $local_retry;
                return 1;
            }
        }
    }

    ## No error
    return 0;
}

1;


