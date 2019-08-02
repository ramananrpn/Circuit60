package com.orcaso.circuit60.model;

public class SocketMessage {
    private Long templateId;
    private String command;

//    getters & setters

    public Long getTemplateId() {
        return templateId;
    }

    public void setTemplateId(Long templateId) {
        this.templateId = templateId;
    }

    public String getCommand() {
        return command;
    }

    public void setCommand(String command) {
        this.command = command;
    }
}
