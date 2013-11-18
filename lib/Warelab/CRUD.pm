package Warelab::CRUD;

use Mojo::Base 'Mojolicious::Controller';

sub get_filter {
    my $self = shift;

    my @keywords                = ();

    my $search_params           = {};

    my $filter = $self->param('filter') || return [];

    my $rs = $self->stash('result_set_name');

    my $columns = $self->stash('columns') || [ $self->schema->source($rs)->columns ];
    my $tbl_name = $self->schema->source($rs)->name;
#    print STDERR Dumper($self->schema->source($rs));
print STDERR "F1 $filter\n";
    if ($filter =~ /[,=]/) {
print STDERR "F $filter\n";
        my @values = split /,/, $self->param('filter');

        foreach my $v (@values) {
        print STDERR "SEE $v\n";
            if ($v =~ /=/) {
                my ($key, $val) = split /=/, $v;
                print STDERR "$key = $val\n";
                if ($search_params->{$key}) {
                    if (! ref $search_params->{$key}) {
                        $search_params->{$key} = [$search_params->{$key}, $val];
                    }
                    else {
                        push @{ $search_params->{$key} }, $val;
                    }
                }
                else {
                    $search_params->{$key} = $val;
                }
            }
            else {
                push @keywords, $v;
            }
        }
    }
    else {
        @keywords = ($filter);
    }
print STDERR "H\n";

    my @keyword_search = ();

    foreach my $keyword (@keywords) {
        print STDERR "EXPLICIT\n";
        foreach my $col ( grep { ! $search_params->{$_} } @$columns ) {
            push @keyword_search, { "me.$col" => { like => "%$keyword%" } };
        }
    }

print STDERR "FILTER\n"; print STDERR Dumper($search_params); use Data::Dumper;
print STDERR "able\n";
    return [ -and => [$search_params, \@keyword_search] ];

}


sub get_search_attrs {
    my $self = shift;

    return $self->stash('columns')
        ? { columns => $self->stash('columns') }
        : undef;
}

sub get_data {
    my $self = shift;

    my $rs      = $self->stash('result_set_name');
    my $filter  = $self->get_filter();

    my $attrs = $self->get_search_attrs();

    return $self->schema->resultset($rs)->search_rs($filter, $attrs);

}

sub count {

    my $self = shift;

    $self->render(
        layout => undef,
        text => $self->get_data()->count()
    );

}

sub list {
    my $self = shift;

    my $rs      = $self->stash('result_set_name');

    $self->stash('default_template', 'warelab/crud/list');

my $endpoint = $self->match->endpoint->to_string;
$endpoint =~ s/:action/$self->stash('action')/e;
$endpoint =~ s!/:id!!;
$endpoint =~ s!^/!!;
print STDERR "EP $endpoint\n";

$self->stash(template => $endpoint);

    $self->stash('columns', [ $self->schema->source($rs)->columns ]);
    print STDERR "I CAN LIST!\n";
    print STDERR "PATH ON : ", $self->match->path_for(action => 'view', 'id' =>77), "\n";
=pod
print STDERR "URL FV : " , $self->url_for('funding-view', {id => 77}), "\n";;
print STDERR "CUR : ", $self->current_route, "\n";
print STDERR "MATCH : ", Dumper($self->match), "\n"; use Data::Dumper;
print STDERR "PRIME MATCH : ", $self->match->endpoint->parent->name, "\n"; use Data::Dumper;
print STDERR "PRIME MATCH : ", $self->match->endpoint->parent->to_string, "\n"; use Data::Dumper;
print STDERR "PRIME MATCH : ", $self->match->endpoint->parent->find('edit')->to_string, "\n"; use Data::Dumper;
print map {"CHILD : " . $_->name . "\n";} @{ $self->match->endpoint->parent->children};
print STDERR "MATCH : ", Dumper($self->match->stack->[-1]), "\n"; use Data::Dumper;
print STDERR "PATH FOR : ", $self->match->path_for('foo' => 'bar'), "\n";
print STDERR "I AM NOW : ", $self->app->routes->lookup('current'), "\n";
print STDERR "I AM NOW : ", $self->url_for('current'), "\n";

my $match = Mojolicious::Routes::Match->new(root => $self->match->endpoint->parent->find('edit'));
print STDERR "PATH FOR MATCH : ", $match->endpoint, "\n";
print STDERR "match2->", $self->match->path_for('pvprime', id => 777), "\n";
=cut

    $self->respond_to(
        html => sub {
            $self->render_maybe or $self->render(template => $self->stash('default_template'));
        },
        json => sub {

            my $data_rs = $self->get_data();

            $self->render(
                json => [ map { { $_->get_columns } } $data_rs->all() ]
            );

        },
        txt => sub {

            my $data_rs = $self->get_data();

            $self->stash('data_rs', [$data_rs->all]);

            $self->render_maybe or $self->render(template => $self->stash('default_template'));

        },

    );
}

