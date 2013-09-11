package WarePubs::Controller::Funding;

use Moose;
use String::Trim 'trim';
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WarePubs::Controller::Funding - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

# ----------------------------------------------------------------------
=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched WarePubs::Controller::Funding in Funding.');
}

# ----------------------------------------------------------------------
=head2 create
 
Create a fund.
 
=cut
 
sub create :Local {
    my ( $self, $c ) = @_;
    my $req          = $c->req;
    my $agency_id    = $req->param('agency_id') or die 'No agency id';
    my ($Funding)    = $c->model('DB')->resultset('Funding')->find_or_create({
        agency_id    => $agency_id,
        award_number => trim($req->param('award_number') || ''),
        title        => trim($req->param('title')        || ''),
        abstract     => trim($req->param('abstract')     || ''),
    });

    $c->res->redirect('/agency/view/' . $agency_id);
}

# ----------------------------------------------------------------------
=head2 create_form
 
Show create form.
 
=cut
 
sub create_form :Local {
    my ( $self, $c ) = @_;
 
    $c->stash(
        agencies => [ $c->model('DB')->resultset('Agency')->all ],
        template => 'funding-create-form.tmpl'
    );
}

# ----------------------------------------------------------------------
=head2 delete
 
Delete a funding.
 
=cut
 
sub delete :Local :Args(1) {
    my ( $self, $c, $funding_id ) = @_;
    my $req     = $c->req;
    my $Funding = $c->model('DB')->resultset('Funding')->find($funding_id)
                  or die "Can't find funding id '$funding_id'";
    my $ok      = $Funding->delete;

    $c->stash(
        message => sprintf(
            "Funding '%s' %sdeleted", $funding_id, $ok ? '' : 'NOT '
        )
    );

    $c->forward('View::JSON');
}

# ----------------------------------------------------------------------
=head2 edit_form
 
Edit a fund.
 
=cut
 
sub edit_form :Local :Args(1) {
    my ( $self, $c, $funding_id ) = @_;
    my $req     = $c->req;
    my $Funding = $c->model('DB')->resultset('Funding')->find($funding_id)
                  or die "Can't find funding id '$funding_id'";

    $c->stash(
        agencies => [ $c->model('DB')->resultset('Agency')->all ],
        funding  => $Funding,
        template => 'funding-edit-form.tmpl',
    );
}

# ----------------------------------------------------------------------
=head2 list
 
Fetch all fundings.
 
=cut
 
sub list :Local {
    my ($self, $c) = @_;
    my $fundings   = $c->model('DB')->resultset('Funding')->search(
        undef,
        { order_by => { '-asc' => 'title' } }
    );

    $c->stash(
        fundings => $fundings,
        template => 'funding-list.tmpl',
    );
}

# ----------------------------------------------------------------------
=head2 list_service
 
Fetch all fundings.
 
=cut
 
sub list_service :Local {
    my ($self, $c) = @_;
    my $req        = $c->req;
    my $format     = $req->param('format')     || 'json';
    my $order_by   = $req->param('order_by')   || 'title';
    my $sort_order = $req->param('sort_order') || 'asc';

    my $search_params;
    if ( my $filter = $req->param('filter') ) {
        $search_params = [];
        for my $fld ( 
            @{ $c->config->{'search_fields'}{'funding'} || [ 'title' ] }
        ) {
            push @$search_params, { $fld => { like => "%$filter%" } };
        }
    }

    my $agency_id = $req->param('agency_id');
    if ( $agency_id =~ /^\d+$/ && $agency_id ) {
        push @$search_params, { agency_id => $agency_id };
    }

    my $fundings   = $c->model('DB')->resultset('Funding')->search_rs(
        $search_params,
        { order_by => { '-' . $sort_order => $order_by } }
    );

    if ( lc $format eq 'html' ) {
        $c->stash(
            agency_id  => $agency_id,
            agencies   => [ $c->model('DB')->resultset('Agency')->all ],
            fundings   => $fundings,
            template   => 'funding-list-service.tmpl',
            no_wrapper => 1,
        );
    }
    elsif ( lc $format eq 'csv' ) {
        my @cols  = @{ $c->config->{'download_fields'}{'funding'} || [] };
        my @funds = ([ @cols ]);

        while ( my $fund = $fundings->next ) {
            push @funds, [ map { $fund->get_column($_) } @cols ];
        }

        $c->stash( csv => \@funds );
        $c->forward('View::CSV');
    }
    else {
        my @funds;
        while ( my $fund = $fundings->next ) {
            push @funds, { $fund->get_inflated_columns };
        }

        $c->stash( funds => \@funds );
        $c->forward('View::JSON');
    }
}

# ----------------------------------------------------------------------
=head2 update
 
Update a fund.
 
=cut
 
sub update :Local {
    my ( $self, $c ) = @_;
    my $req          = $c->req;
    my $funding_id   = $req->param('funding_id') or die 'No funding id';
    my $Funding      = $c->model('DB')->resultset('Funding')->find($funding_id)
                       or die "Can't find funding id '$funding_id'";

    $Funding->update({
        agency_id    => $req->param('agency_id'),
        award_number => trim($req->param('award_number')),
        title        => trim($req->param('title')),
        abstract     => trim($req->param('abstract')),
    });

    $c->res->redirect( $c->uri_for('/funding/view', $funding_id) );
}

# ----------------------------------------------------------------------
=head2 view
 
Detail for a single funding.
 
=cut
 
sub view :Local {
    my ( $self, $c, $funding_id ) = @_;
 
    $c->stash(
        funding  => $c->model('DB')->resultset('Funding')->find($funding_id),
        template => 'funding-view.tmpl'
    );
}

# ----------------------------------------------------------------------
=head1 AUTHOR

Ken Youens-Clark

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
