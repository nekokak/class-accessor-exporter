package Class::Accessor::Exporter;
use strict;
use warnings;

our $VERSION = '0.01';

sub import {
    my $caller = caller;

    {
        no strict 'refs';
        *{"$caller\::new"} = \&_new;
        *{"$caller\::mk_accessors"} = \&_mk_accessors;
    }
}

sub _new {
    my ($class, $args) = @_;
    $args ||= {};
    my $self = bless {%$args}, $class;

    if ( $class->can('init') ) {
        $self->init;
    }

    return $self;
}

sub _mk_accessors {
    my $caller = caller;

    {
        no strict 'refs';
        for my $n (@_) {
            *{"$caller\::$n"} = __m($n);
        }
    }
}

sub __m {
    my $n = shift;
    sub {
        return $_[0]->{$n} if @_ == 1;
        return $_[0]->{$n} = $_[1] if @_ == 2;
        shift->{$n} = \@_;
    };
}


=head1 NAME

Class::Accessor::Exporter - Module abstract (<= 44 characters) goes here

=head1 SYNOPSIS

  package Your::Module;
  use Class::Accessor::Exporter;
  mk_accessors(qw/foo bar/);
  
  use Your::Module;
  my $m = Your::Module->new;
  $m->foo('bar');
  print $m->foo; # bar

=head1 DESCRIPTION

This is a minimalitic variant of C<Class::Accessor> and its a likes.

base code is C<Class::Accessor::Lite>.

=head1 AUTHOR

Atsushi Kobayashi <nekokak _at_ gmail dot com>

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut

1;
