package com.orcaso.circuit60.model;

import javax.persistence.*;

@Entity
@Table(name = "zone_exercise_relation")
public class ExcerciseRel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;

//    Foreign key zone_id from Zones
    @ManyToOne
    @JoinColumn(name = "zone_id")
    private Zones zoneId;

    @Column(name="category")
    private int category;

    @Column(name = "position")
    private int position;

    @Column(name = "media_path")
    private String mediaPath;

//    Getter Setters

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Zones getZoneId() {
        return zoneId;
    }

    public void setZoneId(Zones zoneId) {
        this.zoneId = zoneId;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public String getMediaPath() {
        return mediaPath;
    }

    public void setMediaPath(String mediaPath) {
        this.mediaPath = mediaPath;
    }
}
