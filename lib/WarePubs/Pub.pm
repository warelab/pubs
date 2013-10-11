package WarePubs::Pub;

use Data::Dumper;
use Mojo::Base 'Mojolicious::Controller';

# ----------------------------------------------------------------------  
sub list {
    my $self = shift;

    $self->respond_to(
        html => sub { $self->render },

        json => sub {
            my $pubs = $self->_get_pubs;
            $self->render( 
                json => [ map { { $_->get_columns } } $pubs->all ] 
            );
        },

        txt  => sub { 
            my $pubs = $self->_get_pubs;
            $self->render( 
                text => Dumper([ map { { $_->get_columns } } $pubs->all ])
            );
        },

        tab  => sub {
            my $pubs    = $self->_get_pubs;
            my $config  = $self->stash('config');
            my @headers = @{$config->{'download_fields'}{'pub'} || ['title']};
            my $text    = join( "\t", @headers ) . "\n";

            for my $pub ( $pubs->all ) {
                $text .= join( "\t", map { $pub->$_() // '' } @headers ) . "\n";
            }

            if (defined $self->param('download')) {
                $self->res->headers->add(
                    'Content-type' => 'application/force-download'
                );

                $self->res->headers->add(
                    'Content-Disposition' => q[attachment; filename="pubs.txt"]
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
sub _get_pubs {
    my $self       = shift;
    my $order_by   = $self->param('order_by')   || 'title';
    my $sort_order = $self->param('sort_order') || 'asc';
    my $config     = $self->stash('config');

    my $search_params;
    if ( my $filter = $self->param('filter') ) {
        $search_params = [];
        for my $fld (
            @{ $config->{'search_fields'}{'pub'} || [ 'title' ] }
        ) {
            push @$search_params, { $fld => { like => "%$filter%" } };
        }
    }

    return $self->schema->resultset('Pub')->search_rs(
        $search_params,
        { order_by => { '-' . $sort_order => $order_by } }
    );
}

1;
