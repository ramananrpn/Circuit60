package com.orcaso.circuit60.model;

import java.util.List;

public class Display {
    private Zones zones;
    private  Templates templates ;
    private String command;
    private List<Exercise> exerciseDetails;

    public Zones getZones() {
        return zones;
    }

    public void setZones(Zones zones) {
        this.zones = zones;
    }

    public Templates getTemplates() {
        return templates;
    }

    public void setTemplates(Templates templates) {
        this.templates = templates;
    }

    public String getCommand() {
        return command;
    }

    public void setCommand(String command) {
        this.command = command;
    }

    public List<Exercise> getExerciseDetails() {
        return exerciseDetails;
    }

    public void setExerciseDetails(List<Exercise> exerciseDetails) {
        this.exerciseDetails = exerciseDetails;
    }
}
