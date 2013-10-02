package WarePubs::Pubs;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;

# This action will render a template
sub list {
    my $self = shift;

    my $pubs = $self->schema->resultset('Pub')->search(
      undef,
      {
        result_class => 'DBIx::Class::ResultClass::HashRefInflator',
      },
    );

    my $config = $self->stash('config');
print STDERR "URL\n";
print STDERR Dumper($self->req->url->path->to_abs_string), "\n";
    $self->respond_to(
        json => { json => [$pubs->all] },
        txt  => { text => Dumper($config) },
        tab  => sub {

            my @headers = qw(year title journal authors doc_115);
            my $filter = $self->param('filter');

            my $text = join("\n", join("\t", @headers), grep {! defined $filter || /$filter/i} map {join("\t", @$_{@headers})} $pubs->all);

            if (defined $self->param('download')) {
                $self->res->headers->add('Content-type' => 'application/force-download');
                $self->res->headers->add('Content-Disposition' => "attachment; filename=\"pubs.txt\")");
                $self->res->headers->add('Content-Length' => length $text);
            }
                $self->render(text => $text);
        },
        html => sub {
            $self->render(
                pubs => $pubs,
            )
        }
    );
}


1;
