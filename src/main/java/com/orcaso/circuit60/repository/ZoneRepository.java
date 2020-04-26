package com.orcaso.circuit60.repository;

import com.orcaso.circuit60.model.Gym;
import com.orcaso.circuit60.model.Templates;
import com.orcaso.circuit60.model.Zones;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface ZoneRepository extends CrudRepository<Zones , Long> {
    Boolean existsZonesByTemplateIdAndZone(Templates template , String zone);
    Zones findZonesByTemplateIdAndZone(Templates template , String zone);
    List<Zones> findAllZonesByTemplateId(Templates template);
}
