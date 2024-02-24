package com.orcaso.circuit60;

import com.orcaso.circuit60.repository.GymRepository;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.domain.EntityScan;
//
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaAuditing
@EnableJpaRepositories("com.orcaso.circuit60.repository")
//@EntityScan("com.orcaso.circuit60.model")
//@ComponentScan({"com.orcaso.circuit60", "com.orcaso.circuit60.repository"})
public class Circuit60Application{


    public static void main(String[] args) {
        SpringApplication.run(Circuit60Application.class, args);
    }
//    @Override
//    public void run(String... args) {
//        System.out.println("Our DataSource is = " + dataSource);
//        Iterable<com.orcaso.circuit60.model.Gym> systemlist = systemRepository.findAll();
//        for (com.orcaso.circuit60.model.Gym systemmodel : systemlist) {
//            System.out.println("Here is a system: " + systemmodel.toString());
//        }
//    }
}
