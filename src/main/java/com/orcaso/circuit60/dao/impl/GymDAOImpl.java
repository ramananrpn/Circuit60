package com.orcaso.circuit60.dao.impl;

import com.orcaso.circuit60.dao.GymDAO;
import com.orcaso.circuit60.model.Gym;
import com.orcaso.circuit60.repository.GymRepository;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.sql.*;

public class GymDAOImpl implements GymDAO {
    @Autowired
    GymRepository gymRepo ;

    public boolean login(String gymId, String password) {
//        Gym gym = gymRepo.findByAdmin(gymId);
//        if(gym==null){
//            return false;
//        }
//        else {
//            System.out.println(gym.getPassword());
            return true;
//        }
    }
}
