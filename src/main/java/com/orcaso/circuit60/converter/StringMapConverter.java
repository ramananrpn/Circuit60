package com.orcaso.circuit60.converter;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.orcaso.circuit60.model.Exercise;

import java.io.IOException;
import java.util.*;
import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter
public class StringMapConverter implements AttributeConverter<List<Exercise>, String> {

    private static ObjectMapper mapper;

    static {
        // To avoid instantiating ObjectMapper again and again.
        mapper = new ObjectMapper();
    }

    @Override
    public String convertToDatabaseColumn(List<Exercise> data) {
        if (null == data) {
            // You may return null if you prefer that style
            return "{}";
        }

        try {
            return mapper.writeValueAsString(data);

        } catch (IOException e) {
            throw new IllegalArgumentException("Error converting map to JSON", e);
        }
    }

    @Override
    public List<Exercise> convertToEntityAttribute(String s) {
        if (null == s) {
            // You may return null if you prefer that style
            return new ArrayList<>();
        }

        try {
            return mapper.readValue(s, new TypeReference<List<Exercise>>() {});

        } catch (IOException e) {
            throw new IllegalArgumentException("Error converting JSON to List", e);
        }
    }
}
