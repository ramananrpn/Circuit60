package com.orcaso.circuit60.repository;

import com.orcaso.circuit60.model.Gym;
import com.orcaso.circuit60.model.Templates;
import com.orcaso.circuit60.model.Zones;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ZoneRepository extends CrudRepository<Zones , Long> {
    Boolean existsZonesByTemplateIdAndZone(Templates template , int zone);
}
