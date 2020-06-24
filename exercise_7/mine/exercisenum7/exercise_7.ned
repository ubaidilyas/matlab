

import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import ned.DatarateChannel;
import ned.IdealChannel;
import inet.applications.udpapp.UdpBasicApp;

network exercise_7
{
    parameters:
        int numBackboneRouters = default(5);
        int numAccessRouters = default(5);
        int numUsers = default(25);
    types:
        channel GatewayBackboneRouterChannel extends DatarateChannel
        {
            datarate = default(10 Mbps);
            delay = default(10 ms);

        }
        channel BackboneAccessRoutersChannel extends DatarateChannel
        {
            datarate = default(2 Mbps);
            delay = default(15 ms);

        }
        channel AccessRouterUserChannel extends DatarateChannel
        {
//            datarate = default(2 Mbps);
//            delay = default(40 ms);

        }
        
        
        channel InternetGatewayChannel extends DatarateChannel {
           
        }
    submodules:
        Gateway: Router {
            @display("p=138.25,121.62499");
        }
        BackboneRouters[numBackboneRouters]: Router {
            @display("p=320.25,234.49998");
        }
        AccessRouters[numAccessRouters*numBackboneRouters]: Router {
            @display("p=439.24997,113.74999");
        }
        Users[numUsers*numAccessRouters*numBackboneRouters]: StandardHost {
            @display("p=586.25,233.62498;i=abstract/people2");
        }
        Internet: StandardHost {
            @display("p=46.374996,245.87498;i=misc/cloud");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=392,31;is=s");
        }

    connections:

		Internet.pppg++ <--> InternetGatewayChannel <--> Gateway.pppg++;

        for i=0..numBackboneRouters-1 {
            BackboneRouters[i].pppg++ <--> GatewayBackboneRouterChannel <--> Gateway.pppg++;
        }

        for i=0..numBackboneRouters-1, for j=0..numAccessRouters-1 {
            BackboneRouters[i].pppg++ <--> BackboneAccessRoutersChannel <--> AccessRouters[(i*numAccessRouters)+j].pppg++;

        }

        for i=0..(numBackboneRouters*numAccessRouters)-1, for j=0..numUsers-1 {
            AccessRouters[i].pppg++ <--> AccessRouterUserChannel <--> Users[(i*numUsers)+j].pppg++;

        }
        



}

