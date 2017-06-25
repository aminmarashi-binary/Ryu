package Ryu;
# ABSTRACT: stream and data flow handling for async code
use strict;
use warnings;

our $VERSION = '0.021';

=encoding utf8

=head1 NAME

Ryu - asynchronous stream building blocks

=head1 SYNOPSIS

# EXAMPLE: examples/synopsis.pl

=head1 DESCRIPTION

B<This is an early preview release, but is almost useful for some limited tasks>.

Provides data flow processing for asynchronous coding purposes. It's a bit like L<ReactiveX|https://reactivex.io> in
concept. Where possible, it tries to provide a similar API. It is not a directly-compatible implementation, however.

=head2 Why would I be using this?

Eventually some documentation pages might appear, but at the moment they're unlikely to exist.

=over 4

=item * Network protocol implementations - if you're bored of stringing together C<substr>, C<pack>, C<unpack>
and C<vec>, try L<Ryu::Manual::Protocol>

=item * Extract, Transform, Load workflows (ETL) - need to pull data from somewhere, mangle it into shape, push it to
a database? that'd be L<Ryu::Manual::ETL>

=item * Reactive event handling - L<Ryu::Manual::Reactive>

=back

As an expert software developer with a keen eye for useful code, you may already be bored of this documentation
and on the verge of reaching for alternatives. The L</SEE ALSO> section may speed you on your way.

=head2 Components

=head3 Streams

A stream is a thing with a source. See L<Ryu::Stream>, which is likely to be something that does not yet
exist.

=head3 Sources

A source emits items. See L<Ryu::Source>.

Items can be any scalar value - some examples:

=over 4

=item * a single byte

=item * a character

=item * a byte string

=item * a character string

=item * an object instance

=item * an arrayref or hashref

=back

There's also a sink, which connects to a (chain of) sources and accepts values.

=head2 What does this module do?

Nothing. It's just a top-level loader for pulling in all the other components.

=head2 Some notes that might not relate to anything

With a single parameter, L</from> and L</to> will use the given
instance as a L<Ryu::Source> or L<Ryu::Sink> respectively.

Multiple parameters are a shortcut for instantiating the given source
or sink:

 my $stream = Ryu::Stream->from(
  file => 'somefile.bin'
 );

is equivalent to

 my $stream = Ryu::Stream->from(
  Ryu::Source->new(
   file => 'somefile.bin'
  )
 );

=head1 Why the name?

=over 4

=item * C< $ryu > lines up with typical 4-character indentation settings.

=item * there's Rx for other languages, and this is based on the same ideas

=item * 流 was too hard for me to type

=back

=cut

use Exporter qw(import export_to_level);

use Ryu::Source;

our $ryu = __PACKAGE__->new;

our @EXPORT_OK = qw($ryu);

sub new { bless { @_[1..$#_] }, $_[0] }

=head2 from

Helper method which returns a L<Ryu::Source> from a list of items.

=cut

sub from {
	my $self = shift;
	my $src = Ryu::Source->new;
	$src->from(@_)
}

=head2 just

Helper method which returns a single-item L<Ryu::Source>.

=cut

sub just {
	my $self = shift;
	my $src = Ryu::Source->new;
	$src->from(shift);
}

1;

__END__

=head1 SEE ALSO

=head2 Other modules

Some perl modules of relevance:

=over 4

=item * L<Future> - fundamental building block for one-shot tasks

=item * L<POE::Filter> - venerable and battle-tested, but slightly short on features due to the focus on protocols

=item * L<Data::Transform> - standalone version of L<POE::Filter>

=item * L<List::Gen> - list mangling features

=item * L<HOP::Stream> - based on the Higher Order Perl book

=item * L<Flow> - quite similar in concept to this module, maybe a bit short on documentation, doesn't provide integration with other sources such as files or L<IO::Async::Stream>

=item * L<Flux> - more like the java8 streams API, sync-based 

=item * L<Message::Passing> - on initial glance seemed more of a commandline tool, sadly based on L<AnyEvent>

=item * L<Rx.pl|https://github.com/eilara/Rx.pl> - a Perl version of the L<http://reactivex.io> Reactive API

=item * L<IO::Pipeline>

=item * L<DS>

=item * L<Evo>

=item * L<Async::Stream> - early release, but seems to be very similar in concept to L<Ryu::Source>

=back

=head2 Other references

There are various documents, specifications and discussions relating to the concepts we use. Here's a few:

=over 4

=item * L<http://www.reactivemanifesto.org/>

=item * Java 8 L<streams API|https://docs.oracle.com/javase/8/docs/api/java/util/stream/package-summary.html>

=item * C++ L<range-v3|https://github.com/ericniebler/range-v3>

=back

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2011-2017. Licensed under the same terms as Perl itself.

