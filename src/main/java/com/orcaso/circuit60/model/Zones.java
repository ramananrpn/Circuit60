package com.orcaso.circuit60.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.orcaso.circuit60.converter.StringMapConverter;

import javax.persistence.*;
import java.util.List;


@Entity
@Table(name = "template_zone_details")
public class Zones {
    @Id
    @Column(name = "zone_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long zoneId;

//    Creating relation for zoneId
//    @OneToMany(mappedBy = "zoneId")
//    private Set<Zones> zoneMap;

//    Foreign Key from Templates
    @ManyToOne
    @JoinColumn(name = "template_id")
    private Templates templateId;

    @Column(name = "zone")
    private String zone;

    @Column(name = "seconds" , columnDefinition = "int default 00")
    private int seconds;

    @Column(name="reps" , columnDefinition = "int default 1")
    private int reps;

    @Column(name = "break_time" , columnDefinition = "bigint default 00")
    private int breakTime;

    //    USED JSON DATATYPE - MAP to store exercise
//    Convert is used to convert Data from entity to dbcolumn and viceversa
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "exercise_relation", joinColumns = @JoinColumn(name = "zoneId"))
    @Column(name="exercise_details")
    @JsonIgnore
    private List<Exercise> exerciseDetails;


    //Getters & Setters

    public long getZoneId() {
        return zoneId;
    }

    public void setZoneId(long zoneId) {
        this.zoneId = zoneId;
    }


    public Templates getTemplateId() {
        return templateId;
    }

    public void setTemplateId(Templates templateId) {
        this.templateId = templateId;
    }

    public String getZone() {
        return zone;
    }

    public void setZone(String zone) {
        this.zone = zone;
    }

    public int getSeconds() {
        return seconds;
    }

    public void setSeconds(int seconds) {
        this.seconds = seconds;
    }

    public int getReps() {
        return reps;
    }

    public void setReps(int reps) {
        this.reps = reps;
    }

    public int getBreakTime() {
        return breakTime;
    }

    public void setBreakTime(int breakTime) {
        this.breakTime = breakTime;
    }

    public List<Exercise> getExerciseDetails() {
        return exerciseDetails;
    }

    public void setExerciseDetails(List<Exercise> exerciseDetails) {
        this.exerciseDetails = exerciseDetails;
    }
}
