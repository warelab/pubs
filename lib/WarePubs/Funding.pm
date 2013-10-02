package WarePubs::Funding;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;
use JSON;
use String::Trim 'trim';

# This action will render a template
sub list {
    my $self = shift;

    my $funding = $self->schema->resultset('Funding')->search(
      undef,
      {
        result_class => 'DBIx::Class::ResultClass::HashRefInflator',
      },
    );

    $self->respond_to(
        json => { json => [$funding->all] },
        txt  => { 'text' => Dumper([$funding->all]) },
        html => sub {
            $self->render(
                agency_id => $self->param('agency_id'),
                fundings => $funding,
            )
        }
    );
}

sub list_service {
    my $self = shift;
    my $order_by   = $self->param('order_by')   || 'title';
    my $sort_order = $self->param('sort_order') || 'asc';

    my $search_params;
    if ( my $filter = $self->param('filter') ) {
        $search_params = [];
        for my $fld (
            @{ $self->stash('config')->{'search_fields'}{'funding'} || [ 'title' ] }
        ) {
            push @$search_params, { $fld => { like => "%$filter%" } };
        }
    }

    my $agency_id = $self->param('agency_id');
    if ( $agency_id && $agency_id =~ /^\d+$/ ) {
        push @$search_params, { agency_id => $agency_id };
    }

    my $fundings   = $self->schema->resultset('Funding')->search_rs(
        $search_params,
        { order_by => { '-' . $sort_order => $order_by } }
    );
print STDERR "AID ", $agency_id, "\n";
    $self->respond_to(
        html => sub {
            $self->stash('layout', undef);
            $self->render(
                agency_id  => $agency_id,
                agencies   => [ $self->schema->resultset('Agency')->all ],
                fundings   => $fundings,
            )
        },
        csv => sub {
            my @cols  = @{ $self->stash('config')->{'download_fields'}{'funding'} || [] };
            my @funds = ([ @cols ]);

            while ( my $fund = $fundings->next ) {
                push @funds, [ map { $fund->get_column($_) } @cols ];
            }
            $self->render(text => \@funds)
        },

        json => sub {
            my @funds;
            while ( my $fund = $fundings->next ) {
                push @funds, { $fund->get_inflated_columns };
            }
            $self->render(json => [\@funds]);
        },
    );

}

sub create_form {
    my $self = shift;
print STDERR "FUNDING CF\n";
    $self->render(
        title => 'Create Funding',
        selected_agency_id => $self->param('agency_id'),
        agencies   => JSON->new->allow_nonref->encode(
            [
                (
                    {name => '--select agency--', value => ''},
                    map
                        {{name => $_->agency_name, value => $_->agency_id}}
                            $self->schema->resultset('Agency')->all
                )
            ]
        ),
    );
}

sub edit_form {
    my $self = shift;

    my $Funding = $self->schema->resultset('Funding')->find($self->param('funding_id'))
                  or die "Can't find funding id '" + $self->param('funding_id') + "'";
print STDERR "RENDERZ\n";

    $self->render(
        agencies   => JSON->new->allow_nonref->encode(
            [
                (
                    {name => '--select agency--', value => ''},
                    map
                        {{name => $_->agency_name, value => $_->agency_id}}
                            $self->schema->resultset('Agency')->all
                )
            ]
        ),

        funding  => $Funding,
        template => 'funding/create_form',
        title => 'Edit Funding',
    );
}

sub view {
    my $self = shift;
    my $funding_id = $self->param('funding_id');
    my ($Funding) = $self->schema->resultset('Funding')->find($funding_id)
        or die "Can't find agency id '$funding_id'";
    $self->render(funding => $Funding);

}

sub create {
    my ( $self ) = @_;

    my $agency_id    = $self->param('agency_id') or die 'No agency id';
    my ($Funding)    = $self->schema->resultset('Funding')->find_or_create({
        agency_id    => $agency_id,
        award_number => trim($self->param('award_number') || ''),
        title        => trim($self->param('title')        || ''),
        abstract     => trim($self->param('abstract')     || ''),
    });

    $self->redirect_to('agency-view', agency_id => $agency_id );
}

sub update {
    my $self = shift;
    my $funding_id   = $self->param('funding_id');
    my $Funding      = $self->schema->resultset('Funding')->find($funding_id)
                       or die "Can't find funding id '$funding_id'";

    $Funding->update({
        agency_id    => $self->param('agency_id'),
        award_number => trim($self->param('award_number')),
        title        => trim($self->param('title')),
        abstract     => trim($self->param('abstract')),
    });

    $self->redirect_to('funding-view', funding_id => $funding_id );
}


1;
