// ========================================================================
//  Robot Server
//  by Ness Morris and Bruce Lott 
//  based on code by Ajay Kapur, Owen Vallis & Dimitri Diakopoulos
//  Music Technology: Interaction, Intelligence & Design, 2013
//  File: server.ck
// ========================================================================

BreakBot bBot;
MahaDevi maha;
GanaPati gana;
Clappers clap;
JackGuitar jtar;
JackBass jbas;
JackPerc jperc;

OscRecv orec;
11235=>orec.port;

OscSend toClient[0];
string clientNames[0];
OscSend toVisuals;

orec.event("/addClient,si")@=>OscEvent addClient;
orec.event("/addClient,s") @=>OscEvent addClientNoPort;
orec.event("/resetClients")@=>OscEvent resetClients;

orec.listen();
bBot.init(orec,toClient);
maha.init(orec,toClient);
gana.init(orec,toClient);
clap.init(orec,toClient);
jtar.init(orec,toClient);
jbas.init(orec,toClient);
jperc.init(orec,toClient);

spork~clientLoop();
spork~resetClientsLoop();
while(2::second=>now){
    for(int i;i<clientNames.size();i++)<<<clientNames[i]>>>;
}

fun void clientLoop(){
    int alreadyPresent;
    while(addClient=>now){
        addClient.nextMsg();
        addClient.getString()=>string hostname;
        addClient.getInt()=>int port;
        0=>alreadyPresent;
        for(int i;i<clientNames.size();i++){
            if(hostname==clientNames[i]){
                1=>alreadyPresent;
            }
        }
        if(!alreadyPresent){
            OscSend newSend;
            newSend.setHost(hostname,port);
            clientNames<<hostname;
            toClient<<newSend;
        }else cherr<="Client already present:"<=hostname<=IO.nl();
        
    }
}

fun void resetClientsLoop(){
    while(resetClients=>now){
        while(resetClients.nextMsg()){
            clientNames.clear();
            toClient.clear();
            chout<="Clients removed"<=IO.nl();
        }
    }
}