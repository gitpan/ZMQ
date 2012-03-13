package ZMQ::Message;
use strict;

sub new {
    my ($class, $data) = @_;
    bless {
        _message => ZMQ::Raw::zmq_msg_init_data( $data )
    }, $class;
}

sub new_from_message {
    my ($class, $message) = @_;
    bless {
        _message => $message
    }, $class;
}

sub message {
    $_[0]->{_message};
}

sub data {
    ZMQ::Raw::zmq_msg_data( $_[0]->message );
}

sub size {
    ZMQ::Raw::zmq_msg_size( $_[0]->message );
}

1;

__END__

=head1 NAME

ZMQ::Message - A 0MQ Message object

=head1 SYNOPSIS

  use ZMQ qw/:all/;
  
  my $cxt = ZMQ::Context->new;
  my $sock = ZMQ::Socket->new($cxt, ZMQ_REP);
  my $msg = ZMQ::Message->new($text);
  $sock->send($msg);
  my $anothermsg = $sock->recv;

=head1 DESCRIPTION

A C<ZMQ::Message> object represents a message
to be passed over a C<ZMQ::Socket>.

=head1 METHODS

=head2 new

Creates a new C<ZMQ::Message>.

Takes the data to send with the message as argument.

=head2 new_from_message( $rawmsg )

Creates a new C<ZMQ::Message>.

Takes a ZMQ::Raw::Message object as argument.

=head2 message

Return the underlying ZMQ::Raw::Message object.

=head2 size

Returns the length (in bytes) of the contained data.

=head2 data

Returns the data as a (potentially binary) string.

=head1 SEE ALSO

L<ZMQ>, L<ZMQ::Socket>, L<ZMQ::Context>

L<http://zeromq.org>

L<ExtUtils::XSpp>, L<Module::Build::WithXSpp>

=head1 AUTHOR

Daisuke Maki E<lt>daisuke@endeworks.jpE<gt>

Steffen Mueller, E<lt>smueller@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

The ZMQ module is

Copyright (C) 2010 by Daisuke Maki

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.0 or,
at your option, any later version of Perl 5 you may have available.

=cut
