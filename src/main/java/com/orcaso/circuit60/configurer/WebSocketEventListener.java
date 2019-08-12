package com.orcaso.circuit60.configurer;


import com.orcaso.circuit60.controller.ApplicationController;
import com.orcaso.circuit60.model.SocketMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import static java.time.LocalDate.now;

@Component
public class WebSocketEventListener {

    private static final Logger logger = LoggerFactory.getLogger(WebSocketEventListener.class);

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;

    @EventListener
    public void handleWebSocketConnectListener(SessionConnectedEvent event ){
        try{
            logger.info(" -----------  Client Connected " + now() +" ------------");
        }
        catch (Exception e){
            logger.error("Exception Occurred at WebSocketEventListener :: " +  e);
        }

    }

    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());

        String connectedZone = (String) headerAccessor.getSessionAttributes().get("connectedZone");
        String connectedTimestamp = (String) headerAccessor.getSessionAttributes().get("connectedTimestamp");
        if(connectedZone != null &&connectedTimestamp!=null) {
            logger.info("Client Disconnected : " + connectedZone+"."+connectedTimestamp);
            SocketMessage socketMessage = new SocketMessage();
            socketMessage.setCommand("stop");
            messagingTemplate.convertAndSend("/zone/client."+connectedZone+"."+connectedTimestamp, socketMessage);
            ApplicationController.connectedZones.remove(connectedZone);
        }
    }
}
