package com.orcaso.circuit60.repository;

import com.orcaso.circuit60.model.Templates;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TemplateRepository extends CrudRepository<Templates , Long> {
    Templates findTemplatesByTemplateId(Long templateId);
}
