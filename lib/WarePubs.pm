package WarePubs;

use Mojo::Base 'Mojolicious';
use Mojolicious::Plugin::TtRenderer;
use Mojolicious::Plugin::YamlConfig;
use WarePubs::Schema;

# ----------------------------------------------------------------------
sub startup {
    my $self = shift;

    $self->plugin('tt_renderer' => {LOAD_PERL => 1});
    my $config = $self->plugin(
        'yaml_config',
        { file => $self->home->rel_file('conf/ware_pubs.yaml') }
    );

    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer');

    $self->secret('Living is easy with eyes closed.');

    $self->defaults(layout => 'default');

    $self->helper(
        crud_url => sub {
            my $self   = shift;
            my $type   = shift;
            my $args   = shift || {};

            if (ref $type) {
                $args = $type;
                $type = $self->match->endpoint->parent->name;
            }

            my $action = $args->{'action'};
            my @arg_keys = grep {! /^(format|action)$/} keys %$args;

            my $parent = $self->app->routes->lookup($type);

            my %children = map {$_->name => $_} @{ $parent->children};

            my $child_route;

            if (defined $children{$action}) {
                $child_route = $children{$action};
            }
            elsif (@arg_keys) {
                $child_route = $children{'actionid'};
            }
            else {
                $child_route = $children{'action'};
            }

            return $child_route->render('', {action => $action, %$args});

        }
    );

    my $schema = WarePubs::Schema->connect( $self->config->{'connect_info'} );
    $self->helper( schema => sub { return $schema } );

    $self->hook(around_action => sub {
        my ($next, $c, $action, $last) = @_;
        if ($c->stash('format') eq 'ehtml') {
            $c->stash('format', 'html');
            $c->stash('layout', undef);
        }
        return $next->();
    });

    $self->hook(after_dispatch => sub {
        my $c = shift;

        if (defined $c->param('download')) {
            $c->res->headers->add(
                'Content-type' => 'application/force-download'
            );

            my $file = $c->req->url->path;
            $file =~ s!.+/!!;

            $c->res->headers->add(
                'Content-Disposition' => qq[attachment; filename=$file]
            );

            #$c->res->headers->add(
            #    'Content-Length' => length $text
            #);
        }

    });


    # Router
    my $r = $self->routes;

    # Normal route to controller
    $r->get('/')->to('main#index');
    $r->get('/about')->to('main#about');
    $r->get('/contact')->to('main#contact');
    $r->get('/test')->to('main#test');

    $r->get('/pub/list')->name('pub-list')->to(
        controller => 'pub',
        action     => 'list',
        format     => 'html',
    );

    $r->get('/agency/list')->name('agency-list')->to(
        controller => 'agency',
        action     => 'list',
        format     => 'html',
    );

    $r->get('/agency/view/:agency_id')->name('agency-view')->to(
        controller => 'agency',
        action     => 'view',
    );

#    $r->get('/agency/list_service')->to(
#        controller => 'agency',
#        action     => 'list_service',
#        format     => 'html',
#    );

    $r->get('/funding/list/:agency_id')->to(
        controller => 'funding',
        action     => 'list',
        format     => 'html',
        agency_id  => '',
    );

    $r->get('/funding/view/:funding')->name('funding-view-o')->to(
        controller => 'funding',
        action     => 'view',
    );

    $r->get('/funding/create_form/:agency_id')->name('funding-create-form')->to(
        controller => 'funding',
        action     => 'create_form',
        agency_id  => '',
    );

    $r->get('/funding/edit_form/:funding_id')->name('funding-edit-form')->to(
        controller => 'funding',
        action     => 'edit_form',
    );

    $r->post('/funding/create')->to(
        controller => 'funding',
        action     => 'create',
    );

#    $r->get('/funding/list_service/:agency_id')
#      ->name('funding-list_service')
#      ->to(
#        controller => 'funding',
#        action     => 'list_service',
#        format     => 'html',
#        agency_id  => '',
#    );

=pod
foreach my $path ( keys %{ $config->{crud} } ) {
    print STDERR "PATH $path\n";

    my $path_config = $config->{crud}->{$path};

    my $route = $r->route($path)->to(
        namespace  => 'Warelab',
        controller => 'CRUD',
        resultset  => $path_config->{ result_set }
    );

    foreach my $route ( keys %{ $path_config->{ routes } } ) {

    }

}
=cut

    my $pubs2 = $r->route('/pubs2')->name('pub')->to(namespace => 'Warelab',controller => 'CRUD::Pub', 'result_set_name' => 'Pub', format => 'json');
    $pubs2->get('/:action',      [ 'action' => [qw(list count edit)] ] );
    $pubs2->get('/:action/:id',  [ 'action' => [qw(view edit delete)] ] );
    $pubs2->post('/save/:id')->to(action => 'save', id => undef);

    my $agency2 = $r->route('/agency2')->name('agency')->to(namespace => 'Warelab',controller => 'CRUD', 'result_set_name' => 'Agency', format => 'json');
    $agency2->get('/:action',      [ 'action' => [qw(list count edit)] ] );
    $agency2->get('/:action/:id',  [ 'action' => [qw(view edit delete)] ] );
    $agency2->post('/save/:id')->to(action => 'save', id => undef);

    my $funding2 = $r->route('/funding2')->name('funding')->to(namespace => 'Warelab',controller => 'CRUD::Funding', 'result_set_name' => 'Funding', format => 'json');

    $funding2->get('/:action',      [ 'action' => [qw(list count edit)] ] );
    $funding2->get('/:action/:id',  [ 'action' => [qw(view edit delete)] ] );
    $funding2->post('/save/:id')->to(action => 'save', id => undef);

}

1;
