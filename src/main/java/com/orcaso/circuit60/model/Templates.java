package com.orcaso.circuit60.model;

import org.springframework.data.annotation.CreatedDate;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.util.Date;

@Entity
@EntityListeners(AuditingEntityListener.class)
@Table(name = "gym_templates")
public class Templates {
    @Id
    @Column(name = "template_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long templateId;

    @ManyToOne
    @JoinColumn(name = "gym_id")
    private Gym gymId;

    @Column(name = "template_name")
    private String templateName;

    @Column(name="created_date",nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date createdAt;

    @Column(name = "last_updated_date",nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date lastUpdatedDate;

//    Getters & Setters


    public long getTemplateId() {
        return templateId;
    }

    public void setTemplateId(long templateId) {
        this.templateId = templateId;
    }

    public Gym getGymId() {
        return gymId;
    }

    public void setGymId(Gym gymId) {
        this.gymId = gymId;
    }

    public String getTemplateName() {
        return templateName;
    }

    public void setTemplateName(String templateName) {
        this.templateName = templateName;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getLastUpdatedDate() {
        return lastUpdatedDate;
    }

    public void setLastUpdatedDate(Date lastUpdatedDate) {
        this.lastUpdatedDate = lastUpdatedDate;
    }

    @Override
    public String toString() {
        return "Templates{" +
                "templateId=" + templateId +
                ", gymId=" + gymId +
                ", templateName='" + templateName + '\'' +
                '}';
    }
}
