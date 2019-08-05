package com.orcaso.circuit60.controller;

import com.orcaso.circuit60.model.SocketMessage;
import com.orcaso.circuit60.repository.ZoneRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminClientWebSocketController {

    private static final Logger logger = LoggerFactory.getLogger(AdminClientWebSocketController.class);

    @Autowired
    ZoneRepository zoneRepository;

//    New Client Joins a zone
    @MessageMapping("/newZoneClient")
    @SendTo("/zone/client")
    public SocketMessage newZoneClient(@Payload SocketMessage clientMessage , SimpMessageHeaderAccessor headerAccessor){
        try{
            headerAccessor.getSessionAttributes().put("connectedZone", clientMessage.getZone());
//        model.addAttribute("webZone" , clientMessage.getZone());
            logger.info("Message Received - " + clientMessage);
            logger.info("**********-------------  New Client Connected for " +  clientMessage.getZone() + " ----------------**********");
        }
        catch(Exception e){
            logger.error("Exception Occurred at webSocket :: " + e);
        }
        return clientMessage;
    }

    public SocketMessage SendStartSessionCommand(@Payload SocketMessage adminCommand){
        logger.info(adminCommand.toString());
        return  adminCommand;
    }



}
