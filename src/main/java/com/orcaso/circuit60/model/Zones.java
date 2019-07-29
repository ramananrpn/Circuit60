package com.orcaso.circuit60.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "template_zones")
public class Zones {
    @Id
    @Column(name = "zone_id")
    private long zoneId;

//    Creating relation for zoneId
//    @OneToMany(mappedBy = "zoneId")
//    private Set<Zones> zoneMap;

//    Foreign Key from Templates
    @ManyToOne
    @JoinColumn(name = "template_id")
    private Templates templateId;

    @Column(name = "zone")
    private int zone;

    @Column(name = "seconds")
    private long seconds;

    @Column(name="reps")
    private int reps;

    @Column(name = "break_time")
    private long breakTime;

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

    public int getZone() {
        return zone;
    }

    public void setZone(int zone) {
        this.zone = zone;
    }

    public long getSeconds() {
        return seconds;
    }

    public void setSeconds(long seconds) {
        this.seconds = seconds;
    }

    public int getReps() {
        return reps;
    }

    public void setReps(int reps) {
        this.reps = reps;
    }

    public long getBreakTime() {
        return breakTime;
    }

    public void setBreakTime(long breakTime) {
        this.breakTime = breakTime;
    }
}
