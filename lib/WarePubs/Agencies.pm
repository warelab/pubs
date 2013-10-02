package WarePubs::Agencies;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;

# This action will render a template

sub list {
    shift->render();
}

sub list_service {
    my $self = shift;

    my $order_by   = $self->param('order_by')   || 'agency_name';
    my $sort_order = $self->param('sort_order') || 'asc';

    my $search_params;
    if ( my $filter = $self->param('filter') ) {
        $search_params = [];
        for my $fld (
            @{ $self->stash('config')->{'search_fields'}{'agencies'} || [ 'agency_name' ] }
        ) {
            push @$search_params, { $fld => { like => "%$filter%" } };
        }
    }

    my $agencies = $self->schema->resultset('Agency')->search_rs(
        $search_params,
        { order_by => { '-' . $sort_order => $order_by } }
    );

    $self->stash('layout', undef);

    $self->respond_to(
        json => { json => [$agencies->all] },
        txt  => { 'text' => Dumper([$agencies->all]) },
        html => sub {
            $self->render(
                agencies => $agencies,
            )
        }
    );
}

sub view {
    my $self = shift;
    my $agency_id = $self->param('agency_id');
    my ($Agency) = $self->schema->resultset('Agency')->find($agency_id)
        or die "Can't find agency id '$agency_id'";
    $self->render(agency => $Agency);

}


1;
