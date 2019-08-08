package com.orcaso.circuit60.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.orcaso.circuit60.model.*;
import com.orcaso.circuit60.repository.TemplateRepository;
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

    @Autowired
    TemplateRepository templateRepository;

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

//    Exercise Display
    @MessageMapping("/fetchExerciseDetails")
    @SendTo("/zone/client")
    public Display fetchExerciseDetails(@Payload SocketMessage clientMessage) {
        ObjectMapper mapper = new ObjectMapper();
        Display display = new Display();
        try{
            logger.info("----------- FetchExerciseDetails ControllerProcessing -------------");
            logger.info(" ===== zone :: " + clientMessage.getZone() + " ; templateId :: " + clientMessage.getTemplateId() + " =====");
            Templates currentTemplate = templateRepository.findTemplatesByTemplateId(clientMessage.getTemplateId());
            Zones currentZone = zoneRepository.findZonesByTemplateIdAndZone(currentTemplate , clientMessage.getZone());
            display.setTemplates(currentTemplate);
            display.setZones(currentZone);
            display.setCommand("display");
//            ApplicationController applicationController = new ApplicationController();
//            display.setExerciseDetails(applicationController.getSavedExercisesForZone(currentTemplate,clientMessage.getZone()));
            logger.info(currentZone.getExerciseDetails().toString());
            display.setExerciseDetails(currentZone.getExerciseDetails());
//            logger.info("!!!!!!!!!----------  EXCERCISE DETAILS :: " + exerciseDetails + " ------------!!!!!!!!!! ");
        }
        catch(Exception e){
            logger.error("Exception Occurred at fetchExerciseDetails :: " + e);
        }
        return  display;
    }

    public SocketMessage SendStartSessionCommand(@Payload SocketMessage adminCommand){
        logger.info(adminCommand.toString());
        return  adminCommand;
    }



}