sub view {
    my $self = shift;

    my $rs      = $self->stash('result_set_name');
    $self->stash('source', $self->schema->source($rs));
    $self->stash('result_set', $self->schema->resultset($rs));

    $self->stash('default_template', 'warelab/crud/view');

print STDERR "TPL : ", $self->stash('template'), "\n";
print STDERR $self->match->endpoint->to_string, "\n";
print STDERR $self->stash('action'), "\n";
my $endpoint = $self->match->endpoint->to_string;
$endpoint =~ s/:action/$self->stash('action')/e;
$endpoint =~ s!/:id!!;
$endpoint =~ s!^/!!;
print STDERR "EP $endpoint\n";

$self->stash(template => $endpoint);
print STDERR "TP2 : ", $self->stash('template'), "\n";

    $self->respond_to(
        html => sub {
            $self->render_maybe or $self->render(template => $self->stash('default_template'));
        },
        json => sub {

            my $record = $self->stash('result_set')->find($self->param('id'));

            $self->render(
                json => map { { $_->get_columns } } $record
            );

        },
        txt => sub {

            my $record = $self->stash('result_set')->find($self->param('id'));
            $self->stash('record', $record);
print STDERR "END $endpoint\n";
            $self->render_maybe() or $self->render(template => $self->stash('default_template'));

        },

    );
}

sub delete {
    my $self = shift;
print STDERR "I DELETE NOW!\n";
    my $rs      = $self->stash('result_set_name');
    $self->stash('source', $self->schema->source($rs));
    $self->stash('result_set', $self->schema->resultset($rs));

    my $record = $self->stash('result_set')->find($self->param('id'));

    if ($record) {
        $record->delete();
    }

    $self->redirect_to(
        $self->crud_url( $self->match->endpoint->parent->name, {action => 'list', format => 'html'} )
    );

}

sub edit {
    my $self = shift;

    my $rs      = $self->stash('result_set_name');
    $self->stash('source', $self->schema->source($rs));
    $self->stash('result_set', $self->schema->resultset($rs));

    $self->stash('default_template', 'warelab/crud/edit');

    $self->respond_to(
        html => sub {
            $self->render_maybe or $self->render(template => $self->stash('default_template'));
        },
    );
}

sub save {
    my $self = shift;
print STDERR "I SAVE NOW!z\n";
    my $rs      = $self->stash('result_set_name');
    $self->stash('source', $self->schema->source($rs));
    $self->stash('result_set', $self->schema->resultset($rs));
print STDERR $self->param('id'), "\n";
    my $record = $self->stash('result_set')->find($self->param('id'));
print STDERR "REC $record\n";
    if (! $record) {
        $record = $self->stash('result_set')->new();
    }

    foreach my $col ($self->stash('source')->columns) {
        if ( length $self->param($col) ) {
            print STDERR "SETS $col to " . $self->param($col) . "\n";
            $record->$col( $self->param($col) );
        }
    }

    $record->update();

    $self->redirect_to(
        $self->crud_url( $self->match->endpoint->parent->name, {action => 'edit', id => $self->param('id'), format => 'html'} )
    );

}

1
