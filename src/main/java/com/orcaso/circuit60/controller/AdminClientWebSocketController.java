package com.orcaso.circuit60.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class AdminClientWebSocketController {
    @MessageMapping
    @SendTo("")
    public void s(){

    }
}
