package WarePubs;

use Mojo::Base 'Mojolicious';
use Mojolicious::Plugin::TtRenderer;
use Mojolicious::Plugin::YamlConfig;
use WarePubs::Schema;

# ----------------------------------------------------------------------  
sub startup {
    my $self = shift;

    $self->plugin('tt_renderer');
    $self->plugin(
        'yaml_config', 
        { file => $self->home->rel_file('conf/ware_pubs.yaml') }
    );

    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer');

    $self->secret('Living is easy with eyes closed.');

    $self->defaults(layout => 'default');

    $self->helper( 
        schema => sub { 
            WarePubs::Schema->connect( $self->config->{'connect_info'} ) 
        } 
    );

    # Router
    my $r = $self->routes;

    # Normal route to controller
    $r->get('/')->to('main#index');

    $r->get('/pub/list')->name('pub-list')->to(
        controller => 'pub',
        action => 'list',
        format => 'html',
    );

    $r->get('/agency/list')->to(
        controller => 'agency',
        action => 'list',
        format => 'html',
    );

    $r->get('/agency/view/:agency_id')->name('agency-view')->to(
        controller => 'agency',
        action => 'view',
    );

    $r->get('/funding/view/:funding')->name('funding-view')->to(
        controller => 'funding',
        action => 'view',
    );

    $r->get('/agency/list_service')->to(
        controller => 'agency',
        action => 'list_service',
        format => 'html',
    );

    $r->get('/funding/list/:agency_id')->to(
        controller => 'funding',
        action => 'list',
        format => 'html',
        agency_id => '',
    );

    $r->get('/funding/create_form/:agency_id')->name('funding-create_form')->to(
        controller => 'funding',
        action => 'create_form',
        agency_id => '',
    );

    $r->get('/funding/edit_form/:funding_id')->name('funding-edit_form')->to(
        controller => 'funding',
        action => 'edit_form',
    );

    $r->post('/funding/create')->to(
        controller => 'funding',
        action => 'create',
    );

    $r->get('/funding/list_service/:agency_id')
      ->name('funding-list_service')
      ->to(
        controller => 'funding',
        action => 'list_service',
        format => 'html',
        agency_id => '',
    );

}

1;
