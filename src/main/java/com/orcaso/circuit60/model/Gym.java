package com.orcaso.circuit60.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "user_details")
public class Gym  {
    @Id
    @Column(name="gym_id")
    private String gymId;

    @Column(name = "password")
    private String password;

    @OneToMany(mappedBy = "gymId")
    private Set<Templates> templates;

    //    Getter Setters
    public String getGymId(){
        return gymId;
    }

    public void setGymId(String gymId) {
        this.gymId = gymId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Set<Templates> getTemplates() {
        return templates;
    }

    public void setTemplates(Set<Templates> templates) {
        this.templates = templates;
    }

}

