package com.orcaso.circuit60.model;

import org.springframework.data.annotation.CreatedDate;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.util.Date;

@Entity
@EntityListeners(AuditingEntityListener.class)
@Table(name = "gym_templates")
public class Templates {
    public int getExerciseDuration() {
		return exerciseDuration;
	}

	public void setExerciseDuration(int exerciseDuration) {
		this.exerciseDuration = exerciseDuration;
	}

	@Id
    @Column(name = "template_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long templateId;

    @Column(name = "template_name")
    private String templateName;

    @Column(name = "template_logo")
    private String templateLogo;

    @Column(name="active",columnDefinition = "Integer default 0")
    private int active;

    @Column(name="created_date",nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date createdAt;

    @Column(name = "last_updated_date",nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Date lastUpdatedDate;
    
    private int exerciseCount;
    private int exerciseDuration;
//    Getters & Setters

    public int getExerciseCount() {
		return exerciseCount;
	}

	public void setExerciseCount(int exerciseCount) {
		this.exerciseCount = exerciseCount;
	}
	
	public long getTemplateId() {
        return templateId;
    }
	
    public void setTemplateId(long templateId) {
        this.templateId = templateId;
    }

    public String getTemplateName() {
        return templateName;
    }

    public void setTemplateName(String templateName) {
        this.templateName = templateName;
    }

    public String getTemplateLogo() {
        return templateLogo;
    }

    public void setTemplateLogo(String templateLogo) {
        this.templateLogo = templateLogo;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
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
                ", templateName='" + templateName + '\'' +
                '}';
    }
}
