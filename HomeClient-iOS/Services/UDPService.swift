import Foundation
import Network

class UDPService {

    private let connection: NWConnection
    private var connectionState: NWConnection.State?
    
    private let connectionHost: NWEndpoint.Host = "127.0.0.1"
    private let connectionPort: NWEndpoint.Port = 8080

    init() {
        self.connection = NWConnection(host: connectionHost, port: connectionPort, using: .udp)
        self.connection.stateUpdateHandler = { (newState) in
            self.connectionState = newState
            switch (newState) {
                case .ready:
                    print("State: Ready\n")
                case .setup:
                    print("State: Setup\n")
                case .cancelled:
                    print("State: Cancelled\n")
                case .preparing:
                    print("State: Preparing\n")
                default:
                    print("ERROR! State not defined!\n")
            }
        }
        self.connection.start(queue: .global())
    }
    
    public func sendUdp(_ content: Data?, _ handleFinish: @escaping (_ error: Error?) -> Void ) {
        if self.connectionState != .ready {
            handleFinish(Error("Cannot send UDP Packet: connectionState: \(String(describing: connectionState))", .UDP_ERROR))
            return
        }
        if content == nil {
            handleFinish(Error("Cannot send UDP Packet: Content is nil.", .UDP_ERROR))
            return
        }
        self.connection.send(content: content, completion: .contentProcessed( { NWError in
            if (NWError) != nil {
                handleFinish(Error("Cannot send UDP Packet: \(String(describing: NWError))", .UDP_ERROR))
            } else {
                handleFinish(nil)
            }
        }))
    }
    
    public func receiveUdp(_ handleFinish: @escaping (_ error: Error?, _ result: Data?) -> Void) {
        if self.connectionState != .ready {
            handleFinish(Error("Cannot receive UDP Packet: connectionState: \(String(describing: connectionState))", .UDP_ERROR), nil)
            return
        }
        self.connection.receiveMessage(completion: { data, context, isComplete, error in
            if isComplete {
                if data != nil {
                    handleFinish(nil, data)
                } else {
                    handleFinish(Error("Cannot receive UDP Packet: \(String(describing: error))", .UDP_ERROR), nil)
                }
            }
        })
    }

}
