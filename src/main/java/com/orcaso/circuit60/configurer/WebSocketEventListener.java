package com.orcaso.circuit60.configurer;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
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
}
