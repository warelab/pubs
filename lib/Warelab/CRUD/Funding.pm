package Warelab::CRUD::Funding;

use Mojo::Base 'Warelab::CRUD';

sub get_search_attrs {
    my $self = shift;

    my $attrs = $self->SUPER::get_search_attrs;

    my $filter = $self->get_filter;
    print STDERR "F\n";
    print STDERR Dumper($filter); use Data::Dumper;

    # first element of the filter is '-and', second is an arrayref
    # first element is k/v pairs, second is list of keywords
#print STDERR $filter, "\n";
#print STDERR $filter->[1], "\n";
#print STDERR $filter->[1]->[0], "\n";
    if (defined $filter->[1]->[0]->{'pub_id'}) {
        $attrs->{'join'} = {'pub_to_fundings' => 'pub'},
    }

    print Dumper($attrs); use Data::Dumper;
    print Dumper($filter);

    return $attrs;

}

1;
