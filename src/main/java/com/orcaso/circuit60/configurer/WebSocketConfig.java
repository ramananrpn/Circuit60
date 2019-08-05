package com.orcaso.circuit60.configurer;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
//        Client EndPoint to connect
        registry.addEndpoint("/connectToAdmin" ).withSockJS();
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
//        client send to server with prefix "/admin" - used in messageMapping (from Client)
        config.setApplicationDestinationPrefixes("/admin");
//        TO Client from server
        config.enableSimpleBroker("/zone");
    }
}
