package com.orcaso.circuit60.repository;

import com.orcaso.circuit60.model.Gym;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;



@Repository
public interface GymRepository extends CrudRepository<Gym , String> {
    Gym findByGymId(String gymId);
}
