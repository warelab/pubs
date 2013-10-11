package WarePubs::Agency;

use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

# ----------------------------------------------------------------------  
sub list {
    my $self = shift;

    $self->respond_to(
        html => sub { $self->render },

        json => sub { 
            my $agencies = $self->_get_agencies;

            $self->render( 
                json => [ map { { $_->get_columns } } $agencies->all ] 
            );
        },

        txt  => sub { 
            my $agencies = $self->_get_agencies;
            $self->render( 
                text => Dumper([ map { { $_->get_columns } } $agencies->all ])
            );
        },

        tab  => sub {
            my $agencies = $self->_get_agencies;
            my $config   = $self->stash('config');
            my @headers  = @{
                $config->{'download_fields'}{'agency'} || ['agency_name']
            };

            my $text = join( "\t", @headers ) . "\n";
            for my $ag ( $agencies->all ) {
                $text .= join( "\t", map { $ag->$_() // '' } @headers ) . "\n";
            }

            if ( defined $self->param('download') ) {
                $self->res->headers->add(
                    'Content-type' => 'application/force-download'
                );

                $self->res->headers->add(
                    'Content-Disposition' => 
                        q[attachment; filename="agencies.txt"]
                );

                $self->res->headers->add(
                    'Content-Length' => length $text
                );
            }

            $self->render( text => $text );
        },
    );
}

# ----------------------------------------------------------------------  
sub view {
    my $self = shift;
    my $agency_id = $self->param('agency_id');
    my ($Agency) = $self->schema->resultset('Agency')->find($agency_id)
        or die "Can't find agency id '$agency_id'";
    $self->render(agency => $Agency);

}

# ----------------------------------------------------------------------  
sub _get_agencies {
    my $self       = shift;
    my $order_by   = $self->param('order_by')   || 'agency_name';
    my $sort_order = $self->param('sort_order') || 'asc';

    my $search_params;
    if ( my $filter = $self->param('filter') ) {
        $search_params = [];
        for my $fld (
            @{ $self->stash('config')->{'search_fields'}{'agency'} 
               || [ 'agency_name' ] 
            }
        ) {
            push @$search_params, { $fld => { like => "%$filter%" } };
        }
    }

    return $self->schema->resultset('Agency')->search_rs(
        $search_params,
        { order_by => { '-' . $sort_order => $order_by } }
    );
}

1;
