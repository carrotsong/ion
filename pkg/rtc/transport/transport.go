package transport

import (
	"github.com/carrotsong/rtcp"
	"github.com/carrotsong/rtp"
)

// type of transport
const (
	TypeWebRTCTransport = iota
	TypeRTPTransport

	TypeUnkown = -1
)

// Transport is a interface
type Transport interface {
	ID() string
	Type() int
	ReadRTP() (*rtp.Packet, error)
	WriteRTP(*rtp.Packet) error
	WriteRTCP(rtcp.Packet) error
	GetRTCPChan() chan rtcp.Packet
	Close()
	WriteErrTotal() int
	WriteErrReset()
	GetBandwidth() int
	SetShutdownChan(chan string)
}
