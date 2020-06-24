#include <omnetpp.h>
#include "inet/applications/udpapp/UdpBasicApp.h"
#include "inet/applications/base/ApplicationPacket_m.h"
#include "inet/common/TimeTag_m.h"
#include "inet/common/lifecycle/ModuleOperations.h"
#include "inet/common/packet/Packet.h"
#include "inet/networklayer/common/FragmentationTag_m.h"
#include "inet/networklayer/common/L3AddressResolver.h"
#include "inet/transportlayer/contract/udp/UdpControlInfo_m.h"



using namespace omnetpp;
using namespace inet ;





class  VoIPApp : public inet::UdpBasicApp
{
    public:
        unsigned long numPacketsLost;

//        simsignal_t packetLostSignal;
        VoIPApp();
        virtual ~VoIPApp();


    protected:
        virtual void initialize(int stage) override;
        virtual void finish() override;
        virtual void processPacket(Packet *pk) override;


};

Define_Module(VoIPApp);

VoIPApp::VoIPApp() {

}

VoIPApp::~VoIPApp() {

}


void VoIPApp::initialize(int stage)
{
    ApplicationBase::initialize(stage);

    if (stage == INITSTAGE_LOCAL) {
        numSent = 0;
        numReceived = 0;

        numPacketsLost = 0;

        WATCH(numSent);
        WATCH(numReceived);

        WATCH(numPacketsLost);

//        packetLostSignal = registerSignal("packetLost");

        localPort = par("localPort");
        destPort = par("destPort");
        startTime = par("startTime");
        stopTime = par("stopTime");
        packetName = par("packetName");
        dontFragment = par("dontFragment");
        if (stopTime >= SIMTIME_ZERO && stopTime < startTime)
            throw cRuntimeError("Invalid startTime/stopTime parameters");
        selfMsg = new cMessage("sendTimer");
    }


}


void VoIPApp::finish()
{
    recordScalar("packets sent", numSent);
    recordScalar("packets received", numReceived);
    recordScalar("packets lost", numPacketsLost);
    ApplicationBase::finish();
}



void VoIPApp::processPacket(Packet *pk)
{
       emit(packetReceivedSignal, pk);
       EV_INFO << "Received packet: " << UdpSocket::getReceivedPacketInfo(pk) << endl;
       simtime_t creationTime = pk->getCreationTime();

       EV << "UDP Packet creation time is : " << creationTime << " , \n";
       EV << "Time UDP packet took to arrive the destination : " << simTime() - creationTime  << " , \n";

       if(simTime() - creationTime > 0.2) {
           numPacketsLost++;
           EV << "Packet arrived after 200 milliseconds. Packet Lost" << " . " << " , \n";

           // packetLossStats.collect(1);
           // emit(packetLostSignal, numPacketsLost);
       }


       delete pk;
       numReceived++;
}





