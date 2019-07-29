package com.orcaso.circuit60.repository;

import com.orcaso.circuit60.model.Gym;
import com.orcaso.circuit60.model.Templates;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TemplateRepository extends CrudRepository<Templates , String> {
    List<Templates> findAllByGymId(Gym gym);
    List<Templates> findTemplatesByGymId(Gym gymId);
}
